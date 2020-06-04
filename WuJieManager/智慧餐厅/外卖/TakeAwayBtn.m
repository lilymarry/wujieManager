//
//  TakeAwayBtn.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/9.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "TakeAwayBtn.h"

@interface TakeAwayBtn()

@end
@implementation TakeAwayBtn


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _lineView =[[UIView alloc ]initWithFrame:CGRectMake(0, self.bounds.size.height-2, self.bounds.size.width, 1.5)];
        _lineView.backgroundColor=navigationHotelColor;
        [self addSubview:_lineView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
      _lineView .frame=CGRectMake(0, self.bounds.size.height-2, self.bounds.size.width, 1.5);
}
@end
