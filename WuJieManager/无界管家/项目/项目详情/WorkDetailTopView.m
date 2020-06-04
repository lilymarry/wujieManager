//
//  WorkDetailTopView.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/18.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WorkDetailTopView.h"
#import "ELCVFlowLayout.h"
#import "WorkDetailTopCell.h"
@interface WorkDetailTopView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation WorkDetailTopView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"WorkDetailTopView" owner:self options:nil];
        [self addSubview:_thisView];
        CGAffineTransform transform= CGAffineTransformMakeRotation(-M_PI*0.25);
        /*关于M_PI
         #define M_PI     3.14159265358979323846264338327950288
         其实它就是圆周率的值，在这里代表弧度，相当于角度制 0-360 度，M_PI=180度
         旋转方向为：顺时针旋转
         
         */
        _stateLab.transform = transform;//旋转
        
   
        

    }
    return self;
}
-(void)setIsGroup:(NSString *)isGroup
{
    _isGroup=isGroup;
    if ([_isGroup isEqualToString:@"1"]) {
        
        _collection.delegate=self;
        _collection.dataSource=self;
        [_collection registerClass:[WorkDetailTopCell class] forCellWithReuseIdentifier:@"WorkDetailTopCell"];
        ELCVFlowLayout * mFlowLayout = [[ELCVFlowLayout alloc]init];
        
        
        mFlowLayout.itemSize = CGSizeMake(ScreenW/3, 120);//设置单元格//的宽和高
        
        [_collection setCollectionViewLayout:mFlowLayout];
        //隐藏滚轴
        _collection.showsHorizontalScrollIndicator = NO;
        
        [WorkDetailTopCell xibWithCollectionView:_collection];
        
        
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;

}

#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WorkDetailTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[WorkDetailTopCell cellIdentifier] forIndexPath:indexPath];
     [cell.logo sd_setImageWithURL:[NSURL URLWithString:@"http://test.wujiemall.com/Uploads/Ads/2018-04-15/5ad2d223f374c.jpg"] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    if (indexPath.item==0) {
        [cell.stateBtn setTitle:@"已营业" forState:UIControlStateNormal];
        [cell.stateBtn setBackgroundImage:[UIImage imageNamed:@"已营业背景图"] forState:UIControlStateNormal];
    }
    else
    {
        [cell.stateBtn setTitle:@"筹备中" forState:UIControlStateNormal];
        [cell.stateBtn setBackgroundImage:[UIImage imageNamed:@"筹备中背景图"] forState:UIControlStateNormal];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.workDetailEntryBlock) {
        self.workDetailEntryBlock(@"");
    }
}




@end
