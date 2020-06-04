//
//  OrderFoodAtterModel.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/7/5.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "OrderFoodAtterModel.h"

@implementation OrderFoodAtterModel
-(void)OrderFoodAtterModelSuccess:(OrderFoodAtterModelSuccessBlock)success andFailure:(OrderFoodAtterModelFaiulureBlock)failure
{
    [HttpManager getWithUrl:@"/api/serverGetDishInfo"  baseurl:canyin_Base_url andParameters:@{@"id":_id,@"type":_type} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
     
        [OrderFoodAtterModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"dishList":@"OrderFoodAtterModel",@"dishes_taste_diff":@"OrderFoodAtterModel",@"dishes_type_diff":@"OrderFoodAtterModel",@"dishes_type_list":@"OrderFoodAtterModel",@"dishAdd":@"OrderFoodAtterModel",@"dishNorms":@"OrderFoodAtterModel",@"dishTaste":@"OrderFoodAtterModel",@"dishMaterial":@"OrderFoodAtterModel",@"data_one":@"OrderFoodAtterModel",@"data_two":@"OrderFoodAtterModel"};
        }];
        
        
        success(dic[@"code"],dic[@"msg"],[OrderFoodAtterModel mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             // 模型属性: JSON key, MJExtension 会自动将 JSON 的 key 替换为你模型中需要的属性
             @"Default":@"default",
             @"desc":@"description",
             };
}
@end
