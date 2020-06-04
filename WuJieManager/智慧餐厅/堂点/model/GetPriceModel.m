//
//  GetPriceModel.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/7/9.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "GetPriceModel.h"

@implementation GetPriceModel
-(void)GetPriceModelSuccess:(GetPriceModelSuccessBlock)success andFailure:(GetPriceModelFaiulureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (SWNOTEmptyStr(self.id)) {
        [para setValue:self.id forKey:@"id"];
    }
    if (SWNOTEmptyStr(self.is_dining)) {
        [para setValue:self.is_dining forKey:@"is_dining"];
    }
    
    if (SWNOTEmptyStr(self.num)) {
        [para setValue:self.num forKey:@"num"];
    }
    
    if (SWNOTEmptyStr(self.type)) {
        [para setValue:self.type forKey:@"type"];
    }
    if (SWNOTEmptyStr(self.norm_id)) {
        [para setValue:self.norm_id forKey:@"norm_id"];
    }
    
    if (SWNOTEmptyStr(self.taste_id)) {
        [para setValue:self.taste_id forKey:@"taste_id"];
    }
    if (SWNOTEmptyStr(self.add)) {
        [para setValue:self.add forKey:@"add"];
    }
    if (SWNOTEmptyStr(self.dish)) {
        [para setValue:self.dish forKey:@"dish"];
    }

    [HttpManager postWithUrl:@"/api/serverGetPrice"  baseurl:canyin_Base_url andParameters:para andSuccess:^(id Json) {
       
        NSDictionary * dic = (NSDictionary *)Json;
         
    success(dic[@"code"],dic[@"msg"],[GetPriceModel mj_objectWithKeyValues:dic]);
          
          
       
     
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
