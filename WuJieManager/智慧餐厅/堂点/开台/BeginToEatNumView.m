//
//  TitleListView.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/7/4.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "BeginToEatNumView.h"
#import "RuZouDeskNumber.h"
#import "TitleListViewCell.h"
@interface BeginToEatNumView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataArr;
   
}
@property (weak, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation BeginToEatNumView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"BeginToEatNumView" owner:self options:nil];
        [self addSubview:_thisView];
        [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([TitleListViewCell class]) bundle:nil] forCellReuseIdentifier:@"TitleListViewCell"];
        _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mTable.dataSource=self;
        _mTable.delegate=self;
     
    }
    return self;
}
-(void)reloadTabView:(NSArray *)data
{
    dataArr=[NSArray arrayWithArray:data];
    [_mTable reloadData];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (IBAction)cancellPress:(id)sender {
    [self removeFromSuperview];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    TitleListViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"TitleListViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    RuZouDeskNumber *list= dataArr[indexPath.row];
    cell.nameLab.text=list.take_info;

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     RuZouDeskNumber *list= dataArr[indexPath.row];
    [self removeFromSuperview];
    self.beginToEatNumViewBlock(list.take_info,list.id);
}

- (IBAction)cansellPress:(id)sender {
    [self removeFromSuperview];
   // self.cansellListViewBlock();
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
