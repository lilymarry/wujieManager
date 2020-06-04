//
//  WorkFirstTopViewCell.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/17.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WorkFirstTopViewCell.h"

@implementation WorkFirstTopViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(void)xibWithCollectionView:(UICollectionView *)collectionView{
    [collectionView registerNib:[UINib nibWithNibName:[WorkFirstTopViewCell cellIdentifier] bundle:nil]
     forCellWithReuseIdentifier:[WorkFirstTopViewCell cellIdentifier]];
}

+(NSString *)cellIdentifier{
    return NSStringFromClass([self class]);
}
@end
