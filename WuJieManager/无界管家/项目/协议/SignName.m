//
//  SignName.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/22.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "SignName.h"
#import "HJSignatureView.h"
@interface SignName ()
@property (nonatomic, strong) HJSignatureView *signatureView;

@property (strong, nonatomic) IBOutlet UIView *dataView;

@end

@implementation SignName

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SignName" owner:self options:nil];
        [self addSubview:_thisView];
        
        if (!_signatureView) {
            _signatureView = [[HJSignatureView alloc] initWithFrame:CGRectMake(0, 2, ScreenW, self.dataView.frame.size.height-5)];
          
             [self.dataView addSubview:self.signatureView];
            
        }
      
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

- (IBAction)surePress:(id)sender {
    [self.signatureView saveTheSignatureSuccess:^(NSData *imageData) {
        
        if (self->_block)
        {
            self->_block(imageData);
        }

        [self removeFromSuperview];
    } andFailure:^(NSString *error) {
        [MBProgressHUD showError:@"签名不存在" toView:self.superview];

    }];
}
- (IBAction)clearPress:(id)sender {
     [self.signatureView clear];
}
- (IBAction)cancelPress:(id)sender {
    [self removeFromSuperview];
}


@end
