//
//  ChangeNumberType.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/6/4.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "ChangeNumberType.h"

@implementation ChangeNumberType
- (void)ChangeNumberTypeSuccess:(ChangeNumberTypeSuccessBlock)success andFailure:(ChangeNumberTypeFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (SWNOTEmptyStr(self.id)) {
        [para setValue:self.id forKey:@"id"];
    }
    if (SWNOTEmptyStr(self.type_value)) {
        [para setValue:self.type_value forKey:@"type_value"];
    }
    
    if (SWNOTEmptyStr(self.desk_id)) {
        [para setValue:self.desk_id forKey:@"desk_id"];
    }
    
    [HttpManager postWithUrl:@"changeNumberType"  baseurl:canyin_Base_url andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"msg"],dic[@"data"]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
