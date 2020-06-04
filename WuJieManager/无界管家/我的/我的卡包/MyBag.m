//
//  MyBag.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/25.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "MyBag.h"
#import "SItemView.h"
#import "MyBagCell.h"
#import "MyBagheadView.h"
#import "MyMoreBag.h"
#import "MyBagDetail.h"
@interface MyBag ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet SItemView *itemView;
@property (weak, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation MyBag

- (void)viewDidLoad {
    [super viewDidLoad];
     adjustsScrollViewInsets_NO(_mTable, self);
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([MyBagCell class]) bundle:nil] forCellReuseIdentifier:@"MyBagCell"];
    self.title=@"我的卡包";
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

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    self.itemView.itemsArray = @[@"会员卡",@"优惠券",@"代金券",@"兑换券"];
    self.itemView.SelectItemBlock = ^(NSInteger index
                                      ) {
       
        
    };
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   
    return 44;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

        MyBagheadView * topView=[[MyBagheadView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 44)];
        if (section==0) {
            topView.cart_imag.image=[UIImage imageNamed:@"消费卡"];
            topView.cart_name.text=@"消费卡";
            
        }
        else  {
            topView.cart_imag.image=[UIImage imageNamed:@"权益卡"];
            topView.cart_name.text=@"权益卡";
        }
    [topView.moreBtn addTarget:self action:@selector(morePress) forControlEvents:UIControlEventTouchUpInside];
        return topView;
}
    
    
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    MyBagCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MyBagCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.content_ima sd_setImageWithURL:[NSURL URLWithString:@"http://dev.wujiemall.com/Uploads/Ads/2018-04-15/5ad2d223f374c.jpg"] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    [cell.logo_ima sd_setImageWithURL:[NSURL URLWithString:@"http://dev.wujiemall.com/Uploads/Merchant/2019-03-06/5c7f5beca8470.jpg"] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    if (indexPath.section==0) {
     
        cell.leveLab.text=@"消费级别";
        
    }
    else  {
       cell.leveLab.text=@"权益级别";
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
    
}
-(void)morePress
{
    MyMoreBag *bag=[[MyMoreBag alloc]init];
    [self.navigationController pushViewController:bag animated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
#pragma mark 卡包详情
    MyBagDetail *detail=[[MyBagDetail alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
}


@end
