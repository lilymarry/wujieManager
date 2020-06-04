//
//  NewsList.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/18.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "NewsList.h"
#import "NewsListHeaderView.h"
#import "NewsListCell.h"
#import "SHeadlines_infor.h"
@interface NewsList ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arr;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;

@end

@implementation NewsList

- (void)viewDidLoad {
    [super viewDidLoad];
     adjustsScrollViewInsets_NO(_mTable, self);
    self.title=@"资讯";
    
    [_mTable registerNib:[UINib nibWithNibName:@"NewsListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"NewsListCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;

     arr=[NSArray arrayWithObjects:@{@"time":@"2017-02-02 17:15:12",@"data":@[@{@"title":@"好项目不用投，走上人生巅峰不是梦好项目不用投，走上人生巅峰不是梦",@"image":@"http://test.wujiemall.com/Uploads/Ads/2018-04-15/5ad2d223f374c.jpg"},@{@"title":@"好项目不用投，走上人生巅峰不是梦好项目不用投，走上人生巅峰不是梦",@"image":@"http://test.wujiemall.com/Uploads/Ads/2018-04-15/5ad2d223f374c.jpg"}]},@{@"time":@"2017-02-02 17:15:12",@"data":@[@{@"title":@"好项目不用投，走上人生巅峰不是梦好项目不用投，走上人生巅峰不是梦",@"image":@"http://test.wujiemall.com/Uploads/Ads/2018-04-15/5ad2d223f374c.jpg"}]},@{@"time":@"2017-02-02 17:15:12",@"data":@[@{@"title":@"好项目不用投，走上人生巅峰不是梦好项目不用投，走上人生巅峰不是梦",@"image":@"http://test.wujiemall.com/Uploads/Ads/2018-04-15/5ad2d223f374c.jpg"}]},@{@"time":@"2017-02-02 17:15:12",@"data":@[@{@"title":@"好项目不用投，走上人生巅峰不是梦好项目不用投，走上人生巅峰不是梦",@"image":@"http://test.wujiemall.com/Uploads/Ads/2018-04-15/5ad2d223f374c.jpg"}]}, nil];
    
   
     [_mTable reloadData];
 
     [self createNav];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

      return arr.count;

    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSDictionary *dic=arr[section];
    return  [dic[@"data"] count];
  
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
      return  55;
  
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
           NewsListHeaderView * topView=[[NewsListHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 55)];
     NSDictionary *dic=arr[section];
       topView.timeLab.text=dic[@"time"];
    
        return topView;
   
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NewsListCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
        NSDictionary * dict = arr[indexPath.section];
        NSDictionary * subDic = dict[@"data"][indexPath.row];
    
        [cell.imagView sd_setImageWithURL:[NSURL URLWithString:subDic[@"image"]] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    cell.titleLab.text=[NSString stringWithFormat:@"%@",subDic[@"title"]];
    
    return cell;
  
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHeadlines_infor *info=[[SHeadlines_infor alloc]init];
    [self.navigationController pushViewController:info animated:YES];
}

@end
