//
//  UserCenter.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/8/12.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "UserCenter.h"

@implementation UserCenter
-(void)UserCenterSuccess:(UserCenterSuccessBlock)success andFailure:(UserCenterFaiulureBlock)failure
{
    [HttpManager postWithUrl:@"/api/userCenter"  baseurl:canyin_Base_url andParameters:@{@"type":_type,@"uid":_uid} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[UserCenter mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
