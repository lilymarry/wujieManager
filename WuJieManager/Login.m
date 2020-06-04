//
//  Login.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/6/13.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "Login.h"
#import "LoginModel.h"
#import "KeyChainStore.h"
@interface Login ()
{
    NSString *codeStr;
}
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (weak, nonatomic) IBOutlet UIButton *numBtn;
@property (strong, nonatomic) IBOutlet UITextField *userName_tf;
@property (strong, nonatomic) IBOutlet UITextField *pw_tf;

@end

@implementation Login

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _userName_tf.text=@"test";
    _pw_tf.text=@"Cc123456";
    
    _numLab.text=[self getUUIDByKeyChain];
    
    NSLog(@"机器码  %@",[self getUUIDByKeyChain]);
    
    
    [HttpManager checkTheUpdate:@"1342931428" responseResult:^(NSString * c1, NSString *c2, BOOL c3) {
        if ([self isNO:c1]) {
            self->codeStr=[self getUUIDByKeyChain];
            self->_numLab.hidden=NO;
            self->_numBtn.hidden=NO;
            
        }else{
            //固定机器码
            self->codeStr = @"95D34CA8-6A5B-41C8-8690-53576B2C2949";
            self->_numLab.hidden=YES;
            self->_numBtn.hidden=YES;
        }
      
        if (c3) { //用户版本 < appStore 进入
            
        }
        
    }];
    
    
}
- (NSString *)getUUIDByKeyChain{
    // 这个key的前缀最好是你的BundleID
    NSString*strUUID = (NSString*)[KeyChainStore load:@"www.wujiemall.com.bigScreen"];
    //首次执行该方法时，uuid为空
    if([strUUID isEqualToString:@""]|| !strUUID)
    {
        // 获取UUID 这个是要引入<AdSupport/AdSupport.h>的
        strUUID =[[UIDevice currentDevice] identifierForVendor].UUIDString;
        
        if(strUUID.length ==0 || [strUUID isEqualToString:@"00000000-0000-0000-0000-000000000000"])
        {
            //生成一个uuid的方法
            CFUUIDRef uuidRef= CFUUIDCreate(kCFAllocatorDefault);
            strUUID = (NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault,uuidRef));
            CFRelease(uuidRef);
        }
        
        //将该uuid保存到keychain
        [KeyChainStore save:@"www.wujiemall.com.bigScreen" data:strUUID];
    }
    return strUUID;
}

- (IBAction)numPress:(id)sender {
    
    [self getUUIDByKeyChain];
    
}

- (IBAction)submitPress:(id)sender {
    
    if (_userName_tf.text.length==0) {
        [MBProgressHUD showSuccess:@"请输入用户名" toView:self.view];
        return;
    }
    if (_pw_tf.text.length==0) {
        [MBProgressHUD showSuccess:@"请输入密码" toView:self.view];
        return;
    }
    
    LoginModel *model=[[LoginModel alloc]init];
    model.password=_pw_tf.text;
    model.code=codeStr;
    model.user_id=_userName_tf.text;
    
    [MBProgressHUD showMessage:nil toView:self.view];
    [model LoginModelSuccessBlock:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if ([code intValue]==200) {
            LoginModel *login=(LoginModel *)data;
            [model save:login.data];
            
          
            [[NSUserDefaults standardUserDefaults] setObject:login.data.access_token forKey:@"access_token"];
            [[NSUserDefaults standardUserDefaults] setObject:login.data.token_type forKey:@"token_type"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            TabBarController * tabBarController = [[TabBarController alloc] init];
            self.view.window.rootViewController = tabBarController;
            
            
        }
        
        
    } andFailure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - 判断版本号
- (BOOL)isNO:(NSString *)c1 {
    // app版本
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *localVerson = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    //将版本号按照.切割后存入数组中
    NSArray *localArray = [localVerson componentsSeparatedByString:@"."];
    NSMutableArray * localArray_sub = [[NSMutableArray alloc] init];
    [localArray_sub addObjectsFromArray:localArray];
    NSArray *appArray = [c1 componentsSeparatedByString:@"."];
    NSMutableArray * appArray_sub = [[NSMutableArray alloc] init];
    [appArray_sub addObjectsFromArray:appArray];
    
    NSInteger num = 0;//循环次数
    if (localArray_sub.count > appArray_sub.count) {
        num = localArray_sub.count;
        for (int i = 0; i < localArray_sub.count - appArray_sub.count; i++) {
            [appArray_sub addObject:@"0"];
        }
    }
    if (localArray_sub.count < appArray_sub.count) {
        num = appArray_sub.count;
        for (int i = 0; i < appArray_sub.count - localArray_sub.count; i++) {
            [localArray_sub addObject:@"0"];
        }
    }
    if (localArray_sub.count == appArray_sub.count) {
        num = localArray_sub.count;
    }
    if (localArray_sub == appArray_sub) {
        return NO;
    }
    for(int i = 0; i < num; i++){//以最短的数组长度为遍历次数,防止数组越界
        //取出每个部分的字符串值,比较数值大小
        if([localArray_sub[i] integerValue] > [appArray_sub[i] integerValue]) {
            //从前往后比较数字大小,一旦分出大小,跳出循环
            return NO;
        }
    }
    return YES;
}
@end
