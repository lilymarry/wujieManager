//
//  PayType.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/8/12.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "PayTypeList.h"

@implementation PayTypeList
-(void)PayTypeListSuccess:(PayTypeListSuccessBlock)success andFailure:(PayTypeListFaiulureBlock)failure
{
[HttpManager postWithUrl:@"/api/ju_pay"  baseurl:canyin_Base_url andParameters:@{@"order_sn":_order_sn} andSuccess:^(id Json) {
    NSDictionary * dic = (NSDictionary *)Json;
    success(dic[@"code"],dic[@"message"],[PayTypeList mj_objectWithKeyValues:dic]);
} andFail:^(NSError *error) {
    failure(error);
}];
}
@end
