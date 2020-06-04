//
//  VideoGroupListViewCell.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/24.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "VideoGroupListViewCell.h"

@implementation VideoGroupListViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _nameLab.layer.masksToBounds = YES;
    _nameLab.layer.cornerRadius = 8;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
