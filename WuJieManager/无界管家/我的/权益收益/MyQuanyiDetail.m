//
//  MyQuanyiDetail.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/23.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "MyQuanyiDetail.h"
#import "MyQuanyiDetailCell.h"
@interface MyQuanyiDetail ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *colorArr;
    NSInteger index;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *titleViewHHH;
@property (strong, nonatomic) IBOutlet UIView *titleView;

@end

@implementation MyQuanyiDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    [_mTable registerNib:[UINib nibWithNibName:@"MyQuanyiDetailCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyQuanyiDetailCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.title=@"权益收益";
    _titleView.hidden=NO;
    _titleViewHHH.constant=50;
    [self createNav];
    colorArr=[NSArray arrayWithObjects:@[@"232",@"58",@"55"],@[@"92",@"172",@"224"],@[@"244",@"237",@"77"],@[@"160",@"203",@"78"],@[@"217",@"32",@"135"],@[@"255",@"116",@"27"],@[@"137",@"87",@"161"], nil];
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
    
    return 7;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyQuanyiDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyQuanyiDetailCell" forIndexPath:indexPath];
    if (indexPath.row==0) {
        cell.topLine.hidden=YES;
    }
    else
    {
        cell.topLine.hidden=NO;
    }
    if (indexPath.row%7==0) {
        index=0;
    }
      int R = [colorArr[index][0] intValue] ;
     int G = [colorArr[index][1] intValue] ;
      int B = [colorArr[index][2] intValue] ;
    
    cell.colorView.layer.borderColor=color(R, G, B).CGColor;
    index++;
    if ((int)(10-indexPath.row)+1>9) {
          cell.timeLab.text=[NSString stringWithFormat:@"2019.%d.28",(int)(10-indexPath.row)+1];
    }
    else
    {
         cell.timeLab.text=[NSString stringWithFormat:@"2019.0%d.28",(int)(10-indexPath.row)+1];
    }
  
    
    return cell;
}

@end
