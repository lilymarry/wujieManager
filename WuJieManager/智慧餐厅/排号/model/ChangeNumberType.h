//
//  ChangeNumberType.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/6/4.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ChangeNumberTypeSuccessBlock) (NSString * code, NSString * message, NSDictionary * data);
typedef void (^ChangeNumberTypeFailureBlock) (NSError * error);
@interface ChangeNumberType : NSObject
@property (nonatomic, strong) NSString * id;
@property (nonatomic, strong) NSString * type_value;
@property (nonatomic, strong) NSString * desk_id;
- (void)ChangeNumberTypeSuccess:(ChangeNumberTypeSuccessBlock)success andFailure:(ChangeNumberTypeFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
