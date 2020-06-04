//
//  ScanPayCodeView.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/7/29.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ScanPayCodeViewBlock)( void);
@interface ScanPayCodeView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;

@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIButton *repiteBtn;
@property (nonatomic, copy) ScanPayCodeViewBlock scanPayCodeViewBlock ;

@property (strong, nonatomic) NSString *urlStr;
-(void)loadCodeView;

@end

NS_ASSUME_NONNULL_END
