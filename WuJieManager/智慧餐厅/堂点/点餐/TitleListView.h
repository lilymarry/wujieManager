//
//  TitleListView.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/7/4.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^TitleListViewBlock)(NSString * title, NSString *titleId);
typedef void(^CansellListViewBlock)(void);
@interface TitleListView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (nonatomic, copy) TitleListViewBlock titleListViewBlock ;
@property (nonatomic, copy) CansellListViewBlock cansellListViewBlock ;
-(void)reloadTabView:(NSArray *)data;
@end

NS_ASSUME_NONNULL_END
