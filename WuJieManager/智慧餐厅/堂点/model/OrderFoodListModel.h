//
//  OrderFoodListModel.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/7/4.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^OrderFoodListModelSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^OrderFoodListModelFaiulureBlock)(NSError *error);
@interface OrderFoodListModel : NSObject
@property(nonatomic,copy)NSString *channel;
@property(nonatomic,copy)NSString *desk_id;
@property(nonatomic,copy)NSString *menu_id;

@property(nonatomic,strong)OrderFoodListModel *data;
@property(nonatomic,strong)OrderFoodListModel *list;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,strong)NSArray *menus;

@property(nonatomic,copy)NSString *category;
@property(nonatomic,strong)NSArray *category_caipin;
@property(nonatomic,copy)NSString *dishes;
@property(nonatomic,copy)NSString *dishes_id;

@property(nonatomic,copy)NSString *mic_id;
@property(nonatomic,copy)NSString *picture;
@property(nonatomic,copy)NSString *price ;
@property(nonatomic,copy)NSString *sellCount;
@property(nonatomic,copy)NSString *sort ;
@property(nonatomic,copy)NSString *zong_time;

@property(nonatomic,copy)NSString *mc_id;
@property(nonatomic,copy)NSString *mi_id;

@property(nonatomic,copy)NSString *merchant_id;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *take_type;
@property(nonatomic,copy)NSString *take_pay;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,strong)NSArray *menu_list;
@property(nonatomic,strong)NSArray *child;
@property(nonatomic,assign)NSInteger selectNum;
@property(nonatomic,copy)NSString *img_url;
-(void)OrderFoodListModelSuccess:(OrderFoodListModelSuccessBlock)success andFailure:(OrderFoodListModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
