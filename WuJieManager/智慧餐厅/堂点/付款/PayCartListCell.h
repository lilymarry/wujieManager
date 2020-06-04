//
//  PayCartListCell.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/9/5.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PayCartListCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *bgview;
@property (weak, nonatomic) IBOutlet UIView *lineview;
@property (weak, nonatomic) IBOutlet UIImageView *head_ImaView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@property (weak, nonatomic) IBOutlet UILabel *typeLab;

@end

NS_ASSUME_NONNULL_END
