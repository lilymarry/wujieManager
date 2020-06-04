//
//  OrderFoodAtterModel.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/7/5.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^OrderFoodAtterModelSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^OrderFoodAtterModelFaiulureBlock)(NSError *error);
@interface OrderFoodAtterModel : NSObject

@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *id;

@property(nonatomic,strong)OrderFoodAtterModel *data;
@property(nonatomic,strong)OrderFoodAtterModel *d;
@property(nonatomic,copy)NSString *canteen_price;
//@property(nonatomic,copy)NSString *description ;
//@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *merchant_id;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *picture ;

@property(nonatomic,strong)NSArray *picture_list;
//@property(nonatomic,copy)NSString *id ;
@property(nonatomic,copy)NSString *old_name;
@property(nonatomic,copy)NSString *status ;
@property(nonatomic,copy)NSString *url;

@property(nonatomic,copy)NSString *picture_path;
//@property(nonatomic,copy)NSString *status ;
@property(nonatomic,copy)NSString *takeout_price;

@property(nonatomic,strong)OrderFoodAtterModel *dishData;

@property(nonatomic,strong)NSArray *dishList;

@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,copy)NSString *dish_id;
@property(nonatomic,copy)NSString *dish_name;
@property(nonatomic,copy)NSString *dish_package_id;
@property(nonatomic,copy)NSString *dishes_taste;

@property(nonatomic,strong)NSArray *dishes_taste_diff;
@property(nonatomic,copy)NSString *Default ;
//@property(nonatomic,copy)NSString *dishes_taste;
//@property(nonatomic,copy)NSString *id ;
//@property(nonatomic,copy)NSString *name ;

//@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *dishes_type;

@property(nonatomic,strong)NSArray *dishes_type_diff;
//@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,copy)NSString *diff_price;
@property(nonatomic,copy)NSString *diff_price_type;
@property(nonatomic,copy)NSString *dish_package_dish_id;
//@property(nonatomic,copy)NSString *dishes_type;
//@property(nonatomic,copy)NSString *id ;
//@property(nonatomic,copy)NSString *name ;
//@property(nonatomic,copy)NSString *status ;
@property(nonatomic,copy)NSString *updated_at;


//@property(nonatomic,copy)NSString *default = 1;
//@property(nonatomic,copy)NSString *dishes_type;
//@property(nonatomic,copy)NSString *id = 88;
//@property(nonatomic,copy)NSString *name = "小份";

@property(nonatomic,strong)NSArray *dishes_type_list;


@property(nonatomic,copy)NSString *minimum ;

@property(nonatomic,assign)BOOL isSelect;



@property(nonatomic,strong)NSArray *dishAdd;//加菜
@property(nonatomic,copy)NSString *add_dish_member ;
@property(nonatomic,strong)NSArray *add_dish_member_list;
@property(nonatomic,strong)NSArray *add_num;
@property(nonatomic,strong)NSArray *add_price;
@property(nonatomic,copy)NSString *add_reduce;
//@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,copy)NSString *dish_here_selttle;
//@property(nonatomic,copy)NSString *dish_id;
@property(nonatomic,copy)NSString *dish_out_selttle;
@property(nonatomic,copy)NSString *dish_sell_channel;
//@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *is_member_price;
@property(nonatomic,copy)NSString *is_user_custom;
@property(nonatomic,copy)NSString *material_add_sub_type;
@property(nonatomic,copy)NSString *material_count;
@property(nonatomic,copy)NSString *material_measure;
@property(nonatomic,copy)NSString *material_name;
@property(nonatomic,copy)NSString *material_type;
@property(nonatomic,copy)NSString *material_waste;
//@property(nonatomic,copy)NSString *name ;
@property(nonatomic,copy)NSString *num ;
@property(nonatomic,strong)NSArray *settle_list;
@property(nonatomic,copy)NSString *material_num;
@property(nonatomic,copy)NSString *material_price ;
//@property(nonatomic,copy)NSString *material_type ;
//@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *unit;
//@property(nonatomic,copy)NSString *updated_at;
@property(nonatomic,copy)NSString *waste;


@property(nonatomic,strong)NSArray *dishNorms;//规格
//@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,strong)NSArray *dish_dinning_ladder;
//@property(nonatomic,copy)NSString *created_at;
//@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *is_count;
@property(nonatomic,copy)NSString *join_id;
//@property(nonatomic,copy)NSString *num;
@property(nonatomic,copy)NSString *price ;
@property(nonatomic,copy)NSString *sell_channel;
//@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *table_name;
@property(nonatomic,copy)NSString *norms_label;
//@property(nonatomic,copy)NSString *updated_at;

@property(nonatomic,copy)NSString *dish_dinning_switch;
//@property(nonatomic,copy)NSString *dish_here_selttle;
//@property(nonatomic,copy)NSString *dish_id;
@property(nonatomic,strong)OrderFoodAtterModel *dish_out_ladder;
//@property(nonatomic,strong)OrderFoodAtterModel * 2 ;
//@property(nonatomic,strong)OrderFoodAtterModel *  3 ;
//@property(nonatomic,copy)NSString *created_at;
//@property(nonatomic,copy)NSString *id ;
//@property(nonatomic,copy)NSString *is_count;
//@property(nonatomic,copy)NSString *join_id;
//@property(nonatomic,copy)NSString *num;
//@property(nonatomic,copy)NSString *price ;
//@property(nonatomic,copy)NSString *sell_channel;
//@property(nonatomic,copy)NSString *status;
//@property(nonatomic,copy)NSString *table_name;
//@property(nonatomic,copy)NSString *updated_at;
//@property(nonatomic,copy)NSString *dish_out_selttle;
@property(nonatomic,copy)NSString *dish_out_switch;
//@property(nonatomic,copy)NSString *id ;
//@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *norms_name;
//@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *tableware_size;
@property(nonatomic,copy)NSString *tableware_type;
//@property(nonatomic,copy)NSString *updated_at;


@property(nonatomic,strong)NSArray *dishTaste;//口味
@property(nonatomic,copy)NSString *taste_name;
@property(nonatomic,assign)NSInteger selectNum;

@property(nonatomic,strong)OrderFoodAtterModel *dishProduce;
@property(nonatomic,copy)NSString *desc;

@property(nonatomic,strong)NSArray *dishMaterial ;

//@property(nonatomic,copy)NSString *add_reduce;
@property(nonatomic,copy)NSString *amount_type;
@property(nonatomic,copy)NSString *big_type;
@property(nonatomic,copy)NSString *category;
//@property(nonatomic,copy)NSString *created_at;
//@property(nonatomic,copy)NSString *dish_id;
//@property(nonatomic,copy)NSString *id ;
@property(nonatomic,copy)NSString *is_change_material;
@property(nonatomic,copy)NSString *is_double;
//@property(nonatomic,copy)NSString *is_user_custom;
//@property(nonatomic,copy)NSString *material_measure;
//@property(nonatomic,copy)NSString *material_name;
//@property(nonatomic,str)NSString *material_num;
//@property(nonatomic,copy)NSString *material_waste;
@property(nonatomic,copy)NSString *merchant_type;
//@property(nonatomic,copy)NSString *name ;
@property(nonatomic,copy)NSString *repeat_material;
//@property(nonatomic,copy)NSString *settle_list;
//@property(nonatomic,copy)NSString *status ;
//@property(nonatomic,copy)NSString *type ;
@property(nonatomic,copy)NSString *unit_name;

@property(nonatomic,strong)NSArray *data_one;
@property(nonatomic,strong)NSArray *data_two;
//@property(nonatomic,copy)NSString *norms = 216;
//@property(nonatomic,copy)NSString *norms_label;
//@property(nonatomic,copy)NSString * num ;
//@property(nonatomic,copy)NSString * name ;
//@property(nonatomic,copy)NSString *unit;
//@property(nonatomic,copy)NSString *unit_name;
//@property(nonatomic,copy)NSString *name ;
-(void)OrderFoodAtterModelSuccess:(OrderFoodAtterModelSuccessBlock)success andFailure:(OrderFoodAtterModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
