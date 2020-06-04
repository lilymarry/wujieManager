//
//  GetShopCart.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/7/19.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "GetShopCart.h"

@implementation GetShopCart
-(void)GetShopCartModelSuccess:(GetShopCartModelSuccessBlock)success andFailure:(GetShopCartModelFaiulureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (SWNOTEmptyStr(self.user_id)) {
        [para setValue:self.user_id forKey:@"user_id"];
    }
    if (SWNOTEmptyStr(self.menu_id)) {
        [para setValue:self.menu_id forKey:@"menu_id"];
    }
    if (SWNOTEmptyStr(self.desk_id)) {
        [para setValue:self.desk_id forKey:@"desk_id"];
    }
    [HttpManager postWithUrl:@"/api/serviceFetchShopCart"  baseurl:canyin_Base_url andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
         NSLog(@"GetShopCart.h  %@",dic);
        success(dic[@"code"],dic[@"msg"],[GetShopCart mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
