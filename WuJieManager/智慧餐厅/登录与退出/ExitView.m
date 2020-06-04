//
//  ExitView.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/7/1.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "ExitView.h"
#import "DelectToken.h"
#import "LoginIn.h"
@interface ExitView ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHH;

@end

@implementation ExitView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"ExitView" owner:self options:nil];
        [self addSubview:_thisView];
        if (KIsiPhoneX) {
            _topHH.constant=85;
        }
        else
        {
            _topHH.constant=62;
         
            
        }
        
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

- (IBAction)exitBtn:(id)sender {
    
    DelectToken *token=[[DelectToken alloc]init];
     [MBProgressHUD showMessage:nil toView:self];
    [token DelectTokenSuccessBlock:^(NSString * _Nonnull code, NSString * _Nonnull message) {
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        
        if ([code intValue]==200) {
            LoginIn *login=[[LoginIn alloc]init];
            AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            appdelegate.window.rootViewController=login;;
            
         
        }
        else
        {
           [MBProgressHUD showSuccess:message toView:self];
        }
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self];
    }];
    
  
    
}
- (IBAction)setBtn:(id)sender {
    
}


@end
