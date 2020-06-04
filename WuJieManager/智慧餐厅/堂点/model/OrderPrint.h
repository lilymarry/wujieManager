//
//  OrderPrint.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/8/15.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^OrderPrintSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^OrderPrintFaiulureBlock)(NSError *error);
@interface OrderPrint : NSObject

@property(nonatomic,copy)NSString *only_front;
@property(nonatomic,copy)NSString *order_sn;
@property(nonatomic,copy)NSString *merchant_id;
-(void)OrderPrintSuccess:(OrderPrintSuccessBlock)success andFailure:(OrderPrintFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
