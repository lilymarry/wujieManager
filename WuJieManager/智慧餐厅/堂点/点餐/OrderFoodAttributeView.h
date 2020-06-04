//
//  OrderFoodAttributeView.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/16.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^OrderFoodAttributeViewBlock)(NSInteger num);
@interface OrderFoodAttributeView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) NSString *id;   //套餐
@property (strong, nonatomic) NSString *dishes_id;//单品
@property (strong, nonatomic) NSString *mic_id;//0套餐 非0单品
@property (strong, nonatomic) NSString *menu_id;
@property (strong, nonatomic) NSString *cart_id;
@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSDictionary *dataDic; //当前属性
@property(nonatomic,strong)NSString *desk_id;
@property (nonatomic, copy) OrderFoodAttributeViewBlock orderFoodAttributeViewBlock ;

-(void)loadOrderFoodAttributeView;
@end

NS_ASSUME_NONNULL_END
