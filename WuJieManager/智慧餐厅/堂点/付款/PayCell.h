//
//  PayCell.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/7/26.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PayCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imagview;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;
@property (weak, nonatomic) IBOutlet UIImageView *flag_image;
@property (weak, nonatomic) IBOutlet UILabel *cartNameLab;


@end

NS_ASSUME_NONNULL_END
