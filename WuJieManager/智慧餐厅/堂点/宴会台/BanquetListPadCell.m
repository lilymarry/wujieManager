//
//  BanquetListPadCell.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/22.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "BanquetListPadCell.h"

@implementation BanquetListPadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _detailBtn.layer.masksToBounds = YES;
    _detailBtn.layer.cornerRadius = 5;
    _detailBtn.layer.borderWidth = 1;
    _detailBtn.layer.borderColor =navigationHotelColor.CGColor;
    [_detailBtn setTitleColor:navigationHotelColor forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
