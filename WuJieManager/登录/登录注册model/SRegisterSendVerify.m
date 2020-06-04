//
//  SRegisterSendVerify.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/23.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SRegisterSendVerify.h"

@implementation SRegisterSendVerify

- (void)sRegisterSendVerifySuccess:(SRegisterSendVerifySuccessBlock)success andFailure:(SRegisterSendVerifyFailureBlock)failure {
    [HttpManager postWithUrl:@"Register/sendVerify"  baseurl:Base_url andParameters:@{@"phone":_phone,@"type":_type} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
