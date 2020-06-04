//
//  BuyInChargeCell.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/24.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "BuyInChargeCell.h"
#import "ELCVFlowLayout.h"
#import "BuyInChargeSubCell.h"
@interface BuyInChargeCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)NSIndexPath *lastPath2;
@end

@implementation BuyInChargeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    ELCVFlowLayout * mFlowLayout = [[ELCVFlowLayout alloc]init];
    
    
    mFlowLayout.itemSize = CGSizeMake(ScreenW/3, 80);//设置单元格//的宽和高
    
    [_collection setCollectionViewLayout:mFlowLayout];
    //隐藏滚轴
    _collection.showsHorizontalScrollIndicator = NO;
    _collection.delegate=self;
    _collection.dataSource=self;
    
    [BuyInChargeSubCell xibWithCollectionView:_collection];
    _lastPath2 = [NSIndexPath indexPathForRow:0 inSection:0];
    [_collection selectItemAtIndexPath:_lastPath2 animated:YES scrollPosition:UICollectionViewScrollPositionNone];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 16;
    
}

#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BuyInChargeSubCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[BuyInChargeSubCell cellIdentifier] forIndexPath:indexPath];
    if (_lastPath2.item==indexPath.item) {
        cell.backView.layer.borderColor =color(255, 100, 85).CGColor;
        cell.subtitle.textColor=color(255, 100, 85);
        cell.titleLab.backgroundColor=color(255, 100, 85);
    }
    else
    {
        cell.backView.layer.borderColor =[UIColor lightGrayColor].CGColor;
        cell.subtitle.textColor=[UIColor lightGrayColor];
        cell.titleLab.backgroundColor=[UIColor lightGrayColor];
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    int newRow =(int) [indexPath item];
    int oldRow =(int)( (_lastPath2 !=nil)?[_lastPath2 item]:-1);
    if (newRow != oldRow) {
        BuyInChargeSubCell *newcell =(BuyInChargeSubCell *) [_collection cellForItemAtIndexPath:indexPath];
        newcell.backView.layer.borderColor =color(255, 100, 85).CGColor;
        newcell.subtitle.textColor=color(255, 100, 85);
        newcell.titleLab.backgroundColor=color(255, 100, 85);
        
        BuyInChargeSubCell *oldCell =(BuyInChargeSubCell *) [_collection cellForItemAtIndexPath:_lastPath2];
        oldCell.backView.layer.borderColor =[UIColor lightGrayColor].CGColor;
        oldCell.subtitle.textColor=[UIColor lightGrayColor];
        oldCell.titleLab.backgroundColor=[UIColor lightGrayColor];
        _lastPath2 = indexPath;
        
    }
    
}

@end
