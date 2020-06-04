//
//  HDLeftTableViewCell.h
//  HDClassifyTable
//
//  Created by 天津沃天科技 on 2019/5/14.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const kHDLeftTableViewCellIdentifier;

@interface HDLeftTableViewCell : UITableViewCell
@property(nonatomic, assign) BOOL isHave;//是否有图
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIImageView *titleImag;
@end
