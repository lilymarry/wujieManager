//
//  OrderFoodListModel.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/7/4.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "OrderFoodListModel.h"

@implementation OrderFoodListModel
-(void)OrderFoodListModelSuccess:(OrderFoodListModelSuccessBlock)success andFailure:(OrderFoodListModelFaiulureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (SWNOTEmptyStr(self.channel)) {
        [para setValue:self.channel forKey:@"channel"];
    }
    if (SWNOTEmptyStr(self.desk_id)) {
        [para setValue:self.desk_id forKey:@"desk_id"];
    }
    
    if (SWNOTEmptyStr(self.menu_id)) {
        [para setValue:self.menu_id forKey:@"menu_id"];
    }
    
  
    [HttpManager postWithUrl:@"/api/serverDineOrder"  baseurl:canyin_Base_url andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [OrderFoodListModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"menus":@"OrderFoodListModel",@"category_caipin":@"OrderFoodListModel",@"menu_list":@"OrderFoodListModel",@"child":@"OrderFoodListModel"};
        }];
        
        
        success(dic[@"code"],dic[@"msg"],[OrderFoodListModel mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             // 模型属性: JSON key, MJExtension 会自动将 JSON 的 key 替换为你模型中需要的属性
         
             @"desc":@"description",
             };
}
@end
