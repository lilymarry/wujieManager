//
//  BanquetTypeViewCell.h
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/10.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BanquetTypeDelegate <NSObject>

- (void)selectIndex:(NSIndexPath *)index andsubIndex:(NSIndexPath *) subIndex;

@end
@interface BanquetTypeViewCell : UITableViewCell

@property(nonatomic,strong)NSIndexPath *sumPath;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *nameLabWW;
@property (nonatomic, weak) id<BanquetTypeDelegate> delegate;
-(void)reloadCell:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
