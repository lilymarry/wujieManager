//
//  MyQuanyiListCell.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/22.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyQuanyiListCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *subTitle;
@property (strong, nonatomic) IBOutlet UILabel *fajuanLab;

@property (strong, nonatomic) IBOutlet UILabel *fenhongLab;
@property (strong, nonatomic) IBOutlet UILabel *quanyiLab;
@property (strong, nonatomic) IBOutlet UILabel *shenqianLab;
@property (strong, nonatomic) IBOutlet UILabel *zhuanMaiLab;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *view2HH;
@property (strong, nonatomic) IBOutlet UIView *view2;





@end

NS_ASSUME_NONNULL_END
