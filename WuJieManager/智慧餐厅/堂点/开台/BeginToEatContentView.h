//
//  BeginToEatContentView.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/6.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  BeginToEatDelegate <NSObject>

- (void)beginToEaWithArr:(NSString*)name andType:(NSString *)type  index:(NSIndexPath*)index;

@end
@interface BeginToEatContentView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UIButton *isMemberBtn;
@property (strong, nonatomic) IBOutlet UIButton *isNotMemberBtn;
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (nonatomic, strong) NSIndexPath *index;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, weak) id<BeginToEatDelegate> delegate;
- (IBAction)sureBtn:(id)sender;
- (void)loadContentView;

@end

NS_ASSUME_NONNULL_END
