//
//  FoodDetailTopCell.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/8/26.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "FoodDetailTopCell.h"

@interface FoodDetailTopCell ()

@end

@implementation FoodDetailTopCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"FoodDetailTopCell" owner:self options:nil];
        [self addSubview:_thisView];
       
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
