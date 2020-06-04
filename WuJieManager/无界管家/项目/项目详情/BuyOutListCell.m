//
//  BuyOutListCell.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/18.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "BuyOutListCell.h"

@implementation BuyOutListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _headImage.layer.masksToBounds = YES;
    _headImage.layer.cornerRadius = _headImage.frame.size.width/2;
    _headImage.layer.borderWidth = 0.1;
    _headImage.layer.borderColor =[UIColor clearColor].CGColor;
    
    _jiaobtn.layer.masksToBounds = YES;
    _jiaobtn.layer.cornerRadius = 6;
    _jiaobtn.layer.borderWidth = 1;
    _jiaobtn.layer.borderColor =navigationColor.CGColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
