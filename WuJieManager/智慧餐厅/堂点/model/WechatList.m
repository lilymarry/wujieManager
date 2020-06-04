//
//  WechatList.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/8/7.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WechatList.h"

@implementation WechatList
-(void)WechatListSuccess:(WechatListSuccessBlock)success andFailure:(WechatListFaiulureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.type)) {
        [para setValue:self.type forKey:@"type"];
    }
    
    if (SWNOTEmptyStr(self.mid)) {
        [para setValue:self.mid forKey:@"mid"];
    }
    if (SWNOTEmptyStr(self.url)) {
        [para setValue:self.url forKey:@"url"];
    }
    
    if (SWNOTEmptyStr(self.appid)) {
        [para setValue:self.appid forKey:@"appid"];
    }
    if (SWNOTEmptyStr(self.secret)) {
        [para setValue:self.secret forKey:@"secret"];
    }
    
    if (SWNOTEmptyStr(self.open_id)) {
        [para setValue:self.open_id forKey:@"open_id"];
    }
    
    if (SWNOTEmptyStr(self.head_pic)) {
        [para setValue:self.head_pic forKey:@"head_pic"];
    }
    
    if (SWNOTEmptyStr(self.phone)) {
        [para setValue:self.phone forKey:@"phone"];
    }
    if (SWNOTEmptyStr(self.code)) {
        [para setValue:self.code forKey:@"code"];
    }
    
    if (SWNOTEmptyStr(self.password)) {
        [para setValue:self.password forKey:@"password"];
    }
    if (SWNOTEmptyStr(self.confirmPassword)) {
        [para setValue:self.confirmPassword forKey:@"confirmPassword"];
    }
    
    if (SWNOTEmptyStr(self.nePassword)) {
        [para setValue:self.nePassword forKey:@"newPassword"];
    }
    
    [HttpManager postWithUrl:@"/api/wechat"  baseurl:canyin_Base_url andParameters:para andSuccess:^(id Json) {
        
        NSDictionary * dic = (NSDictionary *)Json;
        //        [DineOrderList mj_setupObjectClassInArray:^NSDictionary *{
        //            return @{@"data":@"DineOrderList"};
        //        }];
        success(dic[@"code"],dic[@"msg"],[WechatList mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
