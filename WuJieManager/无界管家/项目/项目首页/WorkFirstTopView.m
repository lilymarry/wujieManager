//
//  WorkFirstTopView.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/17.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WorkFirstTopView.h"
#import "ELCVFlowLayout.h"
#import "WorkFirstTopViewCell.h"
@interface WorkFirstTopView ()

@end

@implementation WorkFirstTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"WorkFirstTopView" owner:self options:nil];
        [self addSubview:_thisView];
        
        ELCVFlowLayout * mFlowLayout = [[ELCVFlowLayout alloc]init];
        mFlowLayout.itemSize = CGSizeMake((ScreenW-18)/4, 90);//设置单元格的宽和高
        [_collectionView setCollectionViewLayout:mFlowLayout];
        //隐藏滚轴
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [WorkFirstTopViewCell xibWithCollectionView:_collectionView];
        
        _cellsView.layer.masksToBounds = YES;
        _cellsView.layer.cornerRadius = 5;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (void)setDatas:(NSArray *)datas{
    _datas = datas;
    [_collectionView reloadData];
}

#pragma mark UICollectionViewdelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   return self.datas.count;
    
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WorkFirstTopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[WorkFirstTopViewCell cellIdentifier] forIndexPath:indexPath];
    NSDictionary *dic= self.datas[indexPath.row];
    cell.logo.image=[UIImage imageNamed:dic[@"imag"]];
    cell.subTitleLab.text=dic[@"name"];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.typyEntryBlcok) {
        self.typyEntryBlcok(@"");
    }
}



@end
