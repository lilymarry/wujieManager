//
//  CheckSms.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/8/7.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^CheckSmsSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^CheckSmsFaiulureBlock)(NSError *error);
@interface CheckSms : NSObject
@property(nonatomic,copy)NSString *code;
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


-(void)CheckSmsSuccess:(CheckSmsSuccessBlock)success andFailure:(CheckSmsFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
