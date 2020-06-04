//
//  MyBagDetail.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/25.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "MyBagDetail.h"
#import "MyBagCell.h"
#import "MyBagDetailContentCell.h"
#import "MyBagShopCell.h"
#import "MyBagShop.h"
@interface MyBagDetail ()<UITableViewDelegate, UITableViewDataSource>{
    BOOL isShow;
    NSArray *arr;
}

@property (weak, nonatomic) IBOutlet UITableView *mTable;


@end

@implementation MyBagDetail

- (void)viewDidLoad {
    [super viewDidLoad];
      adjustsScrollViewInsets_NO(_mTable, self);
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([MyBagCell class]) bundle:nil] forCellReuseIdentifier:@"MyBagCell"];
     [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([MyBagDetailContentCell class]) bundle:nil] forCellReuseIdentifier:@"MyBagDetailContentCell"];
     [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([MyBagShopCell class]) bundle:nil] forCellReuseIdentifier:@"MyBagShopCell"];
    self.title=@"我的卡包";
    isShow=YES;
    arr=@[@{@"name":@"我的余额",@"content":@"¥ 1026556元"},@{@"name":@"我的积分",@"content":@"874.23"},@{@"name":@"权益数",@"content":@"1000"},@{@"name":@"适用门店",@"content":@""}];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (isShow) {
          return 3;
    }
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    else if (section==1)
    {
        return arr.count;
    }
    else
    {
        return 2;
    }
  
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return 5;
    }
    else
    {
        return 0.01;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        MyBagCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MyBagCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.content_ima sd_setImageWithURL:[NSURL URLWithString:@"http://dev.wujiemall.com/Uploads/Ads/2018-04-15/5ad2d223f374c.jpg"] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        [cell.logo_ima sd_setImageWithURL:[NSURL URLWithString:@"http://dev.wujiemall.com/Uploads/Merchant/2019-03-06/5c7f5beca8470.jpg"] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        return cell;
    }
    else if (indexPath.section==1)
    {
        MyBagDetailContentCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MyBagDetailContentCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLab.text=arr[indexPath.row][@"name"];
        cell.subTitleLab.text=arr[indexPath.row][@"content"];
        if (indexPath.row==arr.count-1) {
            cell.stateImag.hidden=NO;
            cell.subTitleLab.hidden=YES;
            if (isShow) {
                cell.stateImag.image=[UIImage imageNamed:@"灰色上箭头"];
            }
            else
            {
               cell.stateImag.image=[UIImage imageNamed:@"灰色下箭头"];
            }
        }
        else
        {
            cell.stateImag.hidden=YES;
             cell.subTitleLab.hidden=NO;
        }
        return cell;
    }
    else
    {
         MyBagShopCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MyBagShopCell"];
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 200;
    }
    return UITableViewAutomaticDimension;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1)
    {
#pragma mark  显示门店
        if (indexPath.row==arr.count-1) {
            isShow=!isShow;
            [_mTable reloadData];
       
        }
    }
    if (indexPath.section==2) {
#pragma mark 我的门店
        MyBagShop *shop=[[MyBagShop  alloc]init];
        [self.navigationController pushViewController:shop animated:YES];
    }
       
}

@end
