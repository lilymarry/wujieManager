//
//  FoodDetailFootView.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/8/21.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "FoodDetailFootView.h"
#import "FoodDetailFootViewCell.h"

@interface FoodDetailFootView ()<UICollectionViewDelegate,UICollectionViewDataSource>

{
    NSArray *dataArr;
}
@property (weak, nonatomic) IBOutlet  UICollectionView *collection;
@end

@implementation FoodDetailFootView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"FoodDetailFootView" owner:self options:nil];
        [self addSubview:_thisView];
         [_collection registerNib:[UINib nibWithNibName:NSStringFromClass([FoodDetailFootViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"FoodDetailFootViewCell"];
        _collection.dataSource=self;
        _collection.delegate=self;
        _collection.scrollEnabled=NO;
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
-(void)loadCollectonView:(NSArray *)data
{
    dataArr=[NSArray arrayWithArray:data];
    
    [_collection reloadData];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (dataArr.count>4) {
        return 4;
    }
    return dataArr.count;
    
}

#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FoodDetailFootViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FoodDetailFootViewCell" forIndexPath:indexPath];
     OrderFoodListModel *model=   dataArr[indexPath.item];
    [cell.headImaView sd_setImageWithURL:[NSURL URLWithString:model.picture] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    cell.goods_nameLab.text=model.dishes;
     cell.priceLab.text=[NSString stringWithFormat:@"¥%@起",model.price];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (IS_PAD) {
        return CGSizeMake(ScreenW/4-10,200);
    }
    return CGSizeMake((ScreenW-10.5)/2,200);
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
      OrderFoodListModel *model=   dataArr[indexPath.item];
        if (self.selectFootViewBlock) {
            self.selectFootViewBlock(model);
        }
}
@end
