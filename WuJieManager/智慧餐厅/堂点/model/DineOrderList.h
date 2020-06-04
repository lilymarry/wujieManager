//
//  DineOrderList.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/8/6.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^DineOrderListSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^DineOrderListFaiulureBlock)(NSError *error);
@interface DineOrderList : NSObject
@property(nonatomic,copy)NSString *type;

@property(nonatomic,copy)NSString *mid;
@property(nonatomic,copy)NSString *desk_id;

@property(nonatomic,strong)DineOrderList *data;
@property(nonatomic,strong)DineOrderList *desk_info;
@property(nonatomic,copy)NSString *area_name;
@property(nonatomic,copy)NSString *desk_type_info;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *open_time_string;
@property(nonatomic,copy)NSString *second_type;
@property(nonatomic,copy)NSString *status_name;
@property(nonatomic,copy)NSString *topay_order_num;
@property(nonatomic,copy)NSString *topay_order_price;
@property(nonatomic,copy)NSString *total_order_price;
@property(nonatomic,copy)NSString *use_type;
@property(nonatomic,copy)NSString *user_name;

@property(nonatomic,strong)NSArray *order_info;
@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,copy)NSString *dishes_info;
//@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *order_sn;
@property(nonatomic,copy)NSString *pay_status;
@property(nonatomic,copy)NSString *server_id;
@property(nonatomic,copy)NSString *status;
//@property(nonatomic,copy)NSString *status_name;
@property(nonatomic,copy)NSString *total_price;
@property(nonatomic,copy)NSString *uid ;
@property(nonatomic,strong)DineOrderList *user_info;
@property(nonatomic,copy)NSString *head_icon;
@property(nonatomic,copy)NSString *head_pic;
//@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *nick_name;
@property(nonatomic,copy)NSString *all_price;


@property(nonatomic,copy)NSString *pay_way;

-(void)DineOrderListSuccess:(DineOrderListSuccessBlock)success andFailure:(DineOrderListFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
