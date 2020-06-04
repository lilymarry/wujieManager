//
//  HelpCenter.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/24.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "HelpCenter.h"
#import "SItemView.h"
#import "HelpCenterCell.h"
@interface HelpCenter ()<UITableViewDelegate, UITableViewDataSource>
{
    
    NSString *order_status;
}
@property (weak, nonatomic) IBOutlet SItemView *orderStatusItemView;
@property (weak, nonatomic) IBOutlet UITableView *orderManagementTable;

@end

@implementation HelpCenter

- (void)viewDidLoad {
    [super viewDidLoad];
    adjustsScrollViewInsets_NO(_orderManagementTable, self);
    _orderManagementTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_orderManagementTable registerNib:[UINib nibWithNibName:NSStringFromClass([HelpCenterCell class]) bundle:nil] forCellReuseIdentifier:@"HelpCenterCell"];
    order_status=@"1";
    
    self.title=@"帮助中心";
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
    
    
    self.orderStatusItemView.itemsArray = @[@"注册账户",@"账户管理",@"交易管理",@"账户安全",@"名词解释"];
    self.orderStatusItemView.SelectItemBlock = ^(NSInteger index) {
       
    };
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    HelpCenterCell * cell = [_orderManagementTable dequeueReusableCellWithIdentifier:@"HelpCenterCell" forIndexPath:indexPath];
    cell.stateBtn.tag=indexPath.row;
    [cell.stateBtn addTarget:self action:@selector(stateBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    if (cell.state) {
        cell.subLab.text=@" 什么什么什么什么什么什么什么什么事没事没理财，是互联网金融行什么什么什么事没什么台。";
    }
    else
    {
        cell.subLab.text=@"";
    }
    cell.numLab.text=[NSString stringWithFormat:@"%d",(int)indexPath.row+1];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
-(void)stateBtnPress:(id)sender
{
    UIButton *but=(UIButton *)sender;
    but.selected=!but.selected;
    NSArray *cellArr=[_orderManagementTable visibleCells];
     HelpCenterCell * cell = cellArr[ but.tag];
    if (but.selected) {
       
        cell.state=YES;
    }
    else{
        cell.state=NO;
    }
    
     [self->_orderManagementTable reloadData];
}
@end
