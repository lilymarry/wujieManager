//
//  OnMealTopPadCell.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/21.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "OnMealTopPadCell.h"

@implementation OnMealTopPadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _headImaView.layer.masksToBounds = YES;
    _headImaView.layer.cornerRadius = _headImaView.frame.size.width/2;
    _headImaView.layer.borderWidth = 0.1;
    _headImaView.layer.borderColor =[UIColor clearColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
