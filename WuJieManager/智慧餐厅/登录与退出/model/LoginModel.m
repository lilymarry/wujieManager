//
//  LoginModel.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/6/13.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "LoginModel.h"
#define kFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"CookUser.data"]
@implementation LoginModel
static LoginModel * login = nil;
+ (instancetype)shareInstance {
    @synchronized(self) {
        if (login == nil)
            login = [[self alloc] init];
    }
    return login;
}
- (CookUser *)getUserInfo {
    CookUser * user = [NSKeyedUnarchiver unarchiveObjectWithFile:kFile];
    return user;
}
- (void)save:(CookUser *)userInfo {
    [NSKeyedArchiver archiveRootObject:userInfo toFile:kFile];
}
- (void)deleteUserInfo {
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    if ([defaultManager isDeletableFileAtPath:kFile]) {
        [defaultManager removeItemAtPath:kFile error:nil];
    }
    
}

-(void)LoginModelSuccessBlock:(LoginModelSuccessBlock)success andFailure:(LoginModelFaiulureBlock)failure
{
    [HttpManager postWithUrl:@"/api/serverToken" baseurl:canyin_Base_url andParameters:@{@"user_id":_user_id,@"password":_password,@"code":_code}  andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;

       success(dic[@"code"],dic[@"msg"],[LoginModel mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
