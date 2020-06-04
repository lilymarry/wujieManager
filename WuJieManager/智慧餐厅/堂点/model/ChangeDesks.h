//
//  ChangeDesks.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/6/4.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^ChangeDesksSuccessBlock) (NSString * code, NSString * message, id data);
typedef void (^ChangeDesksFailureBlock) (NSError * error);
@interface ChangeDesks : NSObject
@property (nonatomic, strong) NSString * id;
@property (nonatomic, strong) NSString * desk_new_id;

- (void)ChangeDesksSuccess:(ChangeDesksSuccessBlock)success andFailure:(ChangeDesksFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
