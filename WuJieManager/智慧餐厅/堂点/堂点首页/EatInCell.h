//
//  EatInCell.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/6.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EatInCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIView *backView;

@property (strong, nonatomic) IBOutlet UIView *beginView;
@property (strong, nonatomic) IBOutlet UIButton *beginBtn;
@property (strong, nonatomic) IBOutlet UIButton *eatInBtn;
@property (strong, nonatomic) IBOutlet UILabel *jiesuanLab;

@property (strong, nonatomic) IBOutlet UILabel *tableNameLab;
@property (strong, nonatomic) IBOutlet UILabel *subTableNameLab;
@property (strong, nonatomic) IBOutlet UILabel *userNameLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UILabel *sumMoneyLab;
@end

NS_ASSUME_NONNULL_END
