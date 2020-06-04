//
//  SRegisterResetPassword.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/23.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SRegisterResetPassword.h"

@implementation SRegisterResetPassword

- (void)sRegisterResetPasswordSuccess:(SRegisterResetPasswordSuccessBlock)success andFailure:(SRegisterResetPasswordFailureBlock)failure {
    [HttpManager postWithUrl:@"Register/resetPassword"  baseurl:Base_url  andParameters:@{@"phone":_phone,@"newPassword":_thisNewPassword,@"confirmPassword":_confirmPassword,@"verify":_verify} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
