//
//  BuyOutList.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/19.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "BuyOutList.h"
#import "BuyOutListCell.h"
#import "BuyIn.h"
@interface BuyOutList ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation BuyOutList

- (void)viewDidLoad {
    [super viewDidLoad];
    adjustsScrollViewInsets_NO(_mTable, self);
    // Do any additional setup after loading the view from its nib.
    self.title=@"权益转让信息";
    [_mTable registerNib:[UINib nibWithNibName:@"BuyOutListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BuyOutListCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BuyOutListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BuyOutListCell" forIndexPath:indexPath];
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:@"http://dev.wujiemall.com/Uploads/Merchant/2019-03-06/5c7f5beca8470.jpg"] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    [cell.jiaobtn addTarget:self action:@selector(jiaoyiPress:) forControlEvents:UIControlEventTouchUpInside];
    cell.jiaobtn.tag=indexPath.row;
    return cell;
    
}
-(void)jiaoyiPress:(UIButton *)but
{
    BuyIn * list=[[BuyIn alloc]init];
    list.type=@"1";
    [self.navigationController pushViewController:list animated:YES];
}
@end
