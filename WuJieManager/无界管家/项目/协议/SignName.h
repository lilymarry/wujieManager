//
//  SignName.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/22.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef  void (^SignNameFinishBlock)(NSData *data);
@interface SignName : UIView
@property(nonatomic,copy) SignNameFinishBlock block;

@property (strong, nonatomic) IBOutlet UIView *thisView;
@end

NS_ASSUME_NONNULL_END
