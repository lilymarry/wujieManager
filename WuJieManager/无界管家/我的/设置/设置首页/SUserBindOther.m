//
//  SUserBindOther.m
//  SuperiorAcme
//
//  Created by GYM on 2017/10/18.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserBindOther.h"

@implementation SUserBindOther

- (void)sUserBindOtherSuccess:(SUserBindOtherSuccessBlock)success andFailure:(SUserBindOtherFailureBlock)failure {
    [HttpManager postWithUrl:@"User/bindOther" baseurl:Base_url andParameters:@{@"openid":_openid,@"type":_type,@"nickname":_nickname} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
- (void)sUserBindOtherAlipay_infoSuccess:(SUserBindOtherAlipay_infoSuccessBlock)success andFailure:(SUserBindOtherFailureBlock)failure
{
    [HttpManager postWithUrl:@"User/alipay_info" baseurl:Base_url andParameters:@{@"auth_code":_auth_code} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],dic[@"data"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
