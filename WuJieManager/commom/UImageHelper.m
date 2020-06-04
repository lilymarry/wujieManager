//
//  ImageHelper.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/29.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "UImageHelper.h"

@implementation UImageHelper
//压缩图片为指定大小
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size
{
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}

+(UIImage *)zipIma:(UIImage *)image
{
    CGSize imagesize = image.size;
    float XX=imagesize.width/ScreenW;//宽度比
    float VY=imagesize.height/XX;//在屏幕上的高度
    imagesize.width = ScreenW;//放大倍数
    imagesize.height =VY;
    UIImage *ima = [UImageHelper scaleToSize:image size:imagesize];
    
    return ima;
}
@end
