//
//  MyQuanyiDetailCell.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/23.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "MyQuanyiDetailCell.h"

@implementation MyQuanyiDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];

    
    self.colorView.layer.masksToBounds = YES;
    self.colorView.layer.cornerRadius =  self.colorView.bounds.size.width * 0.5;
    self.colorView.layer.borderWidth =2.0;
    self.colorView.backgroundColor=[UIColor clearColor];
    
    //随机颜色
  //  int R = (arc4random() % 256) ;
   // int G = (arc4random() % 256) ;
  //  int B = (arc4random() % 256) ;
//   self.colorView.layer.borderColor =color(R, G, B).CGColor;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
