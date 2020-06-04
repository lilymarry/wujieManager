//
//  DiningRoomNews.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/5.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "DiningRoomNews.h"
#import "OrderDetailContentCell.h"
#import "NewsListHeaderView.h"
#import "OnMeal.h"
#import "ExitView.h"
@interface DiningRoomNews ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mTable;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomHH;
@end

@implementation DiningRoomNews

- (void)viewDidLoad {
    [super viewDidLoad];
       _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
   [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([OrderDetailContentCell class]) bundle:nil] forCellReuseIdentifier:@"OrderDetailContentCell"];

    _mTable.estimatedRowHeight=50;
    _mTable.rowHeight=UITableViewAutomaticDimension;
    
     adjustsScrollViewInsets_NO(_mTable, self);
    NSString *version= [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >=10.0&&version.doubleValue <11.0) {
        _bottomHH.constant=50;
        
    }
    else
    {
        _bottomHH.constant=0;
        
    }


[self createNav];
}
- (void)createNav {
    self.title=[[LoginModel shareInstance] getUserInfo].user_info.merchant_name ;
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 130, 50);
    
    //  [lefthBtn1 addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [lefthBtn addTarget:self action:@selector(lefthBtn2Click) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    //   UIBarButtonItem * leftBtnItem1 = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn1];
    
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    //    if ([_type isEqualToString:@"2"]) {
    //        self.navigationItem.leftBarButtonItems = @[leftBtnItem1,leftBtnItem];
    //    }
    //    else
    //    {
    //        self.navigationItem.leftBarButtonItem = leftBtnItem;
    //    }
    
    
    
    UIImageView *  _headImaView=[[UIImageView alloc ]initWithFrame:CGRectMake(0, 10, 30, 30)];
    _headImaView.layer.masksToBounds = YES;
    _headImaView.layer.cornerRadius = _headImaView.frame.size.width/2;
    _headImaView.layer.borderWidth = 0.1;
    _headImaView.layer.borderColor =[UIColor clearColor].CGColor;
    
    [_headImaView sd_setImageWithURL:[NSURL URLWithString:[[LoginModel shareInstance] getUserInfo].user_info.head_icon] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    [lefthBtn addSubview:_headImaView];
    
    
    UILabel *nameLab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headImaView.frame)+2, 10, 100, 30)];
    nameLab.text=[[LoginModel shareInstance] getUserInfo].user_info.nick_name;
    nameLab.textColor=[UIColor whiteColor];
    [nameLab setFont:[UIFont systemFontOfSize:14]];
    [lefthBtn addSubview:nameLab];
    
    
}
-(void)lefthBtn2Click
{
    ExitView *view=[[ExitView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    [self.view.window addSubview:view];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
 
    return  1;
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return  55;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NewsListHeaderView * topView=[[NewsListHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 55)];
 
    topView.timeLab.text=@"2017-06-06 14:45:30";
    
    return topView;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
      return   UITableViewAutomaticDimension;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderDetailContentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailContentCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
 
    cell.contentLab.text=@"  A-001号桌发起退菜请求，请服务员前往询问顾客退菜情况并确认确定退菜操作。  A-001号桌发起退菜请求，请服务员前往询问顾客退菜情况并确认确定退菜操作。";
    cell.contentLab.backgroundColor=[UIColor whiteColor];
    cell.contentView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OnMeal *onMeal=[[OnMeal alloc]init];
  //  onMeal.type=@"1";
    onMeal.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:onMeal animated:YES];
}
@end
