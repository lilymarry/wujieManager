//
//  FoodDetailTopView.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/8/21.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "FoodDetailTopView.h"

#import "FoodDetailTopCell.h"

@interface FoodDetailTopView ()

{
    NSArray *dataArr;
    UIScrollView *_scrollView;
}

@end

@implementation FoodDetailTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"FoodDetailTopView" owner:self options:nil];
        [self addSubview:_thisView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
-(void)loadCollectonView:(NSArray *)data WithType:(NSString *)type
{
    dataArr=[NSArray arrayWithArray:data];
     [self refresPictureView];
}

- (void)refresPictureView
{
    
    
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,_backView.frame.size.width ,_backView.frame.size.height)];
        _scrollView.showsHorizontalScrollIndicator = YES;   //隐藏水平滚动条
        _scrollView.showsVerticalScrollIndicator = YES;     //隐藏垂直滚动条
        
        //横竖屏自适应
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        [_scrollView setBackgroundColor:[UIColor clearColor]];
        
        //添加到当前视图
        [_backView addSubview:_scrollView];
    }else{
        //清除子控件
        for (UIView *view in [_scrollView subviews]) {
            [view removeFromSuperview];
        }
    }
   
    
    if (dataArr.count>0) {
        CGFloat  viewWidth =158;
        
        CGFloat  viewHeight =120;
        _scrollView.contentSize = CGSizeMake((viewWidth+5) *(dataArr.count+1), 0);
        for (int i = 0 ; i < dataArr.count; i ++) {
            
            FoodDetailTopCell *TopView = [[FoodDetailTopCell alloc] initWithFrame:CGRectMake(5+(5+viewWidth)*i, 0, viewWidth, viewHeight)];
            OrderFoodAtterModel  *model=dataArr[i];
            [TopView.head_imagView sd_setImageWithURL:[NSURL URLWithString:model.picture] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            TopView.nameLab.text=model.dish_name;
            
            UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
            [bt setFrame:TopView.bounds];
            bt.tag = i;
            [bt addTarget:self action:@selector(whenClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [TopView addSubview:bt];
            
            [_scrollView addSubview:TopView];
        }
        
    }
  
    
    
}
-(void)whenClick:(id)sender
{
    UIButton *button=(UIButton *)sender;
  
    OrderFoodAtterModel *model=   dataArr[button.tag];
    if (self.selectTopViewBlock) {
        self.selectTopViewBlock(model);
    }
}

@end
