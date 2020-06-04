//
//  BanquetPayType.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/13.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "BanquetPayType.h"

@interface BanquetPayType ()
@property (nonatomic ,strong)IBOutlet UIImageView *payType_imagV1;
@property (nonatomic ,strong)IBOutlet UIImageView *payType_imagV2;
@property (nonatomic ,strong)IBOutlet UIImageView *payType_imagV3;
@property (nonatomic ,strong)IBOutlet UIButton *payType_btnV1;
@property (nonatomic ,strong)IBOutlet UIButton *payType_btnV2;
@property (nonatomic ,strong)IBOutlet UIButton *payType_btnV3;

@property (nonatomic ,strong)IBOutlet UILabel *payType_labV1;
@property (nonatomic ,strong)IBOutlet UILabel *payType_labV2;
@property (nonatomic ,strong)IBOutlet UILabel *payType_labV3;


@property (nonatomic ,strong)IBOutlet UIView *payType_V2;


@property (nonatomic ,strong)IBOutlet UILabel *payType_titleLab;
@property (nonatomic ,strong)IBOutlet NSLayoutConstraint *viewWW;
@property (nonatomic ,strong)IBOutlet NSLayoutConstraint *view2WW;

@end

@implementation BanquetPayType

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"BanquetPayType" owner:self options:nil];
        [self addSubview:_thisView];
        
        _payType_imagV1.image=[UIImage imageNamed:@"圆形选中"];
        _payType_imagV2.image=[UIImage imageNamed:@"圆形未选中"];
         _payType_imagV3.image=[UIImage imageNamed:@"圆形未选中"];
        _payType_btnV1.selected=YES;
        _payType_btnV2.selected=NO;
        _payType_btnV3.selected=NO;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
-(void)setType:(NSString *)type
{
    _type=type;
    if ([type isEqualToString:@"1"]) {
        _payType_titleLab.text=@"选择结账方式";
        _viewWW.constant=210;
        _view2WW.constant=0;
        _payType_V2.hidden=YES;
    }
    else
    {
         _payType_titleLab.text=@"选择宴会时间";
        _payType_labV1.text=@"早宴";
        _payType_labV2.text=@"午宴";
        _payType_labV3.text=@"晚宴";
    }
    
    
}
- (IBAction)cancellPress:(id)sender {
    [self removeFromSuperview];
}
-(IBAction)payType:(UIButton *)sender
{

    if (sender.selected) {
        return;
    }
    else{
        sender.selected=YES;
        
        if (sender.tag==1001) {
            _payType_imagV1.image=[UIImage imageNamed:@"圆形选中"];
            _payType_imagV2.image=[UIImage imageNamed:@"圆形未选中"];
            _payType_imagV3.image=[UIImage imageNamed:@"圆形未选中"];
            _payType_btnV1.selected=YES;
            _payType_btnV2.selected=NO;
            _payType_btnV3.selected=NO;
            
        }
       else if (sender.tag==1002) {
           _payType_imagV1.image=[UIImage imageNamed:@"圆形未选中"];
           _payType_imagV2.image=[UIImage imageNamed:@"圆形选中"];
           _payType_imagV3.image=[UIImage imageNamed:@"圆形未选中"];
           _payType_btnV1.selected=NO;
           _payType_btnV2.selected=YES;
           _payType_btnV3.selected=NO;
            
        }
        else
        {
            _payType_imagV1.image=[UIImage imageNamed:@"圆形未选中"];
            _payType_imagV2.image=[UIImage imageNamed:@"圆形未选中"];
            _payType_imagV3.image=[UIImage imageNamed:@"圆形选中"];
            _payType_btnV1.selected=NO;
            _payType_btnV2.selected=NO;
            _payType_btnV3.selected=YES;
        }
      
    }
    
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
