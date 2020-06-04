//
//  CombineTable.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/7.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "CombineTable.h"

@interface CombineTable ()

@end

@implementation CombineTable

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"CombineTable" owner:self options:nil];
        [self addSubview:_thisView];
        
 
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (IBAction)cancellPress:(id)sender {
   
    [self removeFromSuperview];
}

- (IBAction)selectTablePress:(id)sender {
    
   
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
