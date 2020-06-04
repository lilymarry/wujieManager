//
//  HDClassifyRightTableViewModel.m
//  HDClassifyTable
//
//  Created by 天津沃天科技 on 2019/5/14.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "HDClassifyRightTableViewModel.h"
#import "OrderFoodRightCell1.h"
#import "OrderFoodRightBtn.h"
#import "OrderFoodRightHeader.h"
#import "OrderFoodListModel.h"
extern NSString * const kHDClassifyLeftTableViewModelDataKeyChildNode;

@interface HDClassifyRightTableViewModel ()<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *tableView;
@property (nonatomic, assign) NSUInteger currentSelectedSection;
@property (nonatomic, assign) BOOL isRequestedFromLeft;
@property (nonatomic, strong) NSIndexPath *indexPathFromLeft;

@end

@implementation HDClassifyRightTableViewModel

#pragma mark - public methods
- (void)scrollToIndexPathFromLeft:(NSIndexPath *)indexPathFromLeft
{
    self.isRequestedFromLeft = YES;
    self.currentSelectedSection = 0;
    self.indexPathFromLeft = indexPathFromLeft;
    for (int i = 0; i < self.dataSource.count; i++) {
        if (i == indexPathFromLeft.section) {
            self.currentSelectedSection += indexPathFromLeft.row;
            break;
        } else {
            self.currentSelectedSection += [self.dataSource[i][kHDClassifyLeftTableViewModelDataKeyChildNode] count];
        }
    }
    if ([self.contentData count] == 0) {
        return;
    }
    if ([self.contentData[self.currentSelectedSection][kHDClassifyLeftTableViewModelDataKeyChildNode] count] > 0) {
        
        [self.tableView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:self.currentSelectedSection] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    }else{
        //网络请求
    }
}

#pragma mark - UICollectView

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSInteger result;
    result = self.contentData.count;
    return result;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger result = 0;
    result = [self.contentData[section][kHDClassifyLeftTableViewModelDataKeyChildNode] count];
    return result+1;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item==0) {
        
        NSString *str1=self.contentData[indexPath.section][@"kHDClassifyLeftTableViewModelDataKeyName"];
        NSString *str2=self.contentData[indexPath.section][@"description"];
       NSString *str = [NSString stringWithFormat:@"%@ %@",str1,str2];
        
        CGSize titleSize = [str sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(ScreenW-100-10,  MAXFLOAT)];
        CGFloat height =titleSize.height;
        if (height<40) {
            height=40;
        }
        return CGSizeMake(ScreenW-100-10,height);
    }
    else
    {
        if (IS_PAD) {
            return CGSizeMake((ScreenW-100-10)/2,130);
        }
        else
        {
            return CGSizeMake(ScreenW-100-10,130);
            
        }
    }
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item==0) {
        OrderFoodRightHeader *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"OrderFoodRightHeader" forIndexPath:indexPath];
        NSString *str1=self.contentData[indexPath.section][@"kHDClassifyLeftTableViewModelDataKeyName"];
         NSString *str2=self.contentData[indexPath.section][@"description"];
        if (str2.length==0) {
              str2=@"回头客多到没朋友，快来选它！";
        }
        NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",str1,str2]];
        
        
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(str1.length+1,str2.length)];
        
         cell.nameLab.attributedText=AttributedStr;
        NSInteger result=  [self.contentData[indexPath.section][kHDClassifyLeftTableViewModelDataKeyChildNode] count];
            cell.lineView.hidden= result==0 ? NO:YES;
        return cell;
    }
    else
    {
        OrderFoodRightCell1 *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"OrderFoodRightCell1" forIndexPath:indexPath];
        
        [cell.addBtn addTarget:self action:@selector(addPress:) forControlEvents:UIControlEventTouchUpInside];
        cell.addBtn.indexPath=indexPath;
        
        
        [cell.reduceBtn addTarget:self action:@selector(reducePress:) forControlEvents:UIControlEventTouchUpInside];
        cell.reduceBtn.indexPath=indexPath;
        
        [cell.tapImagBtn addTarget:self action:@selector(tapImagePress:) forControlEvents:UIControlEventTouchUpInside];
        cell.tapImagBtn.indexPath=indexPath;
        
        OrderFoodListModel *model= self.contentData[indexPath.section][kHDClassifyLeftTableViewModelDataKeyChildNode][indexPath.item-1];
        
        cell.goods_nameLab.text=model.dishes;
        cell.priceLab.text=[NSString stringWithFormat:@"¥%@起",model.price];

        
        if ( model.zong_time.length>0) {
            cell.zong_timeLab.text=[NSString stringWithFormat:@"预计时间%@",model.zong_time];
        }
        [cell.headImaView sd_setImageWithURL:[NSURL URLWithString:model.picture] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        if (model.selectNum>0) {
            cell.numLab.hidden=NO;
            cell.numLab.text=[NSString stringWithFormat:@"%ld",(long)model.selectNum];
            cell.reduceBtn.hidden=NO;
        }
        else
        {
            cell.numLab.hidden=YES;
            cell.reduceBtn.hidden=YES;
        }
        return cell;
        
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    NSInteger result = 0;

    result = [self.contentData[section][kHDClassifyLeftTableViewModelDataKeyChildNode] count];

    if(result==1) {
        return UIEdgeInsetsMake(0,0,0,(ScreenW-100)/2);
    }
    else
    {
       return  UIEdgeInsetsMake(0,0,0,0);
      
    }
}
-(void)addPress:(OrderFoodRightBtn *)but
{
    
    NSIndexPath *index=[NSIndexPath indexPathForRow:but.indexPath.item-1 inSection:but.indexPath.section];
    if (index!=nil) {
        if ([self.delegate respondsToSelector:@selector(rightViewModel:addToIndexPath:)]) {
            [self.delegate rightViewModel:self
                           addToIndexPath:index];
            
        }
    }
    
    
}
-(void)reducePress:(OrderFoodRightBtn *)but
{
    NSIndexPath *index=[NSIndexPath indexPathForRow:but.indexPath.item-1 inSection:but.indexPath.section];
    
    if ([self.delegate respondsToSelector:@selector(rightViewModel:reduceToIndexPath:)]) {
        [self.delegate rightViewModel:self
                    reduceToIndexPath:index];
        
    }
}
-(void)tapImagePress:(OrderFoodRightBtn *)but
{
     NSIndexPath *index=[NSIndexPath indexPathForRow:but.indexPath.item-1 inSection:but.indexPath.section];
    if ([self.delegate respondsToSelector:@selector(rightViewModel:didSelectCellToIndexPath:)]) {
        [self.delegate rightViewModel:self didSelectCellToIndexPath:index];
        
    }
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.currentSelectedSection !=
        
        self.tableView.indexPathsForVisibleItems.firstObject.section) {
        NSInteger row = self.tableView.indexPathsForVisibleItems.firstObject.row;
        NSInteger section = self.tableView.indexPathsForVisibleItems.firstObject.section;
        self.currentSelectedSection = section;
        if (self.isRequestedFromLeft == NO) {
            if ([self.delegate respondsToSelector:@selector(rightViewModel:didScrollToIndexPath:)]) {
                [self.delegate rightViewModel:self
                         didScrollToIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
            }
        }
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.isRequestedFromLeft = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.isRequestedFromLeft = NO;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.isRequestedFromLeft = NO;
}

#pragma mark - getters and setters
- (UICollectionView *)tableView
{
    if (_tableView == nil) {
        UICollectionViewFlowLayout   *     _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _tableView = [[UICollectionView alloc] initWithFrame:CGRectMake(100, 0, ScreenW-100, ScreenH-70) collectionViewLayout:_flowLayout];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [_tableView registerNib:[UINib nibWithNibName:@"OrderFoodRightCell1" bundle:nil] forCellWithReuseIdentifier:@"OrderFoodRightCell1"];
        [_tableView registerNib:[UINib nibWithNibName:@"OrderFoodRightHeader" bundle:nil] forCellWithReuseIdentifier:@"OrderFoodRightHeader"];
    }
    return _tableView;
}

@end
