//
//  MyWork.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/23.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "MyWork.h"
#import "SItemView.h"
#import "WorkFirstCell.h"
#import "WorkDetail.h"

@interface MyWork ()<UITableViewDelegate, UITableViewDataSource>
{
    
    NSString *order_status;
}
@property (weak, nonatomic) IBOutlet SItemView *orderStatusItemView;
@property (weak, nonatomic) IBOutlet UITableView *orderManagementTable;
@end

@implementation MyWork

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"参与的项目";
   adjustsScrollViewInsets_NO(_orderManagementTable, self);    _orderManagementTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_orderManagementTable registerNib:[UINib nibWithNibName:NSStringFromClass([WorkFirstCell class]) bundle:nil] forCellReuseIdentifier:@"WorkFirstCell"];
    order_status=@"1";
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
    
    
    self.orderStatusItemView.itemsArray = @[@"持有中",@"历史持有"];
    self.orderStatusItemView.SelectItemBlock = ^(NSInteger index) {
        NSString * itemStr = @[@"持有中",@"历史持有"][index];
        
        if ([itemStr containsString:@"持有中"]){
            self->order_status=@"1";
        }
       
        else
        {
            self->order_status=@"2";
        }
        [self->_orderManagementTable reloadData];
        
    };
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    WorkFirstCell * cell = [_orderManagementTable dequeueReusableCellWithIdentifier:@"WorkFirstCell" forIndexPath:indexPath];
    [cell.imaView sd_setImageWithURL:[NSURL URLWithString:@"http://test.wujiemall.com/Uploads/Ads/2018-04-15/5ad2d223f374c.jpg"] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    if (indexPath.row==0) {
        cell.stateLab.text=@"筹备中";
    }
    else
    {
        cell.stateLab.text=@"已营业";
    }
    if ( [cell.stateLab.text isEqualToString:@"已营业"]) {
        cell.progressView.hidden=YES;
        cell.progressViewHH.constant=0;
    }
    else  {
        cell.progressView.hidden=NO;
        cell.progressViewHH.constant=27;
    }
    if ([order_status isEqualToString:@"1"]) {
        cell.onSellNum.text=@"在售权益数 200/1000";
         cell.sumNum.text=@"持有权益数 100/800";
    }
    else
    {
        cell.onSellNum.text=@"在售权益数 200";
         cell.sumNum.text=@"权益人总数 800";
    }
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorkDetail *detail=[[WorkDetail alloc]init];
    detail.hidesBottomBarWhenPushed=YES;
    detail.type=@"2";//卖出
    [self.navigationController pushViewController:detail animated:YES];
}

@end
