//
//  DelectShopCart.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/7/22.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "DelectShopCart.h"

@implementation DelectShopCart
-(void)DelectShopCartSuccess:(DelectShopCartSuccessBlock)success andFailure:(DelectShopCartFaiulureBlock)failure;
{
    [HttpManager postWithUrl:@"/api/serviceClearShopCart"  baseurl:canyin_Base_url andParameters:@{@"id":_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
       
        success(dic[@"code"],dic[@"msg"]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
