//
//  OrderInfo.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/9/18.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^OrderInfoSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^OrderInfoFaiulureBlock)(NSError *error);
@interface OrderInfo : NSObject
@property(nonatomic,copy)NSString *order_sn;
@property(nonatomic,strong)NSString *status;

@property(nonatomic,strong)OrderInfo * data;
@property(nonatomic,copy)NSString *box_fee;
@property(nonatomic,copy)NSString *box_num;
@property(nonatomic,copy)NSString *c_status;
@property(nonatomic,copy)NSString *cid;
@property(nonatomic,copy)NSString *cname;
@property(nonatomic,copy)NSString * convert ;
@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,copy)NSString *d_fee;
@property(nonatomic,copy)NSString *d_type;
@property(nonatomic,copy)NSString *dada_data;
@property(nonatomic,copy)NSString *desk_id;
@property(nonatomic,copy)NSString *discount;

@property(nonatomic,strong)NSArray *dish ;
@property(nonatomic,copy)NSString *chef_id;
@property(nonatomic,copy)NSString *co_id;
@property(nonatomic,copy)NSString *status_name;
@property(nonatomic,copy)NSArray *dish_add;
@property(nonatomic,copy)NSString *dish_id;
@property(nonatomic,copy)NSString *dish_img;
@property(nonatomic,copy)NSString *dish_name;
@property(nonatomic,copy)NSString *dish_num;
@property(nonatomic,copy)NSString *dish_pic;
@property(nonatomic,copy)NSString *all_price;

@property(nonatomic,strong)NSArray *dish_replace;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *is_dish;
@property(nonatomic,copy)NSString *norms_id;
@property(nonatomic,copy)NSString *norms_name;
@property(nonatomic,copy)NSString *parent_id;
@property(nonatomic,copy)NSString *push_time;
@property(nonatomic,copy)NSString *rev_status;
@property(nonatomic,copy)NSString *rev_time;
//@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *taste_id;
@property(nonatomic,copy)NSString *taste_name;
@property(nonatomic,copy)NSString *updated_at;
@property(nonatomic,copy)NSString *dp_time;
@property(nonatomic,copy)NSString *i_fee;
//@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *message ;
@property(nonatomic,copy)NSString *order_price;
//@property(nonatomic,copy)NSString *order_sn;
@property(nonatomic,copy)NSString *order_status;
@property(nonatomic,copy)NSString *order_type;
@property(nonatomic,copy)NSString *pay_sn;
@property(nonatomic,copy)NSString *pay_status;
@property(nonatomic,copy)NSString *pay_time;
@property(nonatomic,copy)NSString *pay_type;
@property(nonatomic,copy)NSString *r_address;
@property(nonatomic,copy)NSString *r_name;
@property(nonatomic,copy)NSString *r_phone;
@property(nonatomic,copy)NSString *server_id;
//@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *t_fee;
@property(nonatomic,copy)NSString *table_fee;
@property(nonatomic,copy)NSString *table_num;
@property(nonatomic,copy)NSString *td_fee;
@property(nonatomic,copy)NSString *td_type;
@property(nonatomic,copy)NSString *total_price;
@property(nonatomic,copy)NSString *total_add_price;
@property(nonatomic,copy)NSString *uid;
//@property(nonatomic,copy)NSString *updated_at;
@property(nonatomic,copy)NSString *v_fee;
@property(nonatomic,copy)NSString *voucher;

@property(nonatomic,strong)OrderInfo *user_info;
@property(nonatomic,copy)NSString *head_icon;
@property(nonatomic,copy)NSString *head_pic;

@property(nonatomic,copy)NSString *nick_name;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *pay_price;
@property(nonatomic,copy)NSString *user_name;
@property(nonatomic,copy)NSString *desk_name;

@property(nonatomic,copy)NSString *pay_way;


@property(nonatomic,strong)OrderInfo *server_info;

@property(nonatomic,strong)OrderInfo *desk;
@property(nonatomic,copy)NSString *area_name;
@property(nonatomic,copy)NSString *desk_type_info;
@property(nonatomic,copy)NSString *single_price;
@property(nonatomic,copy)NSString *source_name;
@property(nonatomic,copy)NSString *name;

@property(nonatomic,assign)BOOL isSelect ;



-(void)OrderInfoSuccess:(OrderInfoSuccessBlock)success andFailure:(OrderInfoFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
