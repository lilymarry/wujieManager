//
//  BalancePay.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/8/12.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^PayModelSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^PayModelFaiulureBlock)(NSError *error);
@interface PayModel : NSObject
@property(nonatomic,copy)NSString *order_sn;
@property(nonatomic,copy)NSString *pay_price;
@property(nonatomic,copy)NSString *pay_type;
@property(nonatomic,strong)PayModel *data;
@property(nonatomic,copy)NSString *qrcode;
-(void)PayModelSuccess:(PayModelSuccessBlock)success andFailure:(PayModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
