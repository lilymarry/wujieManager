//
//  BanquetTimeView.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/13.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ChooseDateViewDelegate <NSObject>

-(void)chooseDateView:(NSString  *)data type:(NSString * )type;
@end
@interface BanquetTimeView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic)  IBOutlet UIDatePicker *datapicker;
@property (strong, nonatomic)  NSString *type;
@property (nonatomic,weak)id <ChooseDateViewDelegate>  delgate;
@end

NS_ASSUME_NONNULL_END
