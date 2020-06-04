//
//  EatInCell.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/6.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "EatInCell.h"

@implementation EatInCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _backView.layer.masksToBounds = YES;
    _backView.layer.cornerRadius = 5;
    _backView.layer.borderWidth = 1;
    _backView.layer.borderColor =[UIColor groupTableViewBackgroundColor].CGColor;
    
    _beginBtn.layer.masksToBounds = YES;
    _beginBtn.layer.cornerRadius = _beginBtn.frame.size.width/2;
    _beginBtn.layer.borderWidth = 1;
    _beginBtn.layer.borderColor =color(7, 189, 24).CGColor;
    
    _eatInBtn.layer.masksToBounds = YES;
    _eatInBtn.layer.cornerRadius = 5;
    _eatInBtn.layer.borderWidth = 1;
    _eatInBtn.layer.borderColor =navigationHotelColor.CGColor;
    [_eatInBtn setTitleColor:navigationHotelColor forState:UIControlStateNormal];
}

@end
