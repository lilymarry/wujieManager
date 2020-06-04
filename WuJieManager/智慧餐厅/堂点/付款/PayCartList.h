//
//  PayCartList.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/9/5.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^PayCartListBlock)(NSInteger num ,NSString *cartName);
@interface PayCartList : UIViewController
@property(nonatomic,copy)PayCartListBlock block;
@property(nonatomic,strong)NSString * selectNum;
@end

NS_ASSUME_NONNULL_END
