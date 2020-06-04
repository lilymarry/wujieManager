//
//  WorkMangerDetailCell.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/18.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef void(^Data_HTML) (NSInteger num);
@interface WorkMangerDetailCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UIView * thisWk_web;
@property (nonatomic, strong) WKWebView * wk_web;//极速web
@property (nonatomic, copy) Data_HTML data_HTML;
- (void)wk_web:(NSString *)wk_webHTML;

@end

NS_ASSUME_NONNULL_END
