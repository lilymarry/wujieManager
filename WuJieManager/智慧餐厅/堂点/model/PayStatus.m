//
//  PayStatus.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/8/12.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "PayStatus.h"

@implementation PayStatus
-(void)PayStatusSuccess:(PayStatusSuccessBlock)success andFailure:(PayStatusFaiulureBlock)failure
{
    [HttpManager postWithUrl:@"/api/pay_status"  baseurl:canyin_Base_url andParameters:@{@"order_sn":_order_sn} andSuccess:^(id Json) {
        
        NSDictionary * dic = (NSDictionary *)Json;
        NSLog(@"sss %@",dic);
        success(dic[@"code"],dic[@"message"],[PayStatus mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
