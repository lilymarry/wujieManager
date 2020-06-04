//
//  HDLeftTableHeaderView.m
//  HDClassifyTable
//
//  Created by 天津沃天科技 on 2019/5/14.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "HDLeftTableHeaderView.h"
#import "UIView+LayoutMethods.h"
NSString * const kHDLeftTableHeaderViewIdentifier = @"kHDLeftTableHeaderViewIdentifier";
NSString * const kHDLeftTableHeaderViewSetDeselectedNotification = @"kHDLeftTableHeaderViewSetDeselectedNotification";
extern NSString * const kHDClassifyLeftTableViewModelDataKeyName;
extern NSString * const kHDClassifyLeftTableViewModelSelected;

@interface HDLeftTableHeaderView ()
{
    BOOL isHave;//是否有图
}
@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *bottomView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIImageView *titleImag;
@end

@implementation HDLeftTableHeaderView
@synthesize isSelected = _isSelected;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(didReceivekHDLeftTableHeaderViewSetDeselectedNotification:)
        name:kHDLeftTableHeaderViewSetDeselectedNotification
                                                   object:nil];
      self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
      [self.contentView addSubview:self.titleButton];
   
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleButton fill];
 
    
    [self.bottomView setCt_x:0];
    [self.bottomView setCt_height:1];
    [self.bottomView setCt_width:self.titleButton.frame.size.width-3];
    [self.bottomView setCt_y:59];
    
    
    [self.lineView setCt_width:3];
    [self.lineView setCt_height:40];
    [self.lineView setCt_x:0];
    [self.lineView setCt_y:10];
    
    if (isHave) {
        [self.titleImag setCt_x:35];
        [self.titleImag setCt_y:5];
        [self.titleImag setCt_width:30];
        [self.titleImag setCt_height:30];
        
        
        [self.titleLabel setCt_x:3];
        [self.titleLabel setCt_y:37];
        [self.titleLabel setCt_width:self.frame.size.width-6];
        [self.titleLabel setCt_height:20];
        
    }
    else
    {
        [self.titleLabel setCt_x:3];
        [self.titleLabel setCt_y:20];
        [self.titleLabel setCt_width:self.frame.size.width-6];
        [self.titleLabel setCt_height:20];
    }
    
  
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kHDLeftTableHeaderViewSetDeselectedNotification object:nil];
}

#pragma mark - public methods
- (void)configWithData:(NSDictionary *)data
{
 
    if (data[kHDClassifyLeftTableViewModelDataKeyName]) {
    //    [self.titleButton setTitle:data[kHDClassifyLeftTableViewModelDataKeyName] forState:UIControlStateNormal];
        self.titleLabel.text=data[kHDClassifyLeftTableViewModelDataKeyName];
        NSString *url=data[@"img_url"];
        if ([url length]>0) {
           [self.titleImag sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
             self.titleImag.hidden=NO;
            isHave=YES;
        }
        else
        {
            self.titleImag.hidden=YES;
            isHave=NO;
        }
      
    }
    self.titleButton.selected = [data[kHDClassifyLeftTableViewModelSelected] boolValue];
    self.isSelected = [data[kHDClassifyLeftTableViewModelSelected] boolValue];
    self.lineView.backgroundColor = self.titleButton.selected ? [UIColor redColor]:[UIColor whiteColor];
    self.titleButton.backgroundColor= self.titleButton.selected ? [UIColor whiteColor]:[UIColor groupTableViewBackgroundColor];
    
    [self layoutSubviews];
    
  
}

#pragma mark - event response
- (void)didTappedTitleButton:(UIButton *)titleButton
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kHDLeftTableHeaderViewSetDeselectedNotification object:self];
    self.titleButton.selected = YES;
    self.isSelected = YES;
    self.titleButton.backgroundColor = [UIColor whiteColor];
    if ([self.delegate respondsToSelector:@selector(classifyListHeaderView:isExpended:isUserTapped:)]) {
        [self.delegate classifyListHeaderView:self isExpended:YES isUserTapped:YES];
    }
}

-(void)didReceivekHDLeftTableHeaderViewSetDeselectedNotification:(NSNotification *)notification
{
    if (notification.object == self) {
        if ([self.delegate respondsToSelector:@selector(classifyListHeaderView:isExpended:isUserTapped:)]) {
            [self.delegate classifyListHeaderView:self isExpended:YES isUserTapped:NO];
        }
    } else {
        self.isSelected = NO;
        if ([self.delegate respondsToSelector:@selector(classifyListHeaderView:isExpended:isUserTapped:)]) {
            [self.delegate classifyListHeaderView:self isExpended:NO isUserTapped:NO];
        }
    }
}

#pragma mark - Getters and Setters
- (UIButton *)titleButton
{
    if (_titleButton == nil) {
        _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
   //     [_titleButton setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    //    [_titleButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
     //   [self.titleButton setTitle:@"蛤蛤蛤蛤"forState:UIControlStateNormal];
        [_titleButton addTarget:self action:@selector(didTappedTitleButton:) forControlEvents:UIControlEventTouchUpInside];
    //    _titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _titleButton.backgroundColor = [UIColor whiteColor];
      
        if (_lineView==nil) {
            _lineView=[[UIView alloc]init];
            _lineView.backgroundColor=[UIColor redColor];
            [_titleButton addSubview:_lineView];
        }
       
        if (_titleImag==nil) {
            _titleImag=[[UIImageView alloc]init];
            [_titleButton addSubview:_titleImag];
        }
       
        if (_titleLabel==nil) {
            _titleLabel = [[UILabel alloc] init];
            _titleLabel.textColor = [UIColor blackColor];
            _titleLabel.textAlignment = NSTextAlignmentCenter;
            _titleLabel.font = [UIFont systemFontOfSize:14];
            [_titleButton addSubview:_titleLabel];
        }
       
        if (_bottomView==nil) {
            _bottomView = [[UIView alloc] init];
            _bottomView.backgroundColor = [UIColor lightTextColor];
           
            [_titleButton addSubview:_bottomView];
        }
        
    }
    return _titleButton;
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    self.titleButton.selected = isSelected;
    if (isSelected) {
         self.lineView.backgroundColor = [UIColor redColor];
         self.titleButton.backgroundColor = [UIColor whiteColor];
        self.titleLabel.textColor= [UIColor redColor];
    } else {
        self.lineView.backgroundColor = [UIColor whiteColor];
        self.titleButton.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.titleLabel.textColor= [UIColor blackColor];
    }
}

@end
