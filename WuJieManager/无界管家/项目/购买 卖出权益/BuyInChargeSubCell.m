//
//  BuyInChargeSubCell.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/24.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "BuyInChargeSubCell.h"

@implementation BuyInChargeSubCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _backView.layer.masksToBounds = YES;
    _backView.layer.cornerRadius = 4;
    _backView.layer.borderWidth = 1; 
}
+(void)xibWithCollectionView:(UICollectionView *)collectionView{
    [collectionView registerNib:[UINib nibWithNibName:[BuyInChargeSubCell cellIdentifier] bundle:nil]
     forCellWithReuseIdentifier:[BuyInChargeSubCell cellIdentifier]];
}

+(NSString *)cellIdentifier{
    return NSStringFromClass([self class]);
}
@end
