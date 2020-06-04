//
//  InfoDetail.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/6/4.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "NumInfoDetailModel.h"

@implementation NumInfoDetailModel
-(void)InfoDetailSuccess:(InfoDetailSuccessBlock)success andFailure:(InfoDetailFaiulureBlock)failure
{
    [HttpManager postWithUrl:@"/api/infoDetail"  baseurl:canyin_Base_url andParameters:@{@"id":_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"msg"],[NumInfoDetailModel mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
