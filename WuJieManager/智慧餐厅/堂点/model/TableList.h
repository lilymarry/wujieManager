//
//  TableList.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/6/5.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^TableListSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^TableListFaiulureBlock)(NSError *error);
@interface TableList : NSObject
@property(nonatomic,copy)NSString *merchant_id;
@property(nonatomic,copy)NSString *desk_type_id;
@property(nonatomic,copy)NSString *num_state;
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *admin_id;

@property(nonatomic,strong)TableList *data;
@property(nonatomic,strong)TableList *merchant_info;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,strong)NSArray *photos;
@property(nonatomic,strong)NSArray *desk_info;
@property(nonatomic,copy)NSString *second_name;
@property(nonatomic,strong)NSArray *number_list;
@property(nonatomic,copy)NSString *number;
@property(nonatomic,copy)NSString *user_name;
@property(nonatomic,copy)NSString *user_phone;
@property(nonatomic,strong)TableList *number_info;
@property(nonatomic,copy)NSString *desk_type;
@property(nonatomic,copy)NSString *desk_num;
@property(nonatomic,copy)NSString *take_user;

-(void)TableListSuccess:(TableListSuccessBlock)success andFailure:(TableListFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
