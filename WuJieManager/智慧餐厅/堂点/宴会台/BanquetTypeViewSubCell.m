//
//  BanquetTypeViewSubCell.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/10.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "BanquetTypeViewSubCell.h"

@implementation BanquetTypeViewSubCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _nameLab.layer.masksToBounds = YES;
    _nameLab.layer.cornerRadius = 6;
    _nameLab.layer.borderWidth = 1;
    _nameLab.layer.borderColor =[UIColor clearColor].CGColor;
    _nameLab.backgroundColor=[UIColor groupTableViewBackgroundColor];
      _nameLab.adjustsFontSizeToFitWidth=YES ;
}

@end
