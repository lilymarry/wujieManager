//
//  AddShopCart.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/7/19.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^AddShopCartSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^AddShopCartFaiulureBlock)(NSError *error);
@interface AddShopCart : NSObject

@property(nonatomic,copy)NSString *user_id;
@property(nonatomic,copy)NSString *menu_id;
@property(nonatomic,copy)NSString *desk_id;
@property(nonatomic,copy)NSArray *data;
@property(nonatomic,copy)NSString *id;


-(void)AddShopCartSuccess:(AddShopCartSuccessBlock)success andFailure:(AddShopCartFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
