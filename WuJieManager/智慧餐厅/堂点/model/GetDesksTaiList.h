//
//  GetDesksTaiList.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/6/27.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^GetDesksTaiListSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^GetDesksTaiListFaiulureBlock)(NSError *error);

@interface GetDesksTaiList : NSObject

@property(nonatomic,strong)GetDesksTaiList *data ;
@property(nonatomic,strong)NSArray *desk_list;
@property(nonatomic,strong)NSArray *child;
@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,copy)NSString *desk_type;
@property(nonatomic,copy)NSString *desk_type_info;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *img ;
@property(nonatomic,copy)NSString *manager ;
@property(nonatomic,copy)NSString *merchant_region_id;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)GetDesksTaiList *second_type;

@property(nonatomic,copy)NSString *first_name;

@property(nonatomic,copy)NSString *picture ;
@property(nonatomic,copy)NSString *second_name;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *tag;
@property(nonatomic,copy)NSString *updated_at;
@property(nonatomic,copy)NSString *shop_id;
@property(nonatomic,copy)NSString *take_num;
@property(nonatomic,copy)NSString *type;

@property(nonatomic,copy)NSString *use_type;
@property(nonatomic,strong)NSArray *desk_type_list;
@property(nonatomic,strong)NSArray *desk_data;

@property(nonatomic,strong)GetDesksTaiList *orders_info;
@property(nonatomic,copy)NSString *msg ;
//@property(nonatomic,copy)NSString *name;
//@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *order_sn;

@property(nonatomic,strong)NSArray *order_list;
@property(nonatomic,copy)NSString *box_fee;
@property(nonatomic,copy)NSString *box_num;
@property(nonatomic,copy)NSString *c_status;
@property(nonatomic,copy)NSString *cid ;
@property(nonatomic,copy)NSString *cname;
@property(nonatomic,copy)NSString *convert ;
//@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,copy)NSString *d_fee;
@property(nonatomic,copy)NSString *d_type;
@property(nonatomic,copy)NSString *dada_data;
@property(nonatomic,copy)NSString *desk_id;
@property(nonatomic,copy)NSString *discount;
@property(nonatomic,copy)NSString *dp_time;
@property(nonatomic,copy)NSString *i_fee;
//@property(nonatomic,copy)NSString *id ;
@property(nonatomic,copy)NSString *message;
@property(nonatomic,copy)NSString *mi_id;
@property(nonatomic,copy)NSString *order_price;
//@property(nonatomic,copy)NSString *order_sn;
@property(nonatomic,copy)NSString *order_status;
@property(nonatomic,copy)NSString *order_type;
@property(nonatomic,copy)NSString *parent_id;
@property(nonatomic,copy)NSString *pay_sn;
@property(nonatomic,copy)NSString *pay_status;
@property(nonatomic,copy)NSString *pay_time;
@property(nonatomic,copy)NSString *pay_type;
@property(nonatomic,copy)NSString *pay_way;
@property(nonatomic,copy)NSString *r_address;
@property(nonatomic,copy)NSString *r_name;
@property(nonatomic,copy)NSString *r_phone;
@property(nonatomic,copy)NSString *server_id;
//@property(nonatomic,copy)NSString *status ;
@property(nonatomic,copy)NSString *t_fee;
@property(nonatomic,copy)NSString *table_fee;
@property(nonatomic,copy)NSString *table_num;
@property(nonatomic,copy)NSString *td_fee;
@property(nonatomic,copy)NSString *td_type;
@property(nonatomic,copy)NSString *total_price;
@property(nonatomic,copy)NSString *uid ;
//@property(nonatomic,copy)NSString *updated_at;
@property(nonatomic,copy)NSString *v_fee;
@property(nonatomic,copy)NSString * voucher;
@property(nonatomic,copy)NSString * status_name;

@property(nonatomic,copy)NSString *topay_order_price;
@property(nonatomic,copy)NSString *total_order_price;
@property(nonatomic,copy)NSString *user_name;
@property(nonatomic,copy)NSString *open_time_string;

-(void)GetDesksTaiListSuccess:(GetDesksTaiListSuccessBlock)success andFailure:(GetDesksTaiListFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
