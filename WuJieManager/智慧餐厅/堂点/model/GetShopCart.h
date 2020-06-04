//
//  GetShopCart.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/7/19.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^GetShopCartModelSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^GetShopCartModelFaiulureBlock)(NSError *error);
@interface GetShopCart : NSObject

@property(nonatomic,copy)NSString *user_id;
@property(nonatomic,copy)NSString *menu_id;
@property(nonatomic,copy)NSString *desk_id;

@property(nonatomic,strong)GetShopCart *data ;
@property(nonatomic,strong)NSArray * cart_list;
@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,copy)NSString *id ;

@property(nonatomic,copy)NSString *status ;
@property(nonatomic,copy)NSString *updated_at;



-(void)GetShopCartModelSuccess:(GetShopCartModelSuccessBlock)success andFailure:(GetShopCartModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
