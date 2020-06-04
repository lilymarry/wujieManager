//
//  ThingReportCell.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/25.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "ThingReportCell.h"
#import "MyQuanyiDetailCell.h"
#import "ThingReportHeadCell.h"
@interface ThingReportCell()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *colorArr;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@end
@implementation ThingReportCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_mTable registerNib:[UINib nibWithNibName:@"MyQuanyiDetailCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyQuanyiDetailCell"];
    _mTable.delegate=self;
    _mTable.dataSource=self;
    _mTable.scrollEnabled=NO;
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
  
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return  35;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    ThingReportHeadCell * topView=[[ThingReportHeadCell alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 35)];
    if (section%2==0) {
        topView.backView.backgroundColor=color(255, 118, 20);
        topView.yearLab.text=@"2019年";
    }
    else
    {
        topView.backView.backgroundColor=color(0, 162, 255);
         topView.yearLab.text=@"2018年";
    }
    return topView;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
    
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyQuanyiDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyQuanyiDetailCell" forIndexPath:indexPath];
 
    cell.timeLab.text=[NSString stringWithFormat:@"0%d.28",(int)(4-indexPath.row)+1];
    cell.contentLab.text=@"鸡蛋羹+清蒸西兰花1碗+苹果1个";
    
    if (indexPath.section%2==0) {
      cell.colorView.backgroundColor=color(255, 118, 20);
     cell.colorView.layer.borderColor =color(255, 185, 120).CGColor;
    }
    else
    {
        cell.colorView.backgroundColor=color(0, 162, 255);
       cell.colorView.layer.borderColor =color(199, 233, 255).CGColor;
        
    }
    
    return cell;
}

@end
