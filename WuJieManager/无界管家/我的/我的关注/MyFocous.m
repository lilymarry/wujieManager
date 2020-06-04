//
//  MyFocous.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/23.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "MyFocous.h"
#import "MyFocousCell.h"
@interface MyFocous ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *mTable;

@end

@implementation MyFocous

- (void)viewDidLoad {
    [super viewDidLoad];
    adjustsScrollViewInsets_NO(_mTable, self);
    [_mTable registerNib:[UINib nibWithNibName:@"MyFocousCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyFocousCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title=@"关注的项目";
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
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 148;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyFocousCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyFocousCell" forIndexPath:indexPath];
    [cell.imaView sd_setImageWithURL:[NSURL URLWithString:@"http://test.wujiemall.com/Uploads/Ads/2018-04-15/5ad2d223f374c.jpg"] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    if (indexPath.section==0) {
        cell.stateLab.text=@"筹备中";
    }
    else
    {
        cell.stateLab.text=@"已营业";
    }
    if ( [cell.stateLab.text isEqualToString:@"已营业"]) {
        cell.progressView.hidden=YES;
        cell.percentageLab.hidden=YES;
    }
    else  {
        cell.progressView.hidden=NO;
        cell.percentageLab.hidden=NO;
    }
    [cell.guanzhuBtn addTarget:self action:@selector(guanzhuPress:) forControlEvents:UIControlEventTouchUpInside];
    cell.guanzhuBtn.tag=indexPath.section;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
-(void)guanzhuPress:(UIButton *)but
{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要取消关注吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * OkAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:OkAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
