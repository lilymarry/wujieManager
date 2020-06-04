//
//  BuyInContentCell.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/19.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BuyInContentCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *sview1;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sview1HHH;
@property (strong, nonatomic) IBOutlet UILabel *view2_title;

@property (strong, nonatomic) IBOutlet UIButton *allBtn;
@property (strong, nonatomic) IBOutlet UILabel *view5_title;

@property (strong, nonatomic) IBOutlet UIButton *view4_deductBtn;

@property (strong, nonatomic) IBOutlet UIButton *view4_addBtn;

@end

NS_ASSUME_NONNULL_END
