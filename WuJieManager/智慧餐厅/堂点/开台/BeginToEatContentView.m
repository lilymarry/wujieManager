//
//  BeginToEatContentView.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/6.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "BeginToEatContentView.h"

@interface BeginToEatContentView ()
//@property (weak, nonatomic) IBOutlet UIView *hiddenView;


@end

@implementation BeginToEatContentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"BeginToEatContentView" owner:self options:nil];
        [self addSubview:_thisView];
        
   //     _isMemberBtn.selected=YES;

      //  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyHiden:) name: UIKeyboardWillHideNotification object:nil];
      //  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyWillAppear:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (void)loadContentView
{
    if ([_title isEqualToString:@"选择顾客角色后开台"]||[_title isEqualToString:@"非会员"]) {
        _isNotMemberBtn.selected=YES;
    }
    else
    {
        _isMemberBtn.selected=YES;
    }
}
- (IBAction)cancellPress:(id)sender {
     [self removeFromSuperview];
}
- (IBAction)selectMember:(id)sender {
    UIButton *btn =(UIButton *)sender;
    if (btn.selected) {
        return;
    }
    else
    {
      
        if (btn.tag==1001) {
            _isMemberBtn.selected=YES;
            _isNotMemberBtn.selected=NO;
  
            
        }
        else
        {
            _isMemberBtn.selected=NO;
            _isNotMemberBtn.selected=YES;
       
        }
    }
}

//-(void)keyHiden:(NSNotification *)notification
//{
//    
//    [UIView animateWithDuration:0.25 animations:^{
//        //恢复原样
//        _thisView.transform = CGAffineTransformIdentity;
//        
//    }];
//    
//    
//}
//-(void)keyWillAppear:(NSNotification *)notification
//{
//    //获得通知中的info字典
//    NSDictionary *userInfo = [notification userInfo];
//    CGRect rect= [[userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
//    
//    [UIView animateWithDuration:0.25 animations:^{
//        _thisView.transform = CGAffineTransformMakeTranslation(0, -([UIScreen mainScreen].bounds.size.height-rect.origin.y)+240);
//     
//    }];
//    
//    
//}

- (IBAction)sureBtn:(id)sender {
    [self removeFromSuperview];
    NSString *type;
    NSString *name;
    if ( _isMemberBtn.selected) {
        type=@"1";//会员是1
        name=_isMemberBtn.titleLabel.text;
    }
    if (_isNotMemberBtn.selected) {
         type=@"2";//非会员是2
         name=_isNotMemberBtn.titleLabel.text;
    }
    if (self.delegate!=nil &&[self.delegate respondsToSelector:@selector(beginToEaWithArr:andType:index:)]) {
        [self.delegate beginToEaWithArr:name andType:type index:_index];
    }
}
@end
