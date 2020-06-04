//
//  ChangeDesks.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/6/4.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "ChangeDesks.h"

@implementation ChangeDesks
- (void)ChangeDesksSuccess:(ChangeDesksSuccessBlock)success andFailure:(ChangeDesksFailureBlock)failure
{
    [HttpManager postWithUrl:@"changeDesks"  baseurl:canyin_Base_url andParameters:@{@"id":_id,@"new_desk_id":_desk_new_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
           success(dic[@"code"],dic[@"msg"],[ChangeDesks mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
