//
//  MyBagShop.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/25.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "MyBagShop.h"
#import "MyBagShopListCell.h"
@interface MyBagShop ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *mCollect;
@end

@implementation MyBagShop

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"门店菜品";
    [_shopImage sd_setImageWithURL:[NSURL URLWithString:@"http://dev.wujiemall.com/Uploads/Ads/2018-04-15/5ad2d223f374c.jpg"] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    [_headImage sd_setImageWithURL:[NSURL URLWithString:@"http://dev.wujiemall.com/Uploads/Merchant/2019-03-06/5c7f5beca8470.jpg"] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    
      [_mCollect registerNib:[UINib nibWithNibName:NSStringFromClass([MyBagShopListCell class]) bundle:nil] forCellWithReuseIdentifier:@"MyBagShopListCell"];
    [self createNav];
}
- (void)createNav {
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"黑色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    
    [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
    MyBagShopListCell * commonCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyBagShopListCell" forIndexPath:indexPath];
     [commonCell.headImage sd_setImageWithURL:[NSURL URLWithString:@"http://test.wujiemall.com/Uploads/Ads/2018-04-15/5ad2d223f374c.jpg"] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    NSString *str1=@"12";
    NSString *str2=@"24";
    NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"专享价:￥%@ ¥%@ 销量666",str1,str2]];
      [AttributedStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(str1.length+6,str2.length+1)];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, str1.length+1)];
    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(5, str1.length+1)];
    commonCell.priceLab.attributedText = AttributedStr;
    return commonCell;
}


#pragma mark - =========================== CollectionView的item的布局 =============================
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
      return CGSizeMake(ScreenW/2-12,ScreenW/2/155*116+40+20);
    
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
  
            return UIEdgeInsetsMake(3, 6, 3, 6);
    
}


@end
