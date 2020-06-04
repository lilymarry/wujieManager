//
//  TakeSeat.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/6/27.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^TakeSeatSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^TakeSeatFaiulureBlock)(NSError *error);

@interface TakeSeat : NSObject

@property(nonatomic,copy)NSString *take_id;
@property(nonatomic,copy)NSString *desk_id;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *meal_num;
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *code;

@property(nonatomic,strong)TakeSeat *data;

@property(nonatomic,copy)NSString *area_name;
@property(nonatomic,copy)NSString *balance;
@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,copy)NSString *desk_type;
@property(nonatomic,copy)NSString *desk_type_info;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *img ;
@property(nonatomic,copy)NSString *manager;
//@property(nonatomic,copy)NSString *meal_num;
@property(nonatomic,copy)NSString *merchant_region_id;
@property(nonatomic,copy)NSString *name ;
@property(nonatomic,copy)NSString *open_time;
@property(nonatomic,copy)NSString *open_time_string;
@property(nonatomic,strong)TakeSeat *second_type;
//@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,copy)NSString *first_name;
//@property(nonatomic,copy)NSString *id ;
@property(nonatomic,copy)NSString *picture;
@property(nonatomic,copy)NSString *second_name;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *tag ;
@property(nonatomic,copy)NSString *updated_at;
@property(nonatomic,copy)NSString *shop_id;
//@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *status_name;
@property(nonatomic,copy)NSString *take_num;
@property(nonatomic,copy)NSString *topay_order_num;
@property(nonatomic,copy)NSString *topay_order_price;
@property(nonatomic,copy)NSString *total_order_price;
//@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *uid ;
//@property(nonatomic,copy)NSString *updated_at;
@property(nonatomic,copy)NSString *use_type;
@property(nonatomic,copy)NSString *user_name;


-(void)TakeSeatSuccess:(TakeSeatSuccessBlock)success andFailure:(TakeSeatFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
