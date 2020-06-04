//
//  TakeAwayCell1.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/23.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TakeAwayCell1 : UICollectionViewCell
@property(weak,nonatomic)IBOutlet UIButton *stateBtn;
@property(weak,nonatomic)IBOutlet UIView *backView;

@property(weak,nonatomic)IBOutlet UILabel *moneyLab;

@property(weak,nonatomic)IBOutlet UILabel *reasonLab;
@property(weak,nonatomic)IBOutlet UIView *reasonFlagView;
@property(weak,nonatomic)IBOutlet NSLayoutConstraint *reasonFlagViewHH;

@property(weak,nonatomic)IBOutlet UIButton *oneBtn;
@property(weak,nonatomic)IBOutlet UIButton *twoBtn;
@end

NS_ASSUME_NONNULL_END
