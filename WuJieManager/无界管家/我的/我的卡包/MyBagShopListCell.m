//
//  MyBagShopListCell.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/25.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "MyBagShopListCell.h"

@implementation MyBagShopListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _backView.layer.masksToBounds = YES;
    _backView.layer.cornerRadius = 5;
    _backView.layer.borderWidth = 0.5;
    _backView.layer.borderColor =[UIColor lightGrayColor].CGColor;
}

@end
