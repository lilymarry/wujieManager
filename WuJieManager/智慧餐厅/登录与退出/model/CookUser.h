//
//  User.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/23.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CookUser : NSObject
@property(nonatomic,strong )CookUser *data;
@property(nonatomic,copy)NSString *access_token;
@property(nonatomic,copy)NSString *expires_in;
@property(nonatomic,copy)NSString *token_type;
@property(nonatomic,strong )CookUser *user_info;
@property(nonatomic,copy)NSString *user_id;
@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *nick_name;
@property(nonatomic,copy)NSString *merchant_id;
@property(nonatomic,copy)NSString *merchant_name;
@property(nonatomic,copy)NSString *head_icon;
@property(nonatomic,copy)NSString *screen_id;
@end
