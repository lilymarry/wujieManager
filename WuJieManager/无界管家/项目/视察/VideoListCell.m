//
//  VideoListCell.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/19.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "VideoListCell.h"

@implementation VideoListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _backView.layer.masksToBounds = YES;
    _backView.layer.cornerRadius = 5;
    
    _imaState.layer.masksToBounds = YES;
    _imaState.layer.cornerRadius = _imaState.frame.size.width/2;
    _imaState.layer.borderWidth = 0.1;
    _imaState.layer.borderColor =[UIColor clearColor].CGColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
