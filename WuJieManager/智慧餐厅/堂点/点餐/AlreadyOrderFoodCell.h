//
//  AlreadyOrderFoodCell.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/14.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlreadyOrderFoodCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *moveImaView;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *subNameLab;
@property (strong, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (strong, nonatomic) IBOutlet UIButton *reduceBtn;
@property (strong, nonatomic) IBOutlet UILabel *price;
@end

NS_ASSUME_NONNULL_END
