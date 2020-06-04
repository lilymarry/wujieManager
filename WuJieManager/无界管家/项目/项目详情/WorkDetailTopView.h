//
//  WorkDetailTopView.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/18.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^WorkDetailEntryBlock)(NSString *typeModel);
@interface WorkDetailTopView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UIImageView *topImage;
@property (strong, nonatomic) IBOutlet UILabel *stateLab;
@property (strong, nonatomic) IBOutlet UIView *progressView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *progressViewHH;
@property (strong, nonatomic) IBOutlet UIButton *BuyOutBtn;

@property (strong, nonatomic) IBOutlet UIView *colView;
@property (strong, nonatomic) IBOutlet UICollectionView *collection;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *colViewHHH;


@property (nonatomic, copy) WorkDetailEntryBlock workDetailEntryBlock;

@property(nonatomic,strong)NSString *isGroup;
@property (strong, nonatomic) IBOutlet UIView *quanyiView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *quanyiViewHHH;



@end

NS_ASSUME_NONNULL_END
