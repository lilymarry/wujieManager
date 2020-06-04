//
//  WorkFirstTopViewCell.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/17.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WorkFirstTopViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;
+(void)xibWithCollectionView:(UICollectionView *)collectionView;
+(NSString *)cellIdentifier;
@end

NS_ASSUME_NONNULL_END
