//
//  OrderFoodSet.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/7/26.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "OrderFoodSet.h"

@implementation OrderFoodSet
-(void)OrderFoodSetSuccess:(OrderFoodSetSuccessBlock)success andFailure:(OrderFoodSetFaiulureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (SWNOTEmptyStr(self.server_id)) {
        [para setValue:self.server_id forKey:@"server_id"];
    }
    if (SWNOTEmptyStr(self.order_id)) {
        [para setValue:self.order_id forKey:@"order_id"];
    }
    if (SWNOTEmptyStr(self.type)) {
        [para setValue:self.type forKey:@"type"];
    }
    if (SWNOTEmptyStr(self.back)) {
        [para setValue:self.back forKey:@"back"];
    }
    if (SWNOTEmptyStr(self.remark)) {
        [para setValue:self.remark forKey:@"remark"];
    }
    if (SWNOTEmptyArr(self.dish)) {
        [para setValue:[ ExChangeJson ArrToJSONString:self.dish]  forKey:@"dish"];
    }
    
    [HttpManager postWithUrl:@"/api/orderDishSet"  baseurl:canyin_Base_url andParameters:para andSuccess:^(id Json) {
        
        NSDictionary * dic = (NSDictionary *)Json;
     
        success(dic[@"code"],dic[@"message"],[OrderFoodSet mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
