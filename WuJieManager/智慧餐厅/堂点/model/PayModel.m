//
//  BalancePay.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/8/12.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "PayModel.h"

@implementation PayModel
-(void)PayModelSuccess:(PayModelSuccessBlock)success andFailure:(PayModelFaiulureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if ([self.pay_type isEqualToString:@"4"]) {
        if (SWNOTEmptyStr(self.order_sn)) {
            [para setValue:self.order_sn forKey:@"order_sn"];
        }
    }
    else
    {
        if (SWNOTEmptyStr(self.pay_type)) {
            [para setValue:self.pay_type forKey:@"pay_type"];
        }
        
        if (SWNOTEmptyStr(self.order_sn)) {
            [para setValue:self.order_sn forKey:@"order_sn"];
        }
        if (SWNOTEmptyStr(self.pay_price)) {
            [para setValue:self.pay_price forKey:@"pay_price"];
        }
    }
    
    NSString *url=@"";
    if ([self.pay_type isEqualToString:@"1"]) {
        url=@"/api/balance_pay";
    }
    else if ([self.pay_type isEqualToString:@"2"]||[self.pay_type isEqualToString:@"3"]) {
        url=@"/api/get_qrcode";
    }
    
    else if ([self.pay_type isEqualToString:@"4"])
    {
        url=@"/api/cash_pay";
    }
    
    [HttpManager postWithUrl:url  baseurl:canyin_Base_url andParameters:para andSuccess:^(id Json) {
        
        NSDictionary * dic = (NSDictionary *)Json;
        
        success(dic[@"code"],dic[@"message"],[PayModel mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
