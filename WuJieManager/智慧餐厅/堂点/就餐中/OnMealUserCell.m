//
//  OnMealUserCell.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/8/16.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "OnMealUserCell.h"

@implementation OnMealUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _headImag.layer.masksToBounds = YES;
    _headImag.layer.cornerRadius = _headImag.frame.size.width/2;
    _headImag.layer.borderWidth = 0.1;
    _headImag.layer.borderColor =[UIColor clearColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
