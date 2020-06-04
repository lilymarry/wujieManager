//
//  HDLeftTableViewCell.m
//  HDClassifyTable
//
//  Created by 天津沃天科技 on 2019/5/14.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "HDLeftTableViewCell.h"
#import "UIView+LayoutMethods.h"

NSString * const kHDLeftTableViewCellIdentifier = @"kHDLeftTableViewCellIdentifier";

@interface HDLeftTableViewCell ()
@property (nonatomic, strong) UIView *bottomView;
@end

@implementation HDLeftTableViewCell

#pragma mark - life cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         [self.contentView addSubview:self.titleImag];
        [self.contentView addSubview:self.titleLabel];
        
        [self.contentView addSubview:self.bottomView];
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleImag setCt_x:35];
    [self.titleImag setCt_y:0];
    [self.titleImag setCt_width:30];
    [self.titleImag setCt_height:30];
  
    if (_isHave) {
        [self.titleLabel setCt_x:0];
        [self.titleLabel setCt_y:37];
        [self.titleLabel setCt_width:self.frame.size.width];
        [self.titleLabel setCt_height:20];
    }
    
    else
    {
        [self.titleLabel setCt_x:0];
        [self.titleLabel setCt_y:20];
        [self.titleLabel setCt_width:self.frame.size.width];
        [self.titleLabel setCt_height:20];
    }
    [self.bottomView setCt_x:0];
    [self.bottomView setCt_height:1];
    [self.bottomView setCt_width:self.frame.size.width];
    [self.bottomView setCt_y:59];
}

#pragma mark - event response
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected) {
        self.titleLabel.textColor = [UIColor redColor];
    }else{
        self.titleLabel.textColor = [UIColor blackColor];
    }
}

#pragma mark - getters and setters
- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
        
       
    }
    return _titleLabel;
}
-(UIImageView *)titleImag
{
    if (_titleImag == nil) {
       _titleImag=[[UIImageView alloc]init];
    }
    return _titleImag;
}
-(UIView *)bottomView
{
    if (_bottomView==nil) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor lightTextColor];
        
    }
    return _bottomView;
}
@end
