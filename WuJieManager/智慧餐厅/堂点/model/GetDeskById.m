//
//  GetDeskById.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/9/3.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "GetDeskById.h"

@implementation GetDeskById
-(void)GetDeskByIdSuccess:(GetDeskByIdSuccessBlock)success andFailure:(GetDeskByIdFaiulureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.desk_id)) {
        [para setValue:self.desk_id forKey:@"id"];
    }
    
    [HttpManager postWithUrl:@"/api/getDeskById"  baseurl:canyin_Base_url andParameters:para andSuccess:^(id Json) {
        
        NSDictionary * dic = (NSDictionary *)Json;
        
        success(dic[@"code"],dic[@"msg"],[GetDeskById mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
