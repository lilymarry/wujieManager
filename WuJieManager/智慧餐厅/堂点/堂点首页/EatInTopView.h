//
//  EatInTopView.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/6.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol SelectTopDelegate <NSObject>

- (void)selectTopWithArr:(NSArray*)Arr index:(NSString *  __nullable) index subIndex:(NSString *  __nullable) subIndex;

-(void)reset;

@end
@interface EatInTopView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;

@property (nonatomic, weak) id<SelectTopDelegate> delegate;

-(void)reloadData:(NSArray *)dataArr index:(NSString *) index subIndex:(NSString *) subIndex;


@end

NS_ASSUME_NONNULL_END
