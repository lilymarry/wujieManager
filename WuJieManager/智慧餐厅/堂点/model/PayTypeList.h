//
//  PayType.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/8/12.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^PayTypeListSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^PayTypeListFaiulureBlock)(NSError *error);
@interface PayTypeList : NSObject
@property(nonatomic,copy)NSString *order_sn;
@property(nonatomic,strong)NSArray *data;
-(void)PayTypeListSuccess:(PayTypeListSuccessBlock)success andFailure:(PayTypeListFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
