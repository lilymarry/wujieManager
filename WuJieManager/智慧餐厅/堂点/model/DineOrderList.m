//
//  DineOrderList.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/8/6.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "DineOrderList.h"

@implementation DineOrderList
-(void)DineOrderListSuccess:(DineOrderListSuccessBlock)success andFailure:(DineOrderListFaiulureBlock)failure
{
       NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.mid)) {
        [para setValue:self.mid forKey:@"mid"];
    }
    if (SWNOTEmptyStr(self.type)) {
        [para setValue:self.type forKey:@"type"];
    }
    if (SWNOTEmptyStr(self.desk_id)) {
        [para setValue:self.desk_id forKey:@"desk_id"];
    }
    
    [HttpManager postWithUrl:@"/api/dine_order_list"  baseurl:canyin_Base_url andParameters:para andSuccess:^(id Json) {
        
        NSDictionary * dic = (NSDictionary *)Json;
        [DineOrderList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"order_info":@"DineOrderList"};
        }];
        success(dic[@"code"],dic[@"msg"],[DineOrderList mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
