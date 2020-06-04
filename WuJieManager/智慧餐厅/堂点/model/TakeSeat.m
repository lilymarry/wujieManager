//
//  TakeSeat.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/6/27.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "TakeSeat.h"

@implementation TakeSeat
-(void)TakeSeatSuccess:(TakeSeatSuccessBlock)success andFailure:(TakeSeatFaiulureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (SWNOTEmptyStr(self.take_id)) {
        [para setValue:self.take_id forKey:@"take_id"];
    }
    if (SWNOTEmptyStr(self.desk_id)) {
        [para setValue:self.desk_id forKey:@"desk_id"];
    }
    
    if (SWNOTEmptyStr(self.type)) {
        [para setValue:self.type forKey:@"type"];
    }
    if (SWNOTEmptyStr(self.meal_num)) {
        [para setValue:self.meal_num forKey:@"meal_num"];
    }
    if (SWNOTEmptyStr(self.phone)) {
        [para setValue:self.phone forKey:@"phone"];
    }
    if (SWNOTEmptyStr(self.code)) {
        [para setValue:self.code forKey:@"code"];
    }
    NSLog(@"ssssss %@",para);
    [HttpManager postWithUrl:@"/api/takeSeat"   baseurl:canyin_Base_url andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"msg"],[TakeSeat mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
