//
//  AddBanquetCell_2.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/10.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddBanquetCell_2 : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *dateBtn;
@property (strong, nonatomic) IBOutlet UILabel *dateLab;


@property (strong, nonatomic) IBOutlet UIView *typeView;
@property (strong, nonatomic) IBOutlet UIButton *typeBtn;
@property (strong, nonatomic) IBOutlet UILabel *typeLab;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *typeViewHH;


@property (strong, nonatomic) IBOutlet UIView *startView;
@property (strong, nonatomic) IBOutlet UIButton *startBtn;
@property (strong, nonatomic) IBOutlet UILabel *startLab;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *startViewHH;


@property (strong, nonatomic) IBOutlet UIView *endView;
@property (strong, nonatomic) IBOutlet UIButton *endBtn;
@property (strong, nonatomic) IBOutlet UILabel *endLab;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *endViewHH;



@property (strong, nonatomic) IBOutlet UIButton *tableBtn;
@property (strong, nonatomic) IBOutlet UIButton *foodBtn;
@end

NS_ASSUME_NONNULL_END
