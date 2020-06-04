//
//  OrderInfo.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/7/26.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "OrderInfo.h"

@implementation OrderInfo
-(void)OrderInfoSuccess:(OrderInfoSuccessBlock)success andFailure:(OrderInfoFaiulureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (SWNOTEmptyStr(self.order_sn)) {
        [para setValue:self.order_sn forKey:@"order_sn"];
    }
    if (SWNOTEmptyStr(self.status)) {
        [para setValue:self.status forKey:@"status"];
    }
    
    
    [HttpManager postWithUrl:@"/api/orderInfo"  baseurl:canyin_Base_url andParameters:para andSuccess:^(id Json) {
        
        NSDictionary * dic = (NSDictionary *)Json;
        [OrderInfo mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"dish":@"OrderInfo",@"dish_replace":@"OrderInfo",@"dish_add":@"OrderInfo"};
        }];
        success(dic[@"code"],dic[@"message"],[OrderInfo mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end

