//
//  DelectToken.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/7/24.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "DelectToken.h"

@implementation DelectToken
-(void)DelectTokenSuccessBlock:(DelectTokenSuccessBlock)success andFailure:(DelectTokenFaiulureBlock)failure
{
    [HttpManager deleteWithUrl:@"/api/token/servercurrent" baseurl:canyin_Base_url andParameters:@{}  andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        
        success(dic[@"code"],dic[@"msg"]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
