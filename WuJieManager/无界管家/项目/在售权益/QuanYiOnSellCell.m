//
//  QuanYiOnSellCell.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/22.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "QuanYiOnSellCell.h"

@implementation QuanYiOnSellCell

- (void)awakeFromNib {
    [super awakeFromNib];
 
    _subTitle.layer.masksToBounds = YES;
    _subTitle.layer.cornerRadius = 6;
    _subTitle.layer.borderWidth = 1;
   _subTitle.layer.borderColor =color(253, 225, 206).CGColor;
    _subTitle.backgroundColor=color(253, 225, 206);
    
    
    NSString *str1 =@"186";
    NSString *str2 =@"权益单价(元)";
    
    NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n%@",str1,str2]];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:115/255.0 blue:32/255.0 alpha:1] range:NSMakeRange(0 , str1.length)];
    
    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0 , str1.length)];
    
    [_danjiaLab setAttributedText:AttributedStr];
  
    
    NSString *str3 =@"100";
    NSString *str4 =@"在售份数";
    
    NSMutableAttributedString * AttributedStr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n%@",str3,str4]];
    [AttributedStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0 , str3.length)];
    [AttributedStr1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0 , str3.length)];
    _onSellNum .attributedText=AttributedStr1;
    
    NSString *str5 =@"66";
    NSString *str6 =@"起售份数";
    
    NSMutableAttributedString * AttributedStr2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n%@",str5,str6]];
    [AttributedStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0 , str3.length)];
       [AttributedStr2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0 , str5.length)];
    _beganSellNum .attributedText=AttributedStr2;
    
   _danjiaLab.lineBreakMode = NSLineBreakByWordWrapping;
   _danjiaLab.textAlignment = NSTextAlignmentCenter;
   
    _onSellNum.lineBreakMode = NSLineBreakByWordWrapping;
    _onSellNum.textAlignment = NSTextAlignmentCenter;
    
    _beganSellNum.lineBreakMode = NSLineBreakByWordWrapping;
    _beganSellNum.textAlignment = NSTextAlignmentCenter;
    
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
