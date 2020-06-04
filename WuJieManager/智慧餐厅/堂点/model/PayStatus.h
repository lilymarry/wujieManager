//
//  PayStatus.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/8/12.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^PayStatusSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^PayStatusFaiulureBlock)(NSError *error);

@interface PayStatus : NSObject

@property(nonatomic,copy)NSString *order_sn;

-(void)PayStatusSuccess:(PayStatusSuccessBlock)success andFailure:(PayStatusFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
