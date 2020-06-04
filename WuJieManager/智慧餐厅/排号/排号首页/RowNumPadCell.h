//
//  RowNumCell.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/5.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RowNumPadCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *state_imageV;
@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UIView *view2;

@property (strong, nonatomic) IBOutlet UIImageView *view2_hao_imagV;
@property (strong, nonatomic) IBOutlet UILabel *view2_hao_lab;

@property (strong, nonatomic) IBOutlet UIImageView *view2_zuo_imagV;
@property (strong, nonatomic) IBOutlet UILabel *view2_zuo_lab;


@property (strong, nonatomic) IBOutlet UIImageView *ruHao_ImageV;
@property (strong, nonatomic) IBOutlet UIButton *ruhao_btn;



@property (strong, nonatomic) IBOutlet UIImageView *guoHao_imageV;
@property (strong, nonatomic) IBOutlet UIButton *guohao_btn;

@property (strong, nonatomic) IBOutlet UIImageView *jiaohao_imageV;

@property (strong, nonatomic) IBOutlet UIButton *jiaohao_btn;
@property (weak, nonatomic) IBOutlet UILabel *jiaohaoLab;



@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *subNameLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subNameWWW;



@end

NS_ASSUME_NONNULL_END
