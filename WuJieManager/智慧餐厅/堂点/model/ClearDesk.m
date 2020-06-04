//
//  ClearDesk.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/8/8.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "ClearDesk.h"

@implementation ClearDesk
-(void)ClearDeskSuccess:(ClearDeskSuccessBlock)success andFailure:(ClearDeskFaiulureBlock)failure
{
    [HttpManager postWithUrl:@"/api/clearDesk"  baseurl:canyin_Base_url andParameters:@{@"desk_id":_desk_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"msg"],[ClearDesk mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
