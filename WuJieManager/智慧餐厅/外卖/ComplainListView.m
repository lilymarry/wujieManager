//
//  ComplainListView.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/28.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "ComplainListView.h"
#import "BuyInTypeCell.h"
@interface ComplainListView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arr;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property(nonatomic,strong)NSIndexPath *lastPath2;
@end

@implementation ComplainListView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"ComplainListView" owner:self options:nil];
        [self addSubview:_thisView];
        _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mTable.dataSource=self;
        _mTable.delegate=self;
        [_mTable registerNib:[UINib nibWithNibName:@"BuyInTypeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BuyInTypeCell"];
        _lastPath2 = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [_mTable selectRowAtIndexPath:_lastPath2 animated:YES scrollPosition:UITableViewScrollPositionNone];
        arr=[NSArray arrayWithObjects:@"达达态度恶劣",@"接单后未取货",@"取货速度太慢",@"送货速度太慢",@"货品未送达",@"货品损坏了",@"违规收取顾客小费",@"达达恶意取消订单",@"达达提前点击取货/送达",@"达达无标准保温箱", nil];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (IBAction)cancellPress:(id)sender {
    [self removeFromSuperview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return arr.count;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    BuyInTypeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BuyInTypeCell" forIndexPath:indexPath];
    
    cell.lab_payName.text=arr[indexPath.row];
    cell.ima_pay.hidden=YES;
    cell.ima_payWW.constant=0;
    if (_lastPath2.row==indexPath.row) {
        cell.ima_state.image=[UIImage imageNamed:@"对勾选中"];
    }
    else
    {
        cell.ima_state.image=[UIImage imageNamed:@"对勾未选中"];
    }
    return cell;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int newRow =(int) [indexPath row];
    
    int oldRow =(int)( (_lastPath2 !=nil)?[_lastPath2 row]:-1);
    if (newRow != oldRow) {
        BuyInTypeCell *newcell = [tableView cellForRowAtIndexPath:indexPath];
        newcell.ima_state.image=[UIImage imageNamed:@"对勾选中"];
        
        BuyInTypeCell *oldCell = [tableView cellForRowAtIndexPath:_lastPath2];
        oldCell.ima_state.image=[UIImage imageNamed:@"对勾未选中"];
        _lastPath2 = indexPath;
        
    }
    
}


@end
