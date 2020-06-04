//
//  OrderFoodSet.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/7/26.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^OrderFoodSetSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^OrderFoodSetFaiulureBlock)(NSError *error);
@interface OrderFoodSet : NSObject
@property(nonatomic,copy)NSString *type;

@property(nonatomic,copy)NSString *server_id;
@property(nonatomic,copy)NSString *order_id;

@property(nonatomic,copy)NSString *back;
@property(nonatomic,copy)NSString *remark;
@property(nonatomic,copy)NSArray *dish;
@property(nonatomic,strong)OrderFoodSet *data;

-(void)OrderFoodSetSuccess:(OrderFoodSetSuccessBlock)success andFailure:(OrderFoodSetFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
