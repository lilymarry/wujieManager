//
//  OnMealPadCell.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/21.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OnMealPadCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *specsLab;
@property (weak, nonatomic) IBOutlet UILabel *planTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLab;
@end

NS_ASSUME_NONNULL_END
