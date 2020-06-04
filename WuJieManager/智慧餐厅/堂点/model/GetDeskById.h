//
//  GetDeskById.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/9/3.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^GetDeskByIdSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^GetDeskByIdFaiulureBlock)(NSError *error);
@interface GetDeskById : NSObject
@property(nonatomic,copy)NSString *desk_id;

@property(nonatomic,strong)GetDeskById *data;
@property(nonatomic,copy)NSString *area_name;
@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,copy)NSString *desk_type;
@property(nonatomic,copy)NSString *desk_type_info;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *img ;
@property(nonatomic,copy)NSString *manager ;
@property(nonatomic,copy)NSString *meal_num;
@property(nonatomic,copy)NSString *merchant_region_id;
@property(nonatomic,copy)NSString *name ;
@property(nonatomic,copy)NSString *open_time;
@property(nonatomic,copy)NSString *open_time_string;
@property(nonatomic,strong)GetDeskById *second_type;
//@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,copy)NSString *first_name;
//@property(nonatomic,copy)NSString *id ;
@property(nonatomic,copy)NSString *picture;
@property(nonatomic,copy)NSString *picture_url;
@property(nonatomic,copy)NSString *second_name;
@property(nonatomic,copy)NSString *status ;
@property(nonatomic,copy)NSString *tag ;
@property(nonatomic,copy)NSString *updated_at;
@property(nonatomic,copy)NSString *shop_id;
@property(nonatomic,copy)NSString *status_name;
@property(nonatomic,copy)NSString *take_num;
@property(nonatomic,copy)NSString *topay_order_num;
@property(nonatomic,copy)NSString *topay_order_price;
@property(nonatomic,copy)NSString *total_order_price;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *uid ;
//@property(nonatomic,copy)NSString *updated_at;
@property(nonatomic,copy)NSString *use_type;
@property(nonatomic,copy)NSString *user_name;
-(void)GetDeskByIdSuccess:(GetDeskByIdSuccessBlock)success andFailure:(GetDeskByIdFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
