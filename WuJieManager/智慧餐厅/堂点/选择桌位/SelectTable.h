//
//  SelectTable.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/7.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef  void (^finishBlock)(NSString *names);
@interface SelectTable : UIViewController
@property(nonatomic,copy) finishBlock block;
-(id)initWithBlock:(finishBlock)ablock;

@end

NS_ASSUME_NONNULL_END
