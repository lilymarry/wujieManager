//
//  DelectToken.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/7/24.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^DelectTokenSuccessBlock)(NSString *code,NSString* message);
typedef void(^DelectTokenFaiulureBlock)(NSError *error);
@interface DelectToken : NSObject

-(void)DelectTokenSuccessBlock:(DelectTokenSuccessBlock)success andFailure:(DelectTokenFaiulureBlock)failure;
@end

NS_ASSUME_NONNULL_END
