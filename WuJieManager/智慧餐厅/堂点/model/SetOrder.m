//
//  SetOrder.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/7/26.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "SetOrder.h"

@implementation SetOrder
-(void)SetOrderSuccess:(SetOrderSuccessBlock)success andFailure:(SetOrderFaiulureBlock)failure
{
   // ,@"server_id":_server_id
    [HttpManager postWithUrl:@"/api/setOrder"  baseurl:canyin_Base_url
               andParameters:@{@"id":_id,@"desk_id":_desk_id,@"source":_source} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SetOrder mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
