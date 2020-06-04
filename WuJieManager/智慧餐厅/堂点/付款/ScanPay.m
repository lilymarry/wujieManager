//
//  ScanPay.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/7/26.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "ScanPay.h"
#import "ScanPayCodeView.h"
#import "PayModel.h"
#import <CommonCrypto/CommonDigest.h>
#import "PayStatus.h"
#import "PayFinishOrderDetail.h"
#import "OrderInfo.h"
#import "UserCenter.h"
@interface ScanPay ()<UITextFieldDelegate>
{
    int secondsCountDown; //倒计时总时长
    NSTimer *countDownTimer;
    ScanPayCodeView *codeView;
}
@property (weak, nonatomic) IBOutlet UIView *balanceView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *balanceViewHH;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UITextField *reallyMoneyTf;
@property (weak, nonatomic) IBOutlet UILabel *rechargeLab;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (nonatomic ,strong)NSString *payMoney;
@property (nonatomic ,assign)BOOL isHaveDian;

@end

@implementation ScanPay

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self createNav];
    
    self.title=[NSString stringWithFormat:@"%@收款",_type];
 

    _balanceView.hidden=YES;
    _balanceViewHH.constant=0;
   
    [self getData];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [countDownTimer invalidate];
    countDownTimer =nil;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (IBAction)surePress:(id)sender {
     PayModel *model=[[PayModel alloc]init];
    if (_reallyMoneyTf.text.length==0) {
        model.pay_price=_payMoney;
     
    }
    else if ([_reallyMoneyTf.text doubleValue]==0)
    {
          [self showMBProgressHUDOnKeyBoard:@"实收金额必须大于0"];
        return;
    }
    else
    {
         model.pay_price=_reallyMoneyTf.text;
    }
   
 
    model.order_sn=_order_sn;
    if ([_type isEqualToString:@"无界余额"]) {
        model.pay_type=@"1";
        
        
    }
    if ([_type isEqualToString:@"微信"]) {
        model.pay_type=@"2";
    }
    if ([_type isEqualToString:@"支付宝"]) {
        model.pay_type=@"3";
      
    }
    if ([_type isEqualToString:@"现金"]) {
        model.pay_type=@"4";
        model.order_sn=[self getCrashOrder_sn];
    }
    _submitBtn.backgroundColor=[UIColor lightGrayColor];
    _submitBtn.enabled=NO;
    [MBProgressHUD showMessage:nil toView:self.view];

    [model PayModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        _submitBtn.backgroundColor=color(242, 48, 48);
        _submitBtn.enabled=YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [MBProgressHUD showSuccess:message toView:self.view];
        });

        if ([code intValue]==200) {
            if ([_type isEqualToString:@"微信"]||[_type isEqualToString:@"支付宝"]) {
                PayModel *model=(PayModel *)data;
               codeView=[[ScanPayCodeView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
                codeView.urlStr=model.data.qrcode;
                [codeView loadCodeView];
                codeView.scanPayCodeViewBlock = ^{
                 [countDownTimer invalidate];
                 [codeView removeFromSuperview];
                    
                };
                [self.view.window addSubview:codeView];
                [codeView.repiteBtn addTarget:self action:@selector(repiteBtnPress:) forControlEvents:UIControlEventTouchUpInside];
                
                codeView.repiteBtn.hidden=YES;
                
                [countDownTimer invalidate];
                secondsCountDown = 60;//60秒倒计时
                countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
                [[NSRunLoop currentRunLoop] addTimer:countDownTimer  forMode:NSRunLoopCommonModes];
                
            }
            else
            {
                PayFinishOrderDetail *pay=[[PayFinishOrderDetail alloc]init];
                pay.order_sn=_order_sn;
                [self.navigationController pushViewController:pay animated:YES];
            }
          
        }
       
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];

}
-(void)timeFireMethod{
    //倒计时-1
    secondsCountDown--;
    
    codeView.timeLab.text=[NSString stringWithFormat:@"%ds后失效",secondsCountDown];
   
    if (secondsCountDown%3==0) {
        PayStatus *status=[[PayStatus alloc]init];
        status.order_sn=_order_sn;
        [status PayStatusSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
            
            if ([code intValue]==200) {
                [countDownTimer invalidate];
                [codeView removeFromSuperview];
                
                PayFinishOrderDetail *pay=[[PayFinishOrderDetail alloc]init];
                pay.order_sn=_order_sn;
                [self.navigationController pushViewController:pay animated:YES];
                
            }
        } andFailure:^(NSError * _Nonnull error) {
            [countDownTimer invalidate];
            [codeView removeFromSuperview];
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(secondsCountDown==0){
         [countDownTimer invalidate];
         codeView.repiteBtn.hidden=NO;
         codeView.timeLab.text=@"已失效";
    }
}
-(void)repiteBtnPress:(UIButton *)but
{
    [codeView removeFromSuperview];
     codeView.timeLab.text=@"60s后失效";
    [self surePress:nil];
}
-(NSString *)getCrashOrder_sn

{
    NSMutableString *str =[NSMutableString stringWithString:_reallyMoneyTf.text];
    [str appendString:_order_sn];
    [str appendString:@"27336"];
    NSString *str1=[self md5String:str];
    
    NSMutableString *str2 =[NSMutableString stringWithString:_order_sn];
    [str2 appendString:@"_"];
    [str2 appendString:_reallyMoneyTf.text];
    [str2 appendString:@"_"];
    [str2 appendString:str1];
    return str2;
}
- (void)createNav {
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"白色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    
    [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    /*
     * 不能输入.0-9以外的字符。
     * 设置输入框输入的内容格式
     * 只能有一个小数点
     * 小数点后最多能输入两位
     * 如果第一位是.则前面加上0.
     * 如果第一位是0则后面必须输入点，否则不能输入。
     */
    
    // 判断是否有小数点
    if ([textField.text containsString:@"."]) {
        self.isHaveDian = YES;
    }else{
        self.isHaveDian = NO;
    }
    
    if (string.length > 0) {
        
        //当前输入的字符
        unichar single = [string characterAtIndex:0];
        NSLog(@"single = %c",single);
        
        // 不能输入.0-9以外的字符
        if (!((single >= '0' && single <= '9') || single == '.'))
        {
            [self showMBProgressHUDOnKeyBoard:@"您的输入格式不正确"];
            return NO;
        }
        
        // 只能有一个小数点
        if (self.isHaveDian && single == '.') {
        
             [self showMBProgressHUDOnKeyBoard:@"最多只能输入一个小数点"];
            return NO;
        }
        
        // 如果第一位是.则前面加上0.
        if ((textField.text.length == 0) && (single == '.')) {
            textField.text = @"0";
        }
        
        // 如果第一位是0则后面必须输入点，否则不能输入。
        if ([textField.text hasPrefix:@"0"]) {
            if (textField.text.length > 1) {
                NSString *secondStr = [textField.text substringWithRange:NSMakeRange(1, 1)];
                if (![secondStr isEqualToString:@"."]) {
                
                     [self showMBProgressHUDOnKeyBoard:@"第二个字符需要是小数点"];
                   
                    return NO;
                }
            }else{
                if (![string isEqualToString:@"."]) {
               
                     [self showMBProgressHUDOnKeyBoard:@"第二个字符需要是小数点"];
                    
                    return NO;
                }
            }
        }
        
        // 小数点后最多能输入两位
        if (self.isHaveDian) {
            NSRange ran = [textField.text rangeOfString:@"."];
            // 由于range.location是NSUInteger类型的，所以这里不能通过(range.location - ran.location)>2来判断
            if (range.location > ran.location) {
                if ([textField.text pathExtension].length > 1) {
                   
                     [self showMBProgressHUDOnKeyBoard:@"小数点后最多有两位小数"];
                    
                    return NO;
                }
            }
        }
        
    }
    
    return YES;
}
-(void)showMBProgressHUDOnKeyBoard:(NSString *)title
{
    
    UIWindow *view = [[[UIApplication sharedApplication] delegate] window];
    NSArray *windows = [UIApplication sharedApplication].windows;
    for (id windowView in windows) {
        NSString *viewName = NSStringFromClass([windowView class]);
        if ([@"UIRemoteKeyboardWindow" isEqualToString:viewName]) {
            view = windowView;
            break;
        }
    }
    
    [MBProgressHUD showSuccess:title toView:view];
}

- ( NSString *)md5String:( NSString *)str {
    
    const char *myPasswd = [str UTF8String ];
    
    unsigned char mdc[ 16 ];
    
    CC_MD5 (myPasswd, ( CC_LONG ) strlen (myPasswd), mdc);
    
    NSMutableString *md5String = [ NSMutableString string ];
    
    for ( int i = 0 ; i< 16 ; i++) {
        //(x代表以十六进制形式输出,02代表不足两位，前面补0输出，如果超过两位，则以实际输出)
        [md5String appendFormat : @"%02x" ,mdc[i]];
        
    }
    
    return md5String;
    
}
-(void)getData
{
    
    OrderInfo *order=[[OrderInfo alloc]init];
    order.order_sn=_order_sn;
    [MBProgressHUD showMessage:nil toView:self.view];
    [order OrderInfoSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if ([code intValue]==200) {
            OrderInfo *list= (OrderInfo *)data;
            
            _moneyLab.text=[NSString stringWithFormat:@"¥%.2f",[list.data.total_price doubleValue]];
            _payMoney=list.data.total_price;
            _reallyMoneyTf.placeholder=[NSString stringWithFormat:@"请输入(默认金额%@)", _moneyLab.text];
            
        }
        else
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:message toView:self.view];
            });
        }
        
        
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
}

@end
