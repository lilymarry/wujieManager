//
//  WorkFirst.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/17.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WorkFirst.h"
#import "WorkFirstTopView.h"
#import "WorkFirstCell.h"
#import "GYChangeTextView.h"
#import "NewsList.h"
#import "WorkDetail.h"
#define NAVBAR_CHANGE_POINT 50
@interface WorkFirst ()<UITableViewDelegate,UITableViewDataSource,EMChatManagerDelegate>
{
    WorkFirstTopView *top;
    GYChangeTextView * tView;//滚动图
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomHH;

@end

@implementation WorkFirst

- (void)viewDidLoad {
    [super viewDidLoad];
    _mTable.delegate = self;
    _mTable.dataSource = self;
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"WorkFirstCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WorkFirstCell"];

}
-(void)viewWillAppear:(BOOL)animated
{
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    //透明
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self scrollViewDidScroll:_mTable];
    
     NSString *version= [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >=10.0&&version.doubleValue <11.0) {
       _bottomHH.constant=44;
        adjustsScrollViewInsets_NO(_mTable, self);
    }
    else
    {
        _bottomHH.constant=0;
        
    }
     [self createSMineTopView];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [[EMClient sharedClient].chatManager getConversation:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].easemob_account type:EMConversationTypeChat createIfNotExist:YES];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
  
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar lt_reset];
    [tView stopAnimation];//停止文字动画的滚动
    
}
- (void)createSMineTopView {
    
    top = [[WorkFirstTopView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW/311*190-35+250)];
    top.datas=[NSArray arrayWithObjects:@{@"name":@"餐饮",@"imag":@"餐饮"},@{@"name":@"超市",@"imag":@"超市"},@{@"name":@"美容",@"imag":@"美容"},@{@"name":@"健身",@"imag":@"健身"},@{@"name":@"教育",@"imag":@"教育"},@{@"name":@"生鲜",@"imag":@"生鲜"},@{@"name":@"美发",@"imag":@"美发"},@{@"name":@"酒店",@"imag":@"酒店"}, nil];
    _mTable.tableHeaderView = top;
    
    
    //滚动图
    [tView removeFromSuperview];
    tView = [[GYChangeTextView alloc] initWithFrame:CGRectMake(15, 0, ScreenW - 90, 70)];
    [top.newslineView addSubview:tView];
    [tView animationWithTexts:[NSArray arrayWithObjects:@"无界掌柜热点内容1",@"无界掌柜热点内容2",@"无界掌柜热点内容3" , nil]];
    [top.newsListBtn addTarget:self action:@selector(newsListPress) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark tableView 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    WorkFirstCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"WorkFirstCell" forIndexPath:indexPath];
     [cell.imaView sd_setImageWithURL:[NSURL URLWithString:@"http://test.wujiemall.com/Uploads/Ads/2018-04-15/5ad2d223f374c.jpg"] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
     if (indexPath.row==0) {
           cell.stateLab.text=@"项目组";
     }
  else  if (indexPath.row==1) {
        cell.stateLab.text=@"筹备中";
    }
    else
    {
        cell.stateLab.text=@"已营业";
    }
     if ( [cell.stateLab.text isEqualToString:@"项目组"]) {
         cell.progressView.hidden=YES;
         cell.progressViewHH.constant=0;
         [cell.stateBtn setBackgroundImage:[UIImage imageNamed:@"项目组"] forState:UIControlStateNormal];
         
     }
   else if ( [cell.stateLab.text isEqualToString:@"已营业"]) {
        cell.progressView.hidden=YES;
        cell.progressViewHH.constant=0;
         [cell.stateBtn setBackgroundImage:[UIImage imageNamed:@"营业状态"] forState:UIControlStateNormal];
    }
    else  {
        cell.progressView.hidden=NO;
        cell.progressViewHH.constant=27;
        [cell.stateBtn setBackgroundImage:[UIImage imageNamed:@"营业状态"] forState:UIControlStateNormal];
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
    detail.type=@"1";//项目详情买入
    if (indexPath.row==0) {
        detail.isGroup=@"1"; //项目组 1
    }
    else
    {
        detail.isGroup=@"2";
    }
    
  
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark scrollViewdelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = navigationColor;
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 50) {
        CGFloat alpha = MIN(1, 1 - ((50 + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
        
        
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
        
        
    }
    
    //获取tableView当前的y偏移
    CGFloat contentOffsety  = scrollView.contentOffset.y;
    NSString *version= [UIDevice currentDevice].systemVersion;
    //如果当前的section还没有超出navigationBar，那么就是默认的tableView的contentInset
    if (contentOffsety<=(200-64)&&contentOffsety>=0) {
        if (KIsiPhoneX) {
            _mTable.contentInset = UIEdgeInsetsMake(-88, 0, 0, 0);
        }
        else
        {
            if (version.doubleValue >=10.0&&version.doubleValue <11.0) {
                _mTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            }
            else
            {
                _mTable.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
                
            }
        }
    }
    //当section将要就如navigationBar的后面时，改变tableView的contentInset的top，那么section的悬浮位置就会改变
    else if(contentOffsety>=200-64){
        if (version.doubleValue >=10.0&&version.doubleValue <11.0) {
            _mTable.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        }
        else
        {
            _mTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            
        }
    }
}
#pragma mark 资讯
-(void)newsListPress
{
    NewsList *list=[[NewsList alloc]init];
    list.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:list animated:YES];
}

@end
