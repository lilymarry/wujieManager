//
//  FoodDetailFootView.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/8/21.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderFoodListModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^SelectFootView) (OrderFoodListModel *model);
@interface FoodDetailFootView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (nonatomic, copy) SelectFootView selectFootViewBlock;
-(void)loadCollectonView:(NSArray *)data;
@end

NS_ASSUME_NONNULL_END
