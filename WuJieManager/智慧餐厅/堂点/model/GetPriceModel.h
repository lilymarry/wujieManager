//
//  GetPriceModel.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/7/9.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^GetPriceModelSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^GetPriceModelFaiulureBlock)(NSError *error);
@interface GetPriceModel : NSObject

@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *is_dining;

@property(nonatomic,copy)NSString *num;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *norm_id;
@property(nonatomic,copy)NSString *taste_id;

@property(nonatomic,copy)NSString *add;

@property(nonatomic,copy)NSString *dish;

@property(nonatomic,strong)GetPriceModel *data;
@property(nonatomic,strong)GetPriceModel *info;
@property(nonatomic,copy)NSString *add_price;
@property(nonatomic,copy)NSString *all_price;

@property(nonatomic,copy)NSString *single_price;

-(void)GetPriceModelSuccess:(GetPriceModelSuccessBlock)success andFailure:(GetPriceModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
