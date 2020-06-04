//
//  LineDataCell.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/18.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LineDataCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *dataView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segment;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic)NSDictionary *titleDic;
@property (strong, nonatomic)UIWebView *web;
@end

NS_ASSUME_NONNULL_END
