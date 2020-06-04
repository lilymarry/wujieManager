//
//  OrderListSure.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/8/2.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "OrderListSure.h"
#import "GetDesksTaiList.h"
#import "OnMeal.h"
#import "OrderListSureCell.h"
#import "ExchangeTime.h"
#import "OrderInfo.h"
#import "DineOrderList.h"
#import "ClearDesk.h"
#import "OrderListSureView.h"
@interface OrderListSure ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    OrderListSureView *sureView;
}
@property (weak, nonatomic) IBOutlet UICollectionView *mCollect;
@property(nonatomic,strong)NSArray *dataArray;

@end

@implementation OrderListSure

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self createNav];
    [_mCollect registerNib:[UINib nibWithNibName:NSStringFromClass([OrderListSureCell class]) bundle:nil] forCellWithReuseIdentifier:@"OrderListSureCell"];
    [self getData];
}
-(void)getData {
   
    DineOrderList *list=[[DineOrderList alloc]init];
    list.mid=_mid;
    list.desk_id=_desk_id;
    list.type=@"2";
    [MBProgressHUD showMessage:nil toView:self.view];
    [list DineOrderListSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
          [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            DineOrderList *list=(DineOrderList *)data;
            self.dataArray=[NSArray arrayWithArray:list.data.order_info];
            
         if ([list.data.desk_info.use_type intValue]==3) {
                UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                rightBtn.frame = CGRectMake(0, 0, 44, 50);
                
                UIBarButtonItem * rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
                self.navigationItem.rightBarButtonItem = rightBtnItem;
                
                [rightBtn addTarget:self action:@selector(rightPress) forControlEvents:UIControlEventTouchUpInside];
                [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                rightBtn.titleLabel.font=[UIFont systemFontOfSize:14] ;
                [rightBtn setTitle:@"清台" forState:UIControlStateNormal];
            }
            
  
            [_mCollect reloadData];
        }
        else
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:message toView:self.view];
            });
        }
        
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
-(void)createNav {
    
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
-(void)rightPress
{
    
    sureView=[[OrderListSureView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
   
    [sureView.sureBtn addTarget:self action:@selector(sureBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [sureView.canselBtn addTarget:self action:@selector(canselBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view.window addSubview:sureView];
    
 
   
}
-(void)sureBtnPress
{
    [sureView removeFromSuperview];
    [self clearDesk];
}
-(void)canselBtnPress
{
     [sureView removeFromSuperview];
}
-(void)clearDesk
{
    [MBProgressHUD showMessage:nil toView:self.view];
    
    ClearDesk *desk=[[ClearDesk alloc]init];
    desk.desk_id=_desk_id;
    
    [desk ClearDeskSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:message toView:self.view];
                
            });
            
        }
    } andFailure:^(NSError * _Nonnull error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
#pragma mark - CollectionView
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (IS_PAD) {
        return CGSizeMake(ScreenW/2-5,200);
    }
    return CGSizeMake(ScreenW-5,200);
    
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderListSureCell * commonCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OrderListSureCell" forIndexPath:indexPath];
    DineOrderList *list=self.dataArray[indexPath.row];
    
    commonCell.createTimeLab.text =list.created_at;
    commonCell.order_snLab.text=[NSString stringWithFormat:@"订单编号 %@",list.order_sn];
    commonCell.nameLab.text=list.user_name;
    commonCell.moneyLab.text=[NSString stringWithFormat:@"总金额 ¥%.2f",[list.all_price doubleValue]];
    commonCell.goodsLab.text=list.dishes_info;
    
     if ( [list.status_name isEqualToString:@"待支付"]&&[list.pay_way intValue]==2) {
          [commonCell.oneBtn setTitle:@"待确认" forState:UIControlStateNormal];
     }
    else
    {
         [commonCell.oneBtn setTitle:list.status_name forState:UIControlStateNormal];
    }
   
    commonCell.oneBtn.tag=indexPath.item;
   
    commonCell.oneBtn.backgroundColor=color(242, 48, 48);
    
    [commonCell .oneBtn addTarget:self action:@selector(onePress:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    commonCell.twoBtn.tag=indexPath.item;
//    [commonCell .twoBtn addTarget:self action:@selector(twoPress:) forControlEvents:UIControlEventTouchUpInside];
    
   

    
    return commonCell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GetDesksTaiList *list=self.dataArray[indexPath.item];
    [self onePressDetail:list withType:list.status_name];
}
-(void)onePressDetail:( GetDesksTaiList *)list withType:(NSString *)type
{
    OnMeal  *meal=[[OnMeal alloc]init];
    meal.order_sn=list.order_sn;
    meal.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:meal animated:YES];
    
}

-(void)onePress:(UIButton *)but
{
     GetDesksTaiList *list=self.dataArray[but.tag];
    [self onePressDetail:list withType:but.titleLabel.text];
  
}
#pragma mark 取消订单
-(void)twoPress:(UIButton *)but
{
    GetDesksTaiList *list=self.dataArray[but.tag];
    
    OrderInfo *order=[[OrderInfo alloc]init];
    order.order_sn=list.order_sn;
    order.status=@"1";
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [order OrderInfoSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self getData];
            });
        }
        else
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:message toView:self.view];
            });
            
        }
        
        
        
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
}

@end
