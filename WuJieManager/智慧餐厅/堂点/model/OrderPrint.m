//
//  OrderPrint.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/8/15.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "OrderPrint.h"

@implementation OrderPrint
-(void)OrderPrintSuccess:(OrderPrintSuccessBlock)success andFailure:(OrderPrintFaiulureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.order_sn)) {
        [para setValue:self.order_sn forKey:@"order_sn"];
    }
    
    if (SWNOTEmptyStr(self.merchant_id)) {
        [para setValue:self.merchant_id forKey:@"merchant_id"];
    }
    if (SWNOTEmptyStr(self.only_front)) {
        [para setValue:self.only_front forKey:@"only_front"];
    }
    
    [HttpManager postWithUrl:@"/api/print"  baseurl:canyin_Base_url andParameters:para andSuccess:^(id Json) {
        
        NSDictionary * dic = (NSDictionary *)Json;
      
        success(dic[@"code"],dic[@"msg"],[OrderPrint mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
