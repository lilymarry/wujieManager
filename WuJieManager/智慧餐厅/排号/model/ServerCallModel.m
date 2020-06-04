//
//  ServerCallModel.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/6/26.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "ServerCallModel.h"

@implementation ServerCallModel
-(void)ServerCallModelSuccess:(ServerCallModelSuccessBlock)success andFailure:(ServerCallModelFaiulureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (SWNOTEmptyStr(self.desk_id)) {
        [para setValue:self.desk_id forKey:@"desk_id"];
    }
    if (SWNOTEmptyStr(self.num_state)) {
        [para setValue:self.num_state forKey:@"num_state"];
    }
    
    if (SWNOTEmptyStr(self.desk)) {
        [para setValue:self.desk forKey:@"desk"];
    }
    [HttpManager postWithUrl:@"/api/serverCall"   baseurl:canyin_Base_url andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"msg"],[ServerCallModel mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
