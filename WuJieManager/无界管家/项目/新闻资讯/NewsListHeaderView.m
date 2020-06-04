//
//  NewsListHeaderView.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/18.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "NewsListHeaderView.h"

@interface NewsListHeaderView ()

@end

@implementation NewsListHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"NewsListHeaderView" owner:self options:nil];
        [self addSubview:_thisView];
        _timeLab.layer.masksToBounds = YES;
        _timeLab.layer.cornerRadius = 5;
       
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}


@end
