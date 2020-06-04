//
//  SendSms.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/8/7.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^SendSmsSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^SendSmsFaiulureBlock)(NSError *error);
@interface SendSms : NSObject
@property(nonatomic,copy)NSString *type;

@property(nonatomic,copy)NSString *mid;
@property(nonatomic,copy)NSString *mobile;
//@property(nonatomic,strong)NSArray *data;
//@property(nonatomic,copy)NSString *created_at;
//@property(nonatomic,copy)NSString *dishes_info;
//@property(nonatomic,copy)NSString *id ;
//@property(nonatomic,copy)NSString *order_sn;
//@property(nonatomic,copy)NSString *total_price;
//@property(nonatomic,copy)NSString *uid;
//@property(nonatomic,strong)DineOrderList *user_info;
//@property(nonatomic,copy)NSString *head_pic;
//@property(nonatomic,copy)NSString *nick_name;


-(void)SendSmsSuccess:(SendSmsSuccessBlock)success andFailure:(SendSmsFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
