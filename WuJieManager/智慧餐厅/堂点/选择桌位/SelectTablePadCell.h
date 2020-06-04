//
//  SelectTableSubCell.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/22.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectTablePadCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet UIImageView *stateImaView;
@property (strong, nonatomic) IBOutlet UILabel *stateLab;
@end

NS_ASSUME_NONNULL_END
