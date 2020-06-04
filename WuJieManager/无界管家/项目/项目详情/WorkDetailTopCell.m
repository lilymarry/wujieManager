//
//  WorkDetailTopCell.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/23.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WorkDetailTopCell.h"

@implementation WorkDetailTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(void)xibWithCollectionView:(UICollectionView *)collectionView{
    [collectionView registerNib:[UINib nibWithNibName:[WorkDetailTopCell cellIdentifier] bundle:nil]
     forCellWithReuseIdentifier:[WorkDetailTopCell cellIdentifier]];
}

+(NSString *)cellIdentifier{
    return NSStringFromClass([self class]);
}
@end
