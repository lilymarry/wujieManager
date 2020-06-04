//
//  MyBagCell.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/25.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyBagCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *content_ima;
@property (strong, nonatomic) IBOutlet UIImageView *logo_ima;
@property (strong, nonatomic) IBOutlet UIView *backView;

@property (strong, nonatomic) IBOutlet UILabel *leveLab;

@end

NS_ASSUME_NONNULL_END
