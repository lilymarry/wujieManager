//
//  VideoGroupListView.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/24.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^VideoEntryBlock)(NSString *typeModel);
@interface VideoGroupListView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (nonatomic, copy) VideoEntryBlock videoEntryBlock;
@end

NS_ASSUME_NONNULL_END
