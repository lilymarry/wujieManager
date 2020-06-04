//
//  VideoList.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/19.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "VideoList.h"
#import "SItemView.h"
#import "VideoListCell.h"
#import "VideoGroupListView.h"
@interface VideoList ()<UITableViewDelegate, UITableViewDataSource>
{
    
    NSString *order_status;
}
@property (weak, nonatomic) IBOutlet SItemView *orderStatusItemView;
@property (weak, nonatomic) IBOutlet UITableView *orderManagementTable;

@end

@implementation VideoList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"视察";
    adjustsScrollViewInsets_NO(_orderManagementTable, self);
    _orderManagementTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_orderManagementTable registerNib:[UINib nibWithNibName:NSStringFromClass([VideoListCell class]) bundle:nil] forCellReuseIdentifier:@"VideoListCell"];
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
    
    
    self.orderStatusItemView.itemsArray = @[@"银台",@"大厅",@"包厢",@"后厨"];
    self.orderStatusItemView.SelectItemBlock = ^(NSInteger index) {
        NSString * itemStr = @[@"银台",@"大厅",@"包厢",@"后厨"][index];
        
        if ([itemStr containsString:@"银台"]){
            self->order_status=@"1";
        }
        else if ([itemStr containsString:@"大厅"]){
            self->order_status=@"2";
        }
        else if ([itemStr containsString:@"包厢"]){
            self->order_status=@"3";
        }
        else
        {
            self->order_status=@"4";
        }
        
    };
    
}
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    VideoListCell *cell=[tableView dequeueReusableCellWithIdentifier:@"VideoListCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row==0) {
        cell.imaState.backgroundColor=[UIColor greenColor];
        cell.stateLab.text=@"在线";
        
    }
    else
    {
        cell.stateLab.text=@"离线";
        cell.imaState.backgroundColor=[UIColor lightGrayColor];
    }
    [cell.imaView sd_setImageWithURL:[NSURL URLWithString:@"http://test.wujiemall.com/Uploads/Ads/2018-04-15/5ad2d223f374c.jpg"] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 216;
    
}
@end
