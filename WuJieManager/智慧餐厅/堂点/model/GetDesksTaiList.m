//
//  GetDesksTaiList.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/6/27.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "GetDesksTaiList.h"

@implementation GetDesksTaiList
-(void)GetDesksTaiListSuccess:(GetDesksTaiListSuccessBlock)success andFailure:(GetDesksTaiListFaiulureBlock)failure
{
    [HttpManager getWithUrl:@"/api/getDesksTai"   baseurl:canyin_Base_url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [GetDesksTaiList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"desk_list":@"GetDesksTaiList",@"child":@"GetDesksTaiList",@"desk_type_list":@"GetDesksTaiList",@"desk_data":@"GetDesksTaiList",@"order_list":@"GetDesksTaiList"};
        }];
        success(dic[@"code"],dic[@"msg"],[GetDesksTaiList mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
