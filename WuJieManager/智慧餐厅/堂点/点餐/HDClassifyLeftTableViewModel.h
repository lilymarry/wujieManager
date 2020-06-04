//
//  HDClassifyLeftTableViewModel.h
//  HDClassifyTable
//
//  Created by 天津沃天科技 on 2019/5/14.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDClassifyTableViewDatasource+left.h"

extern NSString * const kHDClassifyLeftTableViewModelSelected;
extern NSString * const kHDClassifyLeftTableViewModelDataKeyName;
extern NSString * const kHDClassifyLeftTableViewModelDataKeyid;

extern NSString * const kHDClassifyLeftTableViewModelDataKeyChildNode;


@protocol HDClassifyLeftTableViewModelDelegate;

@interface HDClassifyLeftTableViewModel : NSObject

@property (nonatomic, strong) NSArray *dataSource;


@property (nonatomic, weak) id <HDClassifyLeftTableViewModelDelegate> delegate;

@property (nonatomic, strong, readonly) UITableView *tableView;

- (void)selectAtIndexPathFromRight:(NSIndexPath *)indexPathRight;

- (void)scrollToSelectedSection;

@end

@protocol HDClassifyLeftTableViewModelDelegate <NSObject>

- (void)classifyLeftTableViewModel:(HDClassifyLeftTableViewModel *)viewModel didSelectedAtIndexPath:(NSIndexPath *)indexPath;

@end
