//
//  ReturnFood.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/13.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ReturnFoodBlock)(void);
@interface ReturnFood : UIViewController
@property(nonatomic,strong)NSString *order_sn;//购物车
@property (nonatomic, copy) ReturnFoodBlock returnFoodBlock ;
@end

NS_ASSUME_NONNULL_END
