//
//  OrderFoodAttributeSubCell.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/7/5.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "OrderFoodAttributeSubCell.h"

@implementation OrderFoodAttributeSubCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _nameLab.layer.cornerRadius=5;
    _nameLab.layer.masksToBounds=YES;
}

@end
