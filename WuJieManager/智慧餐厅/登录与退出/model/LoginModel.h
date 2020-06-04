//
//  LoginModel.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/6/13.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CookUser.h"
NS_ASSUME_NONNULL_BEGIN


typedef void(^LoginModelSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^LoginModelFaiulureBlock)(NSError *error);
@interface LoginModel : NSObject
@property(nonatomic,copy )NSString *user_id;
@property(nonatomic,copy)NSString *password;
@property(nonatomic,copy)NSString *code;
@property (nonatomic, strong) CookUser * data;

-(void)LoginModelSuccessBlock:(LoginModelSuccessBlock)success andFailure:(LoginModelFaiulureBlock)failure;
+ (instancetype)shareInstance;
//保存登陆用户信息
- (void)save:(CookUser *)userInfo;
//获取已保存用户信息
- (CookUser *)getUserInfo;
//删除用户信息
- (void)deleteUserInfo;
@end

NS_ASSUME_NONNULL_END
