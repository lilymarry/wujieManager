//
//  RuZouDeskNumber.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/6/27.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "RuZouDeskNumber.h"

@implementation RuZouDeskNumber
-(void)RuZouDeskNumberSuccess:(RuZouDeskNumberSuccessBlock)success andFailure:(RuZouDeskNumberFaiulureBlock)failure
{
    [HttpManager postWithUrl:@"/api/getDeskTakeNumber"   baseurl:canyin_Base_url andParameters:@{@"desk_id":_desk_id} andSuccess:^(id Json) {
    NSDictionary * dic = (NSDictionary *)Json;
    [RuZouDeskNumber mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"data":@"RuZouDeskNumber"};
    }];
    success(dic[@"code"],dic[@"msg"],[RuZouDeskNumber mj_objectWithKeyValues:dic]);
    
} andFail:^(NSError *error) {
    failure(error);
}];
}
@end
