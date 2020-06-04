//
//  WorkDetailTopCell.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/23.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WorkDetailTopCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UIButton *stateBtn;


+(void)xibWithCollectionView:(UICollectionView *)collectionView;
+(NSString *)cellIdentifier;

@end

NS_ASSUME_NONNULL_END
