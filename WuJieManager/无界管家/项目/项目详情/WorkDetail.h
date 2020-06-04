//
//  WorkDetail.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/18.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WorkDetail : UIViewController
@property(nonatomic,strong)NSString *type;//卖出 2  买入 1
@property(nonatomic,strong)NSString *isGroup;//1 项目组  2 普通

@end

NS_ASSUME_NONNULL_END
