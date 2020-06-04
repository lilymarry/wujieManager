//
//  ReturnFood.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/13.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "ReturnFood.h"
#import "OrderInfo.h"
#import "ReturnFoodTopViewCell.h"
#import "OrderFoodSet.h"
@interface ReturnFood ()<UICollectionViewDelegate, UICollectionViewDataSource,UITextViewDelegate>
{
    NSMutableArray *dataArr;
    NSString *desc;
}
@property (weak, nonatomic) IBOutlet UICollectionView *mCollect;
@property (weak, nonatomic) IBOutlet UIButton *allBtn;

@end

@implementation ReturnFood

- (void)viewDidLoad {
    [super viewDidLoad];
     _mCollect.allowsSelection = YES;
    [_mCollect registerNib:[UINib nibWithNibName:@"ReturnFoodTopViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ReturnFoodTopViewCell"];
    [_mCollect registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footView"];
    [self createNav];
    self.title=@"退菜";
    [self getData];
    desc=@"可详细描述对本次操作的说明";
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
-(void)getData
{
    OrderInfo *order=[[OrderInfo alloc]init];
    order.order_sn=_order_sn;
    [MBProgressHUD showMessage:nil toView:self.view];
    [order OrderInfoSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if ([code intValue]==200) {
           OrderInfo *list= (OrderInfo *)data;
            dataArr =[NSMutableArray arrayWithArray:[self searchArr:list.data.dish]];
            [dataArr addObjectsFromArray:[self searchArr:list.data.dish_add]];
            [_mCollect reloadData];
            
        }
        else
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:message toView:self.view];
            });        }
        
        
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
-(NSArray *)searchArr:(NSArray *)arr
{
    NSMutableArray *data=[NSMutableArray array];
    for (  OrderInfo *order in arr) {
    if ([order.status intValue]!=1) {
          [data addObject:order];
        }
    }
    return data;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return dataArr.count;
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (IS_PAD) {
       
        return CGSizeMake(ScreenW/2-20,100);
        

    }
    else
    {
        
        
        return CGSizeMake(ScreenW-20,100);
        }
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ReturnFoodTopViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ReturnFoodTopViewCell" forIndexPath:indexPath];
     OrderInfo *list= dataArr[indexPath.item];
    [cell.headImaView sd_setImageWithURL:[NSURL URLWithString:list.dish_pic] placeholderImage:[UIImage imageNamed:@"默认龙纹图标"]];
    cell.nameLab.text=list.dish_name;
   
     cell.numLab.text=[NSString stringWithFormat:@"共%@份",list.dish_num];
    NSString *str1=list.norms_name;
    NSString *str2=list.taste_name;
    if (str1.length==0) {
        str1=@"";
    }
    if (str2.length==0) {
        str2=@"";
    }
    cell.stateLab.text=[NSString stringWithFormat:@"%@ %@ ",str1,str2];
    
    if (list.isSelect) {
        [ cell.flagImaView setImage:[UIImage imageNamed:@"圆形选中"]];
    }
    else
    {
        [ cell.flagImaView setImage:[UIImage imageNamed:@"圆形未选中"]];
    }
    return cell;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(3, 6, 3, 6);
    
}

- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ReturnFoodTopViewCell * cell = (ReturnFoodTopViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
      OrderInfo *model= dataArr[indexPath.item];
  
        model.isSelect = !model.isSelect;
    
        if (model.isSelect) {
            [ cell.flagImaView setImage:[UIImage imageNamed:@"圆形选中"]];
        }
        else
        {
            [ cell.flagImaView setImage:[UIImage imageNamed:@"圆形未选中"]];
        }
    if ([self cherkAllSelect] ==NO) {
        _allBtn.selected=NO;
    }
    else
    {
        _allBtn.selected=YES;
    }
  
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
        CGSize size = {ScreenW,140};
        return size;
}
#pragma mark 设置 HeadView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        UICollectionReusableView *headerView = [_mCollect dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footView" forIndexPath:indexPath];
        if(headerView == nil)
        {
            headerView = [[UICollectionReusableView alloc] init];
            
        }
        headerView.backgroundColor = [UIColor whiteColor];
        for(UIView *subView in headerView.subviews ) {
            [subView removeFromSuperview];
        }
        UILabel *lab =[[UILabel alloc]initWithFrame:CGRectMake(8, 0, ScreenW-16, 20)];
        lab.text=@"退菜原因";
        lab.textColor=[UIColor lightGrayColor];
        [lab setFont:[UIFont systemFontOfSize:14]];
        [headerView addSubview:lab];
            
            UITextView *textView=[[UITextView alloc]initWithFrame:CGRectMake(8,20, ScreenW-16, 120)];
            textView.textColor=[UIColor lightGrayColor];
            [textView setFont:[UIFont systemFontOfSize:14]];
             textView.delegate=self;
             textView.text=desc;
        textView.backgroundColor=[UIColor groupTableViewBackgroundColor];
            [headerView addSubview:textView];
            
        
        
        return headerView;
    }
    
    
    return nil;
}
-(void)allSelectOrNot:(BOOL) reslut
{
    for (OrderInfo * model in dataArr) {
        model.isSelect = reslut;
    }
    
    [_mCollect reloadData];
    
}

- (IBAction)allPress:(id)sender {
    _allBtn.selected=!_allBtn.selected;
    [self allSelectOrNot: _allBtn.selected];
}
-(BOOL)cherkAllSelect
{
    if (dataArr.count>0) {
        for (OrderInfo * model in dataArr) {
            if (model.isSelect==NO) {
                return NO;
            }
            
        }
        return YES;
    }
    return NO;
    
}
- (IBAction)surePress:(id)sender {
   
    OrderFoodSet *set=[[OrderFoodSet alloc]init];
    set.type=@"4";
    if ([desc isEqualToString:@"可详细描述对本次操作的说明"]) {
        desc=@"";
    }
    set.remark=desc;
    set.order_id=_order_sn;
    NSString *str =[self selectId];
    if (str.length==0) {
           [MBProgressHUD showSuccess:@"选择退菜的菜品" toView:self.view];
        return;
    }
    set.back=str;
    [set OrderFoodSetSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
         [MBProgressHUD showSuccess:message toView:self.view];
        if ([code intValue]==200) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.returnFoodBlock();
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
}
-(NSString *)selectId
{
    NSMutableString *string=[NSMutableString string];
    NSMutableArray *data=[NSMutableArray array];
    for (OrderInfo * model in dataArr) {
        if (model.isSelect==YES) {
            [data addObject:model];
        }
        
    }
    if (data.count==0) {
        return nil;
    }
    else
    {
        
        for (int i=0; i<data.count;i++) {
            OrderInfo * model=data[i];
            [string appendString:model.id];
            if (i!=data.count-1) {
                [string appendString:@","];
            }
            
        }
        
      return string;
    }
    
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
  
    if ([textView.text isEqualToString:@"可详细描述对本次操作的说明"]) {
        textView.text=@"";
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
   
    if (textView.text.length==0) {
        textView.text=@"可详细描述对本次操作的说明";
    }
     desc=textView.text;
}
@end
