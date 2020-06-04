//
//  QuanYiOnSell.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/22.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "QuanYiOnSell.h"
#import "QuanYiOnSellCell.h"
#import "BuyIn.h"
@interface QuanYiOnSell ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *mTable;

@end

@implementation QuanYiOnSell

- (void)viewDidLoad {
    [super viewDidLoad];
  adjustsScrollViewInsets_NO(_mTable, self);
    [_mTable registerNib:[UINib nibWithNibName:@"QuanYiOnSellCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"QuanYiOnSellCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title=@"在售权益";
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
    
    return 5;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 163;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QuanYiOnSellCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QuanYiOnSellCell" forIndexPath:indexPath];
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuyIn * list=[[BuyIn alloc]init];
    list.type=@"1";
    [self.navigationController pushViewController:list animated:YES];
}

@end
