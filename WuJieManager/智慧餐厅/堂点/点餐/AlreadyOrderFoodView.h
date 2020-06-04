//
//  AlreadyOrderFoodView.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/14.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AlreadyOrderFoodViewBlock)( NSArray * __nullable data,NSString*type);
typedef void(^clearOrderFoodViewBlock)(void);
@interface AlreadyOrderFoodView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property(weak,nonatomic)IBOutlet NSLayoutConstraint *tableViewHH;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewWW;
@property (strong, nonatomic)  NSArray *data;
@property (strong, nonatomic) NSString *titleId;
@property (strong, nonatomic) NSString *cart_id;
@property(nonatomic,strong)NSString *uidStr;
@property(nonatomic,strong)NSString *desk_id;
@property (nonatomic, copy) AlreadyOrderFoodViewBlock alreadyOrderFoodViewBlock ;
@property (nonatomic, copy) clearOrderFoodViewBlock clearBlock ;

@end

NS_ASSUME_NONNULL_END
