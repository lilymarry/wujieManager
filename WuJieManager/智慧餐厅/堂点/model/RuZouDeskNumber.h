//
//  RuZouDeskNumber.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/6/27.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^RuZouDeskNumberSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^RuZouDeskNumberFaiulureBlock)(NSError *error);

@interface RuZouDeskNumber : NSObject
@property(nonatomic,copy)NSString *desk_id;

@property(nonatomic,strong)NSArray *data;

@property(nonatomic,copy)NSString *create_time;
@property(nonatomic,copy)NSString *create_user_id;
@property(nonatomic,copy)NSString *create_user_type;
//@property(nonatomic,copy)NSString *desk_id;
@property(nonatomic,copy)NSString *desk_type_id;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *merchant_id;
@property(nonatomic,copy)NSString *num_state;
@property(nonatomic,copy)NSString *num_type;
@property(nonatomic,copy)NSString *number;
@property(nonatomic,copy)NSString *number_show;
@property(nonatomic,strong)RuZouDeskNumber *second_type;
@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,copy)NSString *first_name;
//@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *picture ;
@property(nonatomic,copy)NSString *second_name;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *tag ;
@property(nonatomic,copy)NSString *updated_at;
//@property(nonatomic,copy)NSString *status ;
@property(nonatomic,copy)NSString *take_info;
@property(nonatomic,copy)NSString *update_time;
@property(nonatomic,copy)NSString *use_time;
@property(nonatomic,copy)NSString *user_name;
@property(nonatomic,copy)NSString *user_phone;

-(void)RuZouDeskNumberSuccess:(RuZouDeskNumberSuccessBlock)success andFailure:(RuZouDeskNumberFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
