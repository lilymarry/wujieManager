//
//  PayCartList.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/9/5.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "PayCartList.h"
#import "PayCartListCell.h"
@interface PayCartList ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *mCollect;
@property(nonatomic,strong)NSIndexPath *lastPath;
@end

@implementation PayCartList
- (void)createNav {
    
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"白色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    
    [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    self.title=@"会员卡支付";
    [_mCollect registerNib:[UINib nibWithNibName:NSStringFromClass([PayCartListCell class]) bundle:nil] forCellWithReuseIdentifier:@"PayCartListCell"];
    if (_selectNum.length>0) {
        _lastPath = [NSIndexPath indexPathForRow:[_selectNum intValue]  inSection:0];
        [_mCollect  selectItemAtIndexPath: _lastPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    }
 
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PayCartListCell * commonCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PayCartListCell" forIndexPath:indexPath];
   NSString *name=[NSString stringWithFormat:@"XXXX卡名%ld",indexPath.item+1];
   NSString *discount=@"9.5折";
    
    NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString  alloc]initWithString:[NSString stringWithFormat:@" %@ %@",name,discount]];
    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(name.length+2,discount.length)];
    [AttributedStr addAttribute:NSBackgroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(name.length+2,discount.length)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(name.length+2,discount.length)];
    commonCell.nameLab.attributedText=AttributedStr;

    if (_lastPath.row==indexPath.row&&_lastPath!=nil) {
        commonCell.bgview.layer.shadowColor=[UIColor redColor].CGColor;
        commonCell.bgview.layer.borderColor=[UIColor redColor].CGColor;
    }
    else
    {
        commonCell.bgview.layer.shadowColor=[UIColor lightGrayColor].CGColor;
        commonCell.bgview.layer.borderColor=[UIColor clearColor].CGColor;
       
    }
  
    
    return commonCell;
}


#pragma mark - =========================== CollectionView的item的布局 =============================
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (IS_PAD) {
        return CGSizeMake(ScreenW/2-8,164);
    }
    return CGSizeMake(ScreenW,164);
    
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.block(indexPath.item,[NSString stringWithFormat:@"XXXX卡名%ld",indexPath.item+1]);
    [self.navigationController popViewControllerAnimated:YES];
}

@end
