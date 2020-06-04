//
//  BuyInTypeCell.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/19.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BuyInTypeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ima_pay;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ima_payWW;
@property (weak, nonatomic) IBOutlet UILabel *lab_payName;
@property (weak, nonatomic) IBOutlet UIImageView *ima_state;



@end

NS_ASSUME_NONNULL_END
