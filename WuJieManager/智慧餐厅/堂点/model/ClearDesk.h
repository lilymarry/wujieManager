//
//  ClearDesk.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/8/8.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^ClearDeskSuccessBlock)(NSString *code,NSString* message  ,id data);
typedef void(^ClearDeskFaiulureBlock)(NSError *error);
@interface ClearDesk : NSObject
@property(nonatomic,copy)NSString *desk_id;
-(void)ClearDeskSuccess:(ClearDeskSuccessBlock)success andFailure:(ClearDeskFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
