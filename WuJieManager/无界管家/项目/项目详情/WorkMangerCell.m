//
//  WorkMangerCell.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/18.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WorkMangerCell.h"

@implementation WorkMangerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:_titleLab.text];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:navigationColor range:NSMakeRange(0,1)];
    [AttributedStr addAttribute:NSBackgroundColorAttributeName value:navigationColor range:NSMakeRange(0,1)];
     _titleLab.attributedText = AttributedStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
