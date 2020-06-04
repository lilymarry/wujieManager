//
//  NewsListCell.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/18.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsListCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imagView;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UIView *backView;

@end

NS_ASSUME_NONNULL_END
