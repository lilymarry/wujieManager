//
//  WorkFirstCell.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/17.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WorkFirstCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imaView;
@property (strong, nonatomic) IBOutlet UIView *progressView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *progressViewHH;
@property (strong, nonatomic) IBOutlet UILabel *stateLab;

@property (strong, nonatomic) IBOutlet UIView *backView;

@property (strong, nonatomic) IBOutlet UILabel *onSellNum;
@property (strong, nonatomic) IBOutlet UILabel *sumNum;
@property (strong, nonatomic) IBOutlet UIView *numView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *numViewHHH;
@property (strong, nonatomic) IBOutlet UIButton *stateBtn;





@end

NS_ASSUME_NONNULL_END
