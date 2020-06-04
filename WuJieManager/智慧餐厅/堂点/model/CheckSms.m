//
//  CheckSms.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/8/7.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "CheckSms.h"

@implementation CheckSms
-(void)CheckSmsSuccess:(CheckSmsSuccessBlock)success andFailure:(CheckSmsFaiulureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.code)) {
        [para setValue:self.code forKey:@"code"];
    }
 
    if (SWNOTEmptyStr(self.mobile)) {
        [para setValue:self.mobile forKey:@"mobile"];
    }
    
    [HttpManager postWithUrl:@"/api/dine_order_list"  baseurl:canyin_Base_url andParameters:para andSuccess:^(id Json) {
        
        NSDictionary * dic = (NSDictionary *)Json;
        //        [DineOrderList mj_setupObjectClassInArray:^NSDictionary *{
        //            return @{@"data":@"DineOrderList"};
        //        }];
        success(dic[@"code"],dic[@"msg"],[CheckSms mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
