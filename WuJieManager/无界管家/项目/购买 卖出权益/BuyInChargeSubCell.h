//
//  BuyInChargeSubCell.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/24.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BuyInChargeSubCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *subtitle;

+(void)xibWithCollectionView:(UICollectionView *)collectionView;
+(NSString *)cellIdentifier;
@end

NS_ASSUME_NONNULL_END
