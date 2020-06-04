//
//  WechatList.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/8/7.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^WechatListSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^WechatListFaiulureBlock)(NSError *error);
@interface WechatList : NSObject
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *mid;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *appid;
@property(nonatomic,copy)NSString *secret;
@property(nonatomic,copy)NSString *open_id ;
@property(nonatomic,copy)NSString *head_pic;
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *password;
@property(nonatomic,copy)NSString *confirmPassword;
@property(nonatomic,copy)NSString *nePassword;
-(void)WechatListSuccess:(WechatListSuccessBlock)success andFailure:(WechatListFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
