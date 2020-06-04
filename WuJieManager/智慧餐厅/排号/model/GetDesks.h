//
//  GetDesks.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/6/4.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^GetDesksSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^GetDesksFaiulureBlock)(NSError *error);
@interface GetDesks : NSObject
@property(nonatomic,copy)NSString *num_state;//1排号 2叫号 3过号
@property(nonatomic,strong)GetDesks *data;
@property(nonatomic,strong)NSArray *desk_info;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)NSArray *num_list;

@property(nonatomic,copy)NSString *create_time;
@property(nonatomic,copy)NSString *create_user_id;
@property(nonatomic,copy)NSString *create_user_type;
@property(nonatomic,copy)NSString *desk_id;
@property(nonatomic,copy)NSString *desk_type_id;
@property(nonatomic,copy)NSString *id ;
@property(nonatomic,copy)NSString *merchant_id;
@property(nonatomic,copy)NSString *call_num;
@property(nonatomic,copy)NSString *num_type;
@property(nonatomic,copy)NSString *number;
@property(nonatomic,copy)NSString *number_show;
@property(nonatomic,strong)GetDesks *second_type;
@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,copy)NSString *first_name;
@property(nonatomic,copy)NSString * picture ;
@property(nonatomic,copy)NSString *second_name;
@property(nonatomic,copy)NSString *status ;
@property(nonatomic,copy)NSString *updated_at;
@property(nonatomic,copy)NSString *take_info;
@property(nonatomic,copy)NSString *update_time;
@property(nonatomic,copy)NSString *use_time;
@property(nonatomic,copy)NSString *user_name;
@property(nonatomic,copy)NSString *user_phone;

@property(nonatomic,copy)NSString *wait_number;

-(void)GetDesksSuccess:(GetDesksSuccessBlock)success andFailure:(GetDesksFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
