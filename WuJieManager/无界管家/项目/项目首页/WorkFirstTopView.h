//
//  WorkFirstTopView.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/17.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^UBShopTypeEntryBlock)(NSString *typeModel);
@interface WorkFirstTopView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UIView *cellsView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIView *newslineView;
@property (strong, nonatomic) IBOutlet UIButton *newsListBtn;

@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, copy) UBShopTypeEntryBlock typyEntryBlcok;
@end

NS_ASSUME_NONNULL_END
