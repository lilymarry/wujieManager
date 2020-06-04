//
//  MyBagheadView.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/25.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyBagheadView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UIImageView *cart_imag;
@property (strong, nonatomic) IBOutlet UILabel *cart_name;
@property (strong, nonatomic) IBOutlet UIButton *moreBtn;

@end

NS_ASSUME_NONNULL_END
