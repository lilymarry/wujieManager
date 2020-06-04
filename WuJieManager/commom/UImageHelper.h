//
//  ImageHelper.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/29.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UImageHelper : NSObject
+(UIImage *)zipIma:(UIImage *)image;
//压缩图片为指定大小
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
