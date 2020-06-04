//
//  beginToEat.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/6.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "BeginToEat.h"
#import "RowNumDetailCell.h"
#import "BeginToEatContentView.h"
#import "RuZouDeskNumber.h"
#import "TakeSeat.h"
#import "OrderSubFood.h"
#import "BeginToEatNumView.h"
#import "SendSms.h"
@interface BeginToEat ()<UITableViewDelegate, UITableViewDataSource,BeginToEatDelegate,UITextFieldDelegate>

{
    NSMutableArray *dataArr;
    NSArray *deskArr;
    NSString *take_id;
    
    BOOL isShow;
    NSMutableDictionary *phoneDic;
    NSMutableDictionary *validationDic;
    
    int secondsCountDown; //倒计时总时长
    NSTimer *countDownTimer;
    
  
}
@property (weak, nonatomic) IBOutlet UITableView *mTable;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topHH;


@end

@implementation BeginToEat

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    self.title=@"桌面详情";
    isShow=NO;
    adjustsScrollViewInsets_NO(_mTable, self);
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([RowNumDetailCell class]) bundle:nil] forCellReuseIdentifier:@"RowNumDetailCell"];
    
    if (_name.length==0) {
        _name=@"";
    }

    dataArr=[NSMutableArray arrayWithObjects:
     @{@"title":@"排号",@"subTitle":@"选择号码"}.mutableCopy,
     @{@"title":@"桌号",@"subTitle":_name}.mutableCopy,
     @{ @"title":@"当前状态",@"subTitle":@"空闲中"}.mutableCopy,
     @{@"title":@"就餐人数",@"subTitle":@""}.mutableCopy,
     @{@"title":@"顾客角色",@"subTitle":@"选择顾客角色后开台"}.mutableCopy,
    nil];
    
   
    phoneDic= @{@"title":@"手机号码",@"subTitle":@""}.mutableCopy;
    validationDic= @{@"title":@"验证码",@"subTitle":@""}.mutableCopy;
    
    

    [self getData];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [countDownTimer invalidate];
    countDownTimer=nil;
}
-(void)getData
{
    RuZouDeskNumber *num=[[RuZouDeskNumber alloc]init];
    num.desk_id=_idStr;
    [num RuZouDeskNumberSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        if ([code intValue]==200) {
            RuZouDeskNumber *num=(  RuZouDeskNumber *)data;
             deskArr=[NSArray arrayWithArray:num.data];
            [_mTable reloadData];
        }
      
    } andFailure:^(NSError * _Nonnull error) {
        
    }];
}
-(void)createNav {
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"白色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -20, 0, 0);
    
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];

}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

            return dataArr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    RowNumDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:@"RowNumDetailCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
         cell.titleLab.text=dataArr[indexPath.row][@"title"];

        if ([cell.titleLab.text isEqualToString:@"顾客角色"]||[cell.titleLab.text isEqualToString:@"排号"]) {
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
         }
         else
         {
              cell.accessoryType=UITableViewCellAccessoryNone;
         }
    if ( [cell.titleLab.text isEqualToString:@"当前状态"]) {
        [ cell.subTitle setTextColor:color(7, 189, 24)];
    }
    else
    {
        [ cell.subTitle setTextColor:[UIColor blackColor]];
    }
         
         if ([cell.titleLab.text isEqualToString:@"就餐人数"]||[cell.titleLab.text isEqualToString:@"手机号码"]||[cell.titleLab.text isEqualToString:@"验证码"]) {
             cell.numTf.hidden=NO;
             cell.numTf.delegate=self;
             cell.numTf.text=dataArr[indexPath.row][@"subTitle"];
             cell.numTf.tag=indexPath.row;
            
             cell.subTitle.hidden=YES;
             if ([cell.titleLab.text isEqualToString:@"就餐人数"]) {
                  cell.numTf.placeholder=@"请输入人数";
             }
             else if ([cell.titleLab.text isEqualToString:@"手机号码"])
             {
                  cell.numTf.placeholder=@"输入用户手机号";
             }
             else
             {
                 
                 cell.numTf.placeholder=@"输入手机验证号";
             }
         }
         else
         {
             cell.numTf.hidden=YES;
             cell.subTitle.hidden=NO;
             cell.subTitle.text=dataArr[indexPath.row][@"subTitle"];
         }
         
         if ([cell.titleLab.text isEqualToString:@"验证码"]) {
             cell.valiBtnWW.constant=100;
             cell.valiBtn.hidden=NO;
             [cell.valiBtn addTarget:self action:@selector(valiBtnPress) forControlEvents:UIControlEventTouchUpInside];
             cell.tag=1000;
         }
         else
         {
           cell.valiBtnWW.constant=0;
            cell.valiBtn.hidden=YES;
         }
    return cell;

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 60;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    RowNumDetailCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        
    if ([cell.titleLab.text isEqualToString:@"排号"]) {
        BeginToEatNumView *nun=[[BeginToEatNumView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        [nun reloadTabView:deskArr];
        nun.topHHH.constant=100;
        nun.beginToEatNumViewBlock = ^(NSString * _Nonnull title, NSString * _Nonnull titleId) {
        dataArr[0][@"subTitle"] = title;
        take_id=titleId;
        [_mTable reloadData];
        };
        [self.view.window addSubview:nun];

    }
    if ([cell.titleLab.text isEqualToString:@"顾客角色"]) {
        [countDownTimer invalidate];
        countDownTimer=nil;
        

        
        BeginToEatContentView *view=[[BeginToEatContentView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        view.index=indexPath;
        
        view.delegate=self;
        view.title=cell.subTitle.text;
        
        [view loadContentView];
      
        [self.view.window addSubview:view];
    }

}
- (IBAction)submitPress:(id)sender {
  
    
    if (take_id.length==0) {
        [MBProgressHUD showSuccess:@"选择号码" toView:self.view];
        return;
    }

    NSString *numStr=dataArr[3][@"subTitle"];
    if (numStr.length==0) {
        [MBProgressHUD showSuccess:@"输入就餐人数" toView:self.view];
        return;
    }
   
    TakeSeat *seat=[[TakeSeat alloc]init];
    seat.meal_num=numStr;
    seat.desk_id=_idStr;
    seat.take_id=take_id;
    
    if (isShow) {
        seat.type=@"1";
        NSString * phone=phoneDic[@"subTitle"];
        if (phone.length==0) {
            [MBProgressHUD showSuccess:@"请输入手机号" toView:self.view];
            return;
        }
        seat.phone=phone;
         NSString * code=validationDic[@"subTitle"];
        if (code.length==0) {
            [MBProgressHUD showSuccess:@"请输入验证码" toView:self.view];
            return;
        }
        seat.code=code;
    }
    else
    {
        seat.type=@"2";
    }

     [MBProgressHUD showMessage:nil toView:self.view];
    [seat TakeSeatSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        if ([code intValue]==200) {
            TakeSeat *seat=( TakeSeat *)data;
            OrderSubFood *sub=[[OrderSubFood alloc]init];
            sub.desk_id=_idStr;
            sub.uidStr=seat.data.uid;
            [self.navigationController pushViewController:sub animated:YES];
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
-(void)beginToEaWithArr:(NSString *)name andType:(NSString *)type index:(nonnull NSIndexPath *)index
{
     RowNumDetailCell *cell=  [_mTable viewWithTag:1000];
    [cell.numTf resignFirstResponder];
    dataArr[index.row][@"subTitle"] = name;
    if ([type isEqualToString:@"1"]) {
        if (isShow==NO) {
            [dataArr addObject:phoneDic];
            [dataArr addObject:validationDic];
            
            isShow=YES;
            
        }
     
    }
    else
    {
        if (isShow==YES) {
            [dataArr removeObject:phoneDic];
            [dataArr removeObject:validationDic];
            isShow=NO;
        }
    }
   
    cell.valiBtn .enabled=YES;
    
    secondsCountDown=60;
    [cell.valiBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [cell.valiBtn setBackgroundColor:color(255, 100, 85)];
    [_mTable reloadData];
    
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    NSIndexPath *index=[NSIndexPath indexPathForRow:textField.tag inSection:0];
   RowNumDetailCell *cell=  [_mTable cellForRowAtIndexPath:index];
    if ([cell.titleLab.text isEqualToString:@"就餐人数"]||[cell.titleLab.text isEqualToString:@"手机号码"]||[cell.titleLab.text isEqualToString:@"验证码"]) {
          dataArr[index.row][@"subTitle"] = textField.text;
    }
      [_mTable performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];

    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
     return [self validateNumber:string];
    
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
-(void)valiBtnPress
{
    NSString * phone=phoneDic[@"subTitle"];
    if (phone.length==0) {
        [MBProgressHUD showSuccess:@"请输入手机号" toView:self.view];
        return;
    }
    NSString *str =[ValiMobile valiMobile:phone];
    if (str.length>0) {
        [MBProgressHUD showSuccess:str toView:self.view];
        return;
    }
    secondsCountDown = 60;//60秒倒计时
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 timeFireMethod
   [[NSRunLoop currentRunLoop] addTimer:countDownTimer  forMode:NSRunLoopCommonModes];
 
    SendSms *send=[[SendSms alloc]init];
 
    send.mobile=phone;
    send.type=@"login";
    send.mid=[[LoginModel shareInstance] getUserInfo].user_info.merchant_id;
    [send SendSmsSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if([code intValue]==200)
            [MBProgressHUD showSuccess:@"手机号发送成功" toView:self.view];
           else
           {
               [MBProgressHUD showSuccess:@"手机号发送失败" toView:self.view];
           }
        });
     
    } andFailure:^(NSError * _Nonnull error) {

    }];
   
    
}
-(void)timeFireMethod{
    //倒计时-1
    secondsCountDown--;
    //修改倒计时标签现实内容
    RowNumDetailCell *cell=  [_mTable viewWithTag:1000];
    [cell.valiBtn setTitle:[NSString stringWithFormat:@"%d后重新发送",secondsCountDown] forState:UIControlStateNormal];
    
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(secondsCountDown==0){
        [countDownTimer invalidate];
        cell.valiBtn.enabled = YES;
        [cell.valiBtn setTitle:@"重新发送" forState:UIControlStateNormal];
        [cell.valiBtn setBackgroundColor:color(255, 100, 85)];
    } else {
        cell.valiBtn.enabled = NO;
        [cell.valiBtn setBackgroundColor:WordColor_sub_sub];
    }
}
@end
