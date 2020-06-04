//
//  OrderFoodRightCell1.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/22.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderFoodRightBtn.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrderFoodRightCell1 : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImaView;
@property (strong, nonatomic) IBOutlet OrderFoodRightBtn *addBtn;

@property (strong, nonatomic) IBOutlet UILabel *goods_nameLab;

@property (strong, nonatomic) IBOutlet UILabel *zong_timeLab;
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (strong, nonatomic) IBOutlet OrderFoodRightBtn *reduceBtn;

@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet OrderFoodRightBtn *tapImagBtn;



@end

NS_ASSUME_NONNULL_END
