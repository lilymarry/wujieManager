//
//  ExchangeTime.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/8/6.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExchangeTime : NSObject
+ (NSString*)timeWithTimeIntervalString:(NSString*)timeString  andFormatter:(NSString*)format;
+(NSString*)timeSwitchTimestamp:(NSString*)formatTime andFormatter:(NSString*)format;
@end

NS_ASSUME_NONNULL_END
