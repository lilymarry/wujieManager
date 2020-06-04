//
//  SendSms.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/8/7.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "SendSms.h"

@implementation SendSms
-(void)SendSmsSuccess:(SendSmsSuccessBlock)success andFailure:(SendSmsFaiulureBlock)failure;
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.mid)) {
        [para setValue:self.mid forKey:@"mid"];
    }
    if (SWNOTEmptyStr(self.type)) {
        [para setValue:self.type forKey:@"type"];
    }
    if (SWNOTEmptyStr(self.mobile)) {
        [para setValue:self.mobile forKey:@"mobile"];
    }
    
    [HttpManager postWithUrl:@"/api/sendSms"  baseurl:canyin_Base_url andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SendSms mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
