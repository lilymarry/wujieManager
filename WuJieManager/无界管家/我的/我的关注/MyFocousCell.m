//
//  MyFocousCell.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/23.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "MyFocousCell.h"

@implementation MyFocousCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _guanzhuBtn.layer.masksToBounds = YES;
    _guanzhuBtn.layer.cornerRadius = 6;
    _guanzhuBtn.layer.borderWidth = 1;
    _guanzhuBtn.layer.borderColor =color(255, 100, 85).CGColor;
    _guanzhuBtn.backgroundColor=[UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
