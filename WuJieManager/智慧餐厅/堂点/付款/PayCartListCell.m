//
//  PayCartListCell.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/9/5.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "PayCartListCell.h"

@implementation PayCartListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //阴影效果
    self.bgview.layer.masksToBounds = NO;
    self.bgview.layer.shadowOffset = CGSizeMake(0, 4);
    self.bgview.layer.shadowOpacity = 1.2;
    self.bgview.layer.shadowColor=[UIColor lightGrayColor].CGColor;
    self.bgview.layer.borderColor=[UIColor clearColor].CGColor;
    self.bgview.layer.borderWidth=1;
    //虚线
    [self addBorderToLayer:self.lineview];
    
    _head_ImaView.layer.masksToBounds = YES;
    _head_ImaView.layer.cornerRadius = _head_ImaView.frame.size.width/2;
    _head_ImaView.layer.borderWidth = 1;
    _head_ImaView.layer.borderColor =[UIColor clearColor].CGColor;
    
}
- (void)addBorderToLayer:(UIView *)view
{
    CAShapeLayer *border = [CAShapeLayer layer];
    //  线条颜色
    border.strokeColor = [UIColor whiteColor].CGColor;
    border.fillColor = nil; //填充不要设置颜色
    UIBezierPath *pat = [UIBezierPath bezierPath];
    [pat moveToPoint:CGPointMake(0, 0)];
    if (CGRectGetWidth(view.frame) > CGRectGetHeight(view.frame)) {
        [pat addLineToPoint:CGPointMake(view.bounds.size.width, 0)];
    }else{
        [pat addLineToPoint:CGPointMake(0, view.bounds.size.height)];
    }
    border.path = pat.CGPath;
    
    border.frame = view.bounds;
    
    // 不要设太大 不然看不出效果
    border.lineWidth = 0.6;
    border.lineCap = @"butt";
    
    //  第一个是 线条长度   第二个是间距    nil时为实线
    border.lineDashPattern = @[@6, @10];
    
    [view.layer addSublayer:border];
}
@end
