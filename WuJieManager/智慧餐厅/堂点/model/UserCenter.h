//
//  UserCenter.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/8/12.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^UserCenterSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^UserCenterFaiulureBlock)(NSError *error);
@interface UserCenter : NSObject
@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,strong)UserCenter *data;
@property(nonatomic,copy)NSString *balance;
-(void)UserCenterSuccess:(UserCenterSuccessBlock)success andFailure:(UserCenterFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
