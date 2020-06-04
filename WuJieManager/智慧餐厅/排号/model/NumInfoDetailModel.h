//
//  InfoDetail.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/6/4.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^InfoDetailSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^InfoDetailFaiulureBlock)(NSError *error);
@interface NumInfoDetailModel : NSObject
@property(nonatomic,copy )NSString *id;
@property(nonatomic,strong)NumInfoDetailModel *data;
@property(nonatomic,copy)NSString *create_time;
@property(nonatomic,copy)NSString *desk_info;
@property(nonatomic,copy)NSString *desk_type_id;
@property(nonatomic,copy)NSString *num_state;
@property(nonatomic,copy)NSString *num_type;
@property(nonatomic,copy)NSString *number_show;
@property(nonatomic,copy)NumInfoDetailModel *second_type;
@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,copy)NSString *first_name;
@property(nonatomic,copy)NSString * picture ;
@property(nonatomic,copy)NSString *second_name;
@property(nonatomic,copy)NSString *status ;
@property(nonatomic,copy)NSString *updated_at;
@property(nonatomic,copy)NSString *take_info;
@property(nonatomic,copy)NSString *user_name;
@property(nonatomic,copy)NSString *user_phone;

-(void)InfoDetailSuccess:(InfoDetailSuccessBlock)success andFailure:(InfoDetailFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
