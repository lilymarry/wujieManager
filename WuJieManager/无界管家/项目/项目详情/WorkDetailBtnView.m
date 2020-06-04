//
//  WorkDetailHeadView1.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/18.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WorkDetailBtnView.h"

@interface WorkDetailBtnView ()
@end
@implementation WorkDetailBtnView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"WorkDetailBtnView" owner:self options:nil];
        [self addSubview:_thisView];

        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

@end
