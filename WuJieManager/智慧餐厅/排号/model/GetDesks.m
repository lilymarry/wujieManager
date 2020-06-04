//
//  GetDesks.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/6/4.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "GetDesks.h"

@implementation GetDesks
-(void)GetDesksSuccess:(GetDesksSuccessBlock)success andFailure:(GetDesksFaiulureBlock)failure
{
    [HttpManager postWithUrl:@"/api/getDesks"   baseurl:canyin_Base_url andParameters:@{@"num_state":_num_state} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [GetDesks mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"desk_info":@"GetDesks",@"num_list":@"GetDesks"};
        }];
        success(dic[@"code"],dic[@"msg"],[GetDesks mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
