//
//  HistoryDetailList.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/19.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "HistoryDetailList.h"
#import "HistoryDetailListCell.h"
#import "HistoryDetailListHead.h"
#define tittleWidth 700
@interface HistoryDetailList ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    UIScrollView *rightScrollView;
    UITableView *rightTableView;
    HistoryDetailListHead *view2;
}

@end

@implementation HistoryDetailList

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"历史收益记录";
    
    
    rightScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,64, ScreenW,ScreenH-64)];
    rightScrollView.bounces = NO;
    rightScrollView.delegate = self;
    [self.view addSubview:rightScrollView];
    
    rightScrollView.contentSize = CGSizeMake(tittleWidth,0);
    adjustsScrollViewInsets_NO(rightScrollView, self);
    
    rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, tittleWidth, rightScrollView.frame.size.height)];
    rightTableView.backgroundColor=[UIColor whiteColor];
    rightTableView.delegate = self;
    rightTableView.dataSource = self;
    rightTableView.rowHeight = 68;
    [rightScrollView addSubview:rightTableView];
    
    [rightTableView registerNib:[UINib nibWithNibName:@"HistoryDetailListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HistoryDetailListCell"];
    rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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

////防止滑动过程中锁定方向不让滑动
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    if(!decelerate)
//        [self scrollViewDidEndDecelerating:scrollView];
//}
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//
//}
#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 30;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 50;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HistoryDetailListHead * topView=[[HistoryDetailListHead alloc]instanceChooseView];
    return topView;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HistoryDetailListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryDetailListCell" forIndexPath:indexPath];
    
    return cell;
}


@end
