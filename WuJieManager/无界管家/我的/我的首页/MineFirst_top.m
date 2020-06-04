//
//  WAMine_top.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/8.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "MineFirst_top.h"

@interface MineFirst_top ()
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation MineFirst_top
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"MineFirst_top" owner:self options:nil];
        [self addSubview:_thisView];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 15;
        _backView.layer.borderWidth = 0.1;
        _backView.layer.borderColor =[UIColor clearColor].CGColor;
        
        _headImaView.layer.masksToBounds = YES;
        _headImaView.layer.cornerRadius = _headImaView.frame.size.width/2;
        _headImaView.layer.borderWidth = 0.1;
        _headImaView.layer.borderColor =[UIColor clearColor].CGColor;
        
        
        _my_leveLab.layer.masksToBounds = YES;
        _my_leveLab.layer.cornerRadius = 10;
        
        _shop_LeveLab.layer.masksToBounds = YES;
        _shop_LeveLab.layer.cornerRadius = 10;
        
        [_headImaView sd_setImageWithURL:[NSURL URLWithString:@"http://dev.wujiemall.com/Uploads/Merchant/2019-03-06/5c7f5beca8470.jpg"] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        
        
        
        NSString *str1 =@"权益收益(元)";
        NSString *str2 =@"0";
        
         [_oneBtn setTitle:[NSString stringWithFormat:@"%@\n%@",str1,str2] forState:UIControlStateNormal];
        
        NSString *str3 =@"权益市值(元)";
        NSString *str4 =@"0";
        

        [_twoBtn setTitle:[NSString stringWithFormat:@"%@\n%@",str3,str4] forState:UIControlStateNormal];

    
        
        _oneBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _oneBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
      
        _twoBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _twoBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
     
        _oneBtn.tag = 1;
        [_oneBtn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
      
        _twoBtn.tag = 2;
        [_twoBtn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        _threeBtn.tag = 3;
        [_threeBtn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (void)btnEvent:(id)sender {
    UIButton * btn = (UIButton *)sender;
    NSInteger num = btn.tag;
    self.topBtnBlock(num);
}

@end
