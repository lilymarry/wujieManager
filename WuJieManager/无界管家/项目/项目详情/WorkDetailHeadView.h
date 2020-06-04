//
//  WorkDetailHeadView.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/18.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WorkDetailHeadView : UIView
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *subTitleLab;
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UIImageView *flag_imageView;
@property (strong, nonatomic) IBOutlet UIButton *HeadViewBtn;

@end

NS_ASSUME_NONNULL_END
