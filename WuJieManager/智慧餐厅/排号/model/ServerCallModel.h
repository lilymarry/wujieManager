//
//  ServerCallModel.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/6/26.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^ServerCallModelSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^ServerCallModelFaiulureBlock)(NSError *error);

@interface ServerCallModel : NSObject
@property(nonatomic,copy)NSString *desk_id;
@property(nonatomic,copy)NSString *num_state;
@property(nonatomic,copy)NSString *desk;

@property(nonatomic,strong)ServerCallModel *data;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *number;
@property(nonatomic,copy)NSString *merchant_id;
@property(nonatomic,copy)NSString *num_type;
@property(nonatomic,copy)NSString *desk_type_id;
@property(nonatomic,copy)NSString *user_name;
@property(nonatomic,copy)NSString *user_phone;
@property(nonatomic,copy)NSString *use_time;
@property(nonatomic,copy)NSString *create_user_type;
@property(nonatomic,copy)NSString *create_user_id;
@property(nonatomic,copy)NSString *create_time;
@property(nonatomic,copy)NSString *update_time;
@property(nonatomic,copy)NSString *status;

-(void)ServerCallModelSuccess:(ServerCallModelSuccessBlock)success andFailure:(ServerCallModelFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
