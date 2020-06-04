//
//  HelpCenterCell.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/24.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HelpCenterCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *stateBtn;
@property (strong, nonatomic) IBOutlet UILabel *subLab;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *subLabHH;
@property (assign, nonatomic) BOOL state;
@property (strong, nonatomic) IBOutlet UILabel *numLab;


@end

NS_ASSUME_NONNULL_END
