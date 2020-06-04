//
//  SetOrder.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/7/26.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^SetOrderSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^SetOrderFaiulureBlock)(NSError *error);
@interface SetOrder : NSObject
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *server_id;
@property(nonatomic,copy)NSString *desk_id;
@property(nonatomic,copy)NSString *source;
@property(nonatomic,strong)SetOrder *data;
@property(nonatomic,copy)NSString *order_id;
@property(nonatomic,copy)NSString *order_sn;
-(void)SetOrderSuccess:(SetOrderSuccessBlock)success andFailure:(SetOrderFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
