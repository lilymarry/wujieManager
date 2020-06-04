//
//  OrderFoodAttributeAddCell.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/7/8.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderFoodRightBtn.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderFoodAttributeAddCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet OrderFoodRightBtn *addBtn;
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (strong, nonatomic) IBOutlet OrderFoodRightBtn *reduceBtn;


@end

NS_ASSUME_NONNULL_END
