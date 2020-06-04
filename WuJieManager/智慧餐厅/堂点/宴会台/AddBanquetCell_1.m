//
//  AddBanquetCell_1.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/10.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "AddBanquetCell_1.h"

@implementation AddBanquetCell_1

- (void)awakeFromNib {
    [super awakeFromNib];
    _inforBtn.layer.masksToBounds = YES;
    _inforBtn.layer.cornerRadius = 5;
    _inforBtn.layer.borderWidth = 1;
    _inforBtn.layer.borderColor =navigationHotelColor.CGColor;
    [_inforBtn setTitleColor:navigationHotelColor forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
