//
//  WorkFirstCell.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/17.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WorkFirstCell.h"

@implementation WorkFirstCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _backView.layer.masksToBounds = YES;
    _backView.layer.cornerRadius = 5;
    
    CGAffineTransform transform= CGAffineTransformMakeRotation(-M_PI*0.25);
    /*关于M_PI
     #define M_PI     3.14159265358979323846264338327950288
     其实它就是圆周率的值，在这里代表弧度，相当于角度制 0-360 度，M_PI=180度
     旋转方向为：顺时针旋转
     
     */
   _stateLab.transform = transform;//旋转
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
