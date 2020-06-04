//
//  MyQuanyiListCell.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/22.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "MyQuanyiListCell.h"

@implementation MyQuanyiListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _subTitle.layer.masksToBounds = YES;
    _subTitle.layer.cornerRadius = 4;
    _subTitle.layer.borderWidth = 1;
  //  _subTitle.layer.borderColor =color(253, 225, 206).CGColor;
  //  _subTitle.backgroundColor=color(253, 225, 206);

    _quanyiLab.lineBreakMode = NSLineBreakByWordWrapping;
   _quanyiLab.textAlignment = NSTextAlignmentCenter;
    
    _fenhongLab.lineBreakMode = NSLineBreakByWordWrapping;
    _fenhongLab.textAlignment = NSTextAlignmentCenter;
    
   _shenqianLab.lineBreakMode = NSLineBreakByWordWrapping;
    _shenqianLab.textAlignment = NSTextAlignmentCenter;
    
    _zhuanMaiLab.lineBreakMode = NSLineBreakByWordWrapping;
    _zhuanMaiLab.textAlignment = NSTextAlignmentCenter;
    
    _fajuanLab.lineBreakMode = NSLineBreakByWordWrapping;
    _fajuanLab.textAlignment = NSTextAlignmentCenter;
    
    _quanyiLab.layer.masksToBounds = YES;
    _quanyiLab.layer.cornerRadius = _quanyiLab.frame.size.width/2;
    _quanyiLab.layer.borderWidth = 2;
    _quanyiLab.layer.borderColor =[UIColor colorWithRed:255/255.0 green:115/255.0 blue:32/255.0 alpha:1].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
