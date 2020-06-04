//
//  DelectShopCart.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/7/22.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^DelectShopCartSuccessBlock)(NSString *code,NSString* message);
typedef void(^DelectShopCartFaiulureBlock)(NSError *error);
@interface DelectShopCart : NSObject


@property(nonatomic,copy)NSString *id;


-(void)DelectShopCartSuccess:(DelectShopCartSuccessBlock)success andFailure:(DelectShopCartFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
