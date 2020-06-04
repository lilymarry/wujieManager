//
//  FoodDetailTopView.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/8/21.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderFoodAtterModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^SelectTopView) (OrderFoodAtterModel *model);
@interface FoodDetailTopView : UIView

@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UIImageView *headImaView;
@property (strong, nonatomic) IBOutlet UIButton *addBtn;
@property (strong, nonatomic) IBOutlet UILabel *goods_nameLab;
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (strong, nonatomic) IBOutlet UIButton *reduceBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backViewHHH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headImaViewWW;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHH;


@property (nonatomic, copy) SelectTopView selectTopViewBlock;
-(void)loadCollectonView:(NSArray *)data WithType:(NSString *)type;
@end

NS_ASSUME_NONNULL_END
