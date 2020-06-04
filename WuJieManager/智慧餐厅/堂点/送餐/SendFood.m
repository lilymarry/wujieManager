//
//  SendFood.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/7.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "SendFood.h"
#import "SendFoodFootView.h"
#import "SendFoodNumCell.h"
#import "OrderSubFood.h"

@interface SendFood ()<UICollectionViewDelegate, UICollectionViewDataSource,UITextViewDelegate>
{
    SendFoodFootView   * header ;
}
@property (weak, nonatomic) IBOutlet UICollectionView *mCollect;
@end

@implementation SendFood

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
 
    [_mCollect registerNib:[UINib nibWithNibName:@"SendFoodNumCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SendFoodNumCell"];
    
      [_mCollect registerNib:[UINib nibWithNibName:@"SendFoodFootView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"SendFoodFootView"];
    
     self.title=@"送菜";
    
}

- (void)createNav {
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"白色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -20, 0, 0);

    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 4;
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (IS_PAD) {
       
            return CGSizeMake(ScreenW/2-20,50);
    }
    else
    {
       
            return CGSizeMake(ScreenW-20,50);
      
    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SendFoodNumCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SendFoodNumCell" forIndexPath:indexPath];
    [cell.reduceBtn addTarget:self action:@selector(reduceBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    cell.reduceBtn.tag=indexPath.item;
    [cell.addBtn addTarget:self action:@selector(addBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    cell.addBtn .tag=indexPath.item;
    return cell;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(3, 6, 3, 6);
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    
    CGSize size = {ScreenW,300};
    return size;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ;
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionFooter) {
       header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"SendFoodFootView" forIndexPath:indexPath];
        
        [header.setBtn addTarget:self action:@selector(setPress) forControlEvents:UIControlEventTouchUpInside];
        header.beizhuLab.hidden = NO;
        header.beizhu_Tx.delegate=self;
        
        reusableview = header;
        
    }
    return reusableview;
}
-(void)setPress
{
    OrderSubFood *food=[[OrderSubFood alloc]init];
  //  food.type=@"2";
    [self.navigationController pushViewController:food animated:YES];
}
#pragma  mark 减少选中
-(void)reduceBtnPress:(UIButton *)but
{
    
}
#pragma mark 增加选中
-(void)addBtnPress:(UIButton *)but
{
    
}
#pragma  mark textView 代理

- (void)textViewDidChange:(UITextView *)textView
{
    header.beizhuLab.hidden=YES;
    header.numLab.text=[NSString stringWithFormat:@"%lu/200",textView.text.length];
  
    if (textView.text.length>=200) {
        textView.text=[textView.text substringToIndex:200];
        header.numLab.text=@"200/200";
    }
    if (textView.text.length==0) {
        header.beizhuLab.hidden=NO;
    }

    
    
}


@end
