//
//  HDClassifyLeftTableViewModel.m
//  HDClassifyTable
//
//  Created by 天津沃天科技 on 2019/5/14.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "HDClassifyLeftTableViewModel.h"
#import "HDLeftTableViewCell.h"
#import "HDLeftTableHeaderView.h"

NSString * const kHDClassifyLeftTableViewModelSelected = @"kHDClassifyLeftTableViewModelSelected";
NSString * const kHDClassifyLeftTableViewModelDataKeyName = @"kHDClassifyLeftTableViewModelDataKeyName";
NSString * const kHDClassifyLeftTableViewModelDataKeyChildNode = @"kHDClassifyLeftTableViewModelDataKeyChildNode";

NSString * const kHDClassifyLeftTableViewModelDataKeyid = @"kHDClassifyLeftTableViewModelDataKeyid";




@interface HDClassifyLeftTableViewModel ()<UITableViewDelegate, UITableViewDataSource, HDLeftTableHeaderViewDelegate>

@property (nonatomic, strong, readwrite) UITableView *tableView;

@property (nonatomic, strong) NSArray *contentData;
@property (nonatomic, assign) BOOL shouldStopCallback;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation HDClassifyLeftTableViewModel

#pragma mark - HDLeftTableHeaderViewDelegate
- (void)classifyListHeaderView:(HDLeftTableHeaderView *)classifyHeaderView isExpended:(BOOL)isExpended isUserTapped:(BOOL)isUserTapped
{
    NSMutableDictionary *dic = self.contentData[classifyHeaderView.section];
    dic[kHDClassifyLeftTableViewModelSelected] =[NSNumber numberWithBool:isExpended];
    NSMutableArray *indexArray = [NSMutableArray array];
    for (int i = 0; i < [dic[kHDClassifyLeftTableViewModelDataKeyChildNode] count]; i++) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:classifyHeaderView.section];
        [indexArray addObject:indexpath];
    }
 
    if (isExpended) {
        if ([self.tableView numberOfRowsInSection:classifyHeaderView.section] == 0) {
            [self.tableView insertRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        if (isUserTapped&&indexArray.count>0) {
            self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:classifyHeaderView.section];
        
          [self.tableView selectRowAtIndexPath:self.selectedIndexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
            self.shouldStopCallback = NO;
            if ([self.delegate respondsToSelector:@selector(classifyLeftTableViewModel:didSelectedAtIndexPath:)]) {
             
          [self.delegate classifyLeftTableViewModel:self didSelectedAtIndexPath:self.selectedIndexPath];
            }
        }
    } else {
        if ([self.tableView numberOfRowsInSection:classifyHeaderView.section] == indexArray.count) {
            [self.tableView deleteRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(classifyLeftTableViewModel:didSelectedAtIndexPath:)]) {
    [self.delegate classifyLeftTableViewModel:self didSelectedAtIndexPath:indexPath];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger result = 0;
    result = self.contentData.count;
    return result;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger result = 0;
    if ([self.contentData[section][kHDClassifyLeftTableViewModelSelected] boolValue]) {
        result = [self.contentData[section][kHDClassifyLeftTableViewModelDataKeyChildNode] count];
        self.selectedIndexPath = [NSIndexPath indexPathForRow:self.selectedIndexPath.row inSection:section];
    } else {
        result = 0;
    }
    return result;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HDLeftTableHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kHDLeftTableHeaderViewIdentifier];
    headerView.delegate = self;
    headerView.section = section;
    [headerView configWithData:self.contentData[section]];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HDLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHDLeftTableViewCellIdentifier];
    NSDictionary *titleDic = self.contentData[indexPath.section];
    NSString * title = titleDic[kHDClassifyLeftTableViewModelDataKeyChildNode][indexPath.row][kHDClassifyLeftTableViewModelDataKeyName];
    cell.titleLabel.text = title;
    
    NSString * url = titleDic[kHDClassifyLeftTableViewModelDataKeyChildNode][indexPath.row][@"img_url"];
    if (url.length>0) {
        cell.titleImag.hidden=NO;
        [cell.titleImag sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.isHave=YES;
    }
    else{
         cell.titleImag.hidden=YES;
        cell.isHave=NO;
    }
    
    [cell layoutSubviews];
    
    return cell;
}

#pragma mark - public methods
- (void)selectAtIndexPathFromRight:(NSIndexPath *)indexPathRight
{
    self.shouldStopCallback = YES;
    NSUInteger index = indexPathRight.section;
    NSUInteger result = 0;
    NSIndexPath *indexPathToSelect = nil;
    for (int i = 0; i < self.contentData.count; i++) {
        for (int j = 0; j < [self.contentData[i][kHDClassifyLeftTableViewModelDataKeyChildNode] count]; j++){
            if (result == index){
                indexPathToSelect = [NSIndexPath indexPathForRow:j inSection:i];
                index = -1;
                break;
            }
            result++;
        }
    }
    if (indexPathToSelect) {
    //    NSLog(@"WWWW1 %ld ,WWWW1 %ld ",indexPathToSelect.section,self.selectedIndexPath.section);
   //     NSInteger gap = indexPathToSelect.section - self.selectedIndexPath.section;
   //     NSInteger index = gap > 0?1:-1;
     //    NSLog(@"1111 %ld ,2222 %ld ",gap,index);
      //  if (gap == index || gap == 0 ||gap-index>0) {
            self.selectedIndexPath = indexPathToSelect;
            [self expandSection:self.selectedIndexPath.section];
            HDLeftTableHeaderView *headerView = (HDLeftTableHeaderView *) [self.tableView headerViewForSection:self.selectedIndexPath.section];
            headerView.isSelected = YES;
            [self.tableView selectRowAtIndexPath:self.selectedIndexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
//        } else {
//            if (self.selectedIndexPath.section == 0) {
//                return;
//            }
//        }
        
    }
}

- (void)scrollToSelectedSection
{
    NSMutableDictionary *dic = self.contentData[self.selectedIndexPath.section];
        if ([dic[kHDClassifyLeftTableViewModelDataKeyChildNode] count]>0) {
            
            [self.tableView selectRowAtIndexPath:self.selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
            if ([self.delegate respondsToSelector:@selector(classifyLeftTableViewModel:didSelectedAtIndexPath:)]) {
                [self.delegate classifyLeftTableViewModel:self didSelectedAtIndexPath:self.selectedIndexPath];
            }
        }
}

#pragma mark - private methods
- (void)expandSection:(NSUInteger)section
{
    HDLeftTableHeaderView *headerView = (HDLeftTableHeaderView *) [self.tableView headerViewForSection:section];
    [[NSNotificationCenter defaultCenter] postNotificationName:kHDLeftTableHeaderViewSetDeselectedNotification object:headerView];
}

#pragma mark - Getters and Setters
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[HDLeftTableViewCell class] forCellReuseIdentifier:kHDLeftTableViewCellIdentifier];
        [_tableView registerClass:[HDLeftTableHeaderView class] forHeaderFooterViewReuseIdentifier:kHDLeftTableHeaderViewIdentifier];
    }
    return _tableView;
}

- (NSArray *)contentData
{
    _contentData = self.dataSource;
    return _contentData;
}

- (NSIndexPath *)f
{
    if (_selectedIndexPath == nil) {
        _selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    return _selectedIndexPath;
}

@end
