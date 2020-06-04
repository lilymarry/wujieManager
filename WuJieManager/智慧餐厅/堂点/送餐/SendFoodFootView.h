//
//  SendFoodFootView.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/22.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SendFoodFootView : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIButton *setBtn;
@property (strong, nonatomic) IBOutlet UITextView *beizhu_Tx;
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (weak, nonatomic) IBOutlet UILabel *beizhuLab;


@end

NS_ASSUME_NONNULL_END
