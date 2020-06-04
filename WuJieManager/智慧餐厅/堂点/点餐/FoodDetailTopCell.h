//
//  FoodDetailTopCell.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/8/26.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FoodDetailTopCell : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (weak, nonatomic) IBOutlet UIImageView *head_imagView;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@end

NS_ASSUME_NONNULL_END
