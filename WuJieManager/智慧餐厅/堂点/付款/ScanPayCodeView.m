//
//  ScanPayCodeView.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/7/29.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "ScanPayCodeView.h"

@interface ScanPayCodeView ()
@property (weak, nonatomic) IBOutlet UIImageView *codeView;

@end

@implementation ScanPayCodeView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"ScanPayCodeView" owner:self options:nil];
        [self addSubview:_thisView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (IBAction)cansellPress:(id)sender {
    self.scanPayCodeViewBlock();
   
}
-(void)loadCodeView
{
    [_codeView sd_setImageWithURL:[NSURL URLWithString:_urlStr] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]]
    ;
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
