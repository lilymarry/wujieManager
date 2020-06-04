//
//  HDClassifyRightTableViewModel.h
//  HDClassifyTable
//
//  Created by 天津沃天科技 on 2019/5/14.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDClassifyTableViewDatasource+right.h"

@protocol HDClassifyRightTableViewModelDelegate;

@interface HDClassifyRightTableViewModel : NSObject

@property (nonatomic, strong, readonly) UICollectionView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *contentData;
@property (nonatomic, weak) id <HDClassifyRightTableViewModelDelegate> delegate;

- (void)scrollToIndexPathFromLeft:(NSIndexPath *)indexPathFromLeft;

@end

@protocol HDClassifyRightTableViewModelDelegate <NSObject>
@optional
- (void)rightViewModel:(HDClassifyRightTableViewModel *)viewModel didScrollToIndexPath:(NSIndexPath *)indexPath;
- (void)rightViewModel:(HDClassifyRightTableViewModel *)viewModel didSelectToIndexPath:(NSIndexPath *)indexPath;
- (void)rightViewModel:(HDClassifyRightTableViewModel *)viewModel addToIndexPath:(NSIndexPath *)indexPath;
- (void)rightViewModel:(HDClassifyRightTableViewModel *)viewModel reduceToIndexPath:(NSIndexPath *)indexPath;
- (void)rightViewModel:(HDClassifyRightTableViewModel *)viewModel didSelectCellToIndexPath:(NSIndexPath *)indexPath;
@end
