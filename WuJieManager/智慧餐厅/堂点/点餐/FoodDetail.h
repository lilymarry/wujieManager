//
//  FoodDetail.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/8/21.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FoodDetail : UIViewController
@property (strong, nonatomic) NSString *id;   //套餐
@property (strong, nonatomic) NSString *dishes_id;//单品
@property (strong, nonatomic) NSString *mic_id;//0套餐 非0单品
@property (strong, nonatomic) NSArray *guessAllArr;//猜你喜欢全部数据
@property (strong, nonatomic) NSArray *guessArr;//猜你喜欢除去当前ID的全部数据
@property (strong, nonatomic) NSDictionary *dataDic; //当前属性
@property (strong, nonatomic) NSString *menu_id;
@property (strong, nonatomic) NSString *uid;
@property(nonatomic,strong)NSString *desk_id;

@end

NS_ASSUME_NONNULL_END
