//
//  MyBagCell.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/25.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "MyBagCell.h"

@implementation MyBagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _logo_ima.layer.masksToBounds = YES;
    _logo_ima.layer.cornerRadius = _logo_ima.frame.size.width/2;
    _logo_ima.layer.borderWidth = 0.1;
    _logo_ima.layer.borderColor =[UIColor clearColor].CGColor;
    
    _backView.layer.masksToBounds = YES;
    _backView.layer.cornerRadius =5;
    
    _leveLab.layer.masksToBounds = YES;
    _leveLab.layer.cornerRadius = 5;
    _leveLab.layer.borderWidth = 0.5;
    _leveLab.layer.borderColor =[UIColor whiteColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
