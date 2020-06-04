//
//  TableList.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/6/5.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "TableList.h"

@implementation TableList
-(void)TableListSuccess:(TableListSuccessBlock)success andFailure:(TableListFaiulureBlock)failure
{
    [HttpManager postWithUrl:@"api/tableList"  baseurl:canyin_Base_url andParameters:@{@"merchant_id":_merchant_id,@"desk_type_id":_desk_type_id,@"num_state":_num_state,@"code":_code,@"admin_id":_admin_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        NSLog(@"ssss %@",dic);
        [TableList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"photos":@"TableList",@"desk_info":@"TableList",@"number_list":@"TableList"};
        }];
        success(dic[@"code"],dic[@"msg"],[TableList mj_objectWithKeyValues:dic]);

    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
