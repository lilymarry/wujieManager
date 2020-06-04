//
//  TitleListView.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/7/4.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^BeginToEatNumViewBlock)(NSString * title, NSString *titleId);
typedef void(^CansellListViewBlock)(void);
@interface BeginToEatNumView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHHH;

@property (nonatomic, copy) BeginToEatNumViewBlock beginToEatNumViewBlock ;
@property (nonatomic, copy) CansellListViewBlock cansellListViewBlock ;


-(void)reloadTabView:(NSArray *)data;
@end

NS_ASSUME_NONNULL_END
