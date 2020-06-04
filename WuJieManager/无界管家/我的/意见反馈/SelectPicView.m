//
//  SelectPicView.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/29.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "SelectPicView.h"
#import "UImageHelper.h"
@interface SelectPicView()<UIScrollViewDelegate>
{
    UIScrollView *scrollView;
    UIButton *addbt;
}
@property (nonatomic, strong)NSMutableArray *imageArrs;
@property (nonatomic, strong)NSMutableArray *saveImageView;

@end
@implementation SelectPicView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _saveImageView = [[NSMutableArray alloc] init];
        [self buildUI];
    }
    return self;
}

- (void)buildUI
{
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:scrollView];
    
}
- (void)refresPictureView:(NSArray *)lists
{
    self.imageArrs = (NSMutableArray *)lists;
    int imgNum =(int) self.imageArrs.count;
    for (UIImageView *imageView in _saveImageView) {
        [imageView removeFromSuperview];
    }
    [addbt removeFromSuperview];
  
    CGFloat  viewWidth =65;
    CGFloat  viewHeight =65;
    scrollView.contentSize = CGSizeMake((viewWidth+5) *(imgNum+1), 0);
    for (int i = 0 ; i < imgNum; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5+(5+viewWidth)*i, 0, viewWidth, viewHeight)];
        UIImage *data = [self.imageArrs objectAtIndex:i];
        
       [imageView setImage:[UImageHelper zipIma:data]];
        [imageView setUserInteractionEnabled:YES];
       
        imageView.tag =i;
        [scrollView addSubview:imageView];
        [_saveImageView addObject:imageView];
        
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap =
        [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(whenClickImage:)];
        [imageView addGestureRecognizer:singleTap];
        
        
        
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt setFrame:CGRectMake(viewWidth - 15,0, 15, 15)];
      
        [bt.layer setMasksToBounds:YES];
         bt.layer.cornerRadius = bt.frame.size.width/2;;
        
        [bt setTitle:@"X" forState:UIControlStateNormal];
        [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bt.titleLabel setFont:[UIFont systemFontOfSize:12]];
        bt.backgroundColor=navigationColor;
        bt.tag = i;
        [bt addTarget:self action:@selector(deletNowIma:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:bt];
        
        
        
    }
    addbt  = [UIButton buttonWithType:UIButtonTypeCustom];
    [addbt setFrame:CGRectMake(5+(5+viewWidth)*imgNum , 0, viewWidth, viewHeight)];
  //  [addbt setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
  //  [addbt.layer setMasksToBounds:YES];
   // addbt.layer.cornerRadius = 15;
    
   // [addbt setTitle:@"+" forState:UIControlStateNormal];
   // [addbt.titleLabel setFont:[UIFont systemFontOfSize:40]];
    [addbt setImage:[UIImage imageNamed:@"相机"] forState:UIControlStateNormal];
   // [addbt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addbt.tag = 8000;
    [addbt addTarget:self action:@selector(deletNowIma:) forControlEvents:UIControlEventTouchUpInside];
   
    [scrollView addSubview:addbt];
    if (imgNum==9) {
        addbt.hidden=YES;
    }
    else
    {
        addbt.hidden=NO;
    }
    [_saveImageView addObject:addbt];
    
    
}
-(void)deletNowIma:(id)sender
{
    UIButton *button=(UIButton *)sender;
    if (button.tag!=8000) {
        [self.imageArrs removeObjectAtIndex:button.tag];
        UIImageView *imgView = (UIImageView *)[self.saveImageView objectAtIndex:button.tag];
        [imgView removeFromSuperview];
        [self.saveImageView removeObjectAtIndex:button.tag];
    }
    
    if ([self.delegate respondsToSelector:@selector(removeImageView:andType:)]) {
        [self.delegate removeImageView:(int)button.tag andType:_typeStr];
    }
    
    
}

-(void)whenClickImage:(UITapGestureRecognizer *)gestureRecognizer
{
    
    UIImageView *imgView=(UIImageView *)[gestureRecognizer view];
    if ([self.delegate respondsToSelector:@selector(showImageView: andType:)]) {
        [self.delegate showImageView:(int)imgView.tag andType:_typeStr];
    }
    
}

@end
