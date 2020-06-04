//
//  MyBagShopListCell.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/25.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyBagShopListCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;

@end

NS_ASSUME_NONNULL_END
