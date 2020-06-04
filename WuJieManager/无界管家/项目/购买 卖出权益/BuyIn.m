//
//  BuyIn.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/19.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "BuyIn.h"
#import "BuyInTypeCell.h"
#import "BuyInContentCell.h"
#import "WorkFirstCell.h"
#import "WorkDetailHeadView.h"
#import "XieyiDetail.h"
#import "BuyInSuccess.h"
#import "WorkDetailBtnView.h"
#import "BuyInChargeCell.h"
@interface BuyIn ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * arr;
    WorkDetailBtnView * HeadView1;
    NSString *sup_type;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property(nonatomic,strong)NSIndexPath *lastPath2;
@property (strong, nonatomic) IBOutlet UIButton *agreeBtn;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong, nonatomic) IBOutlet UIButton *xieyiBtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHHH;
@property (weak, nonatomic) IBOutlet UILabel *xieyiLab;


@end

@implementation BuyIn

- (void)viewDidLoad {
    [super viewDidLoad];
    [_mTable registerNib:[UINib nibWithNibName:@"BuyInTypeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BuyInTypeCell"];
    [_mTable registerNib:[UINib nibWithNibName:@"BuyInContentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BuyInContentCell"];
    
    [_mTable registerNib:[UINib nibWithNibName:@"WorkFirstCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WorkFirstCell"];
    [_mTable registerNib:[UINib nibWithNibName:@"BuyInChargeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BuyInChargeCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    arr = @[
            @{
                @"payIma"   :@"支付宝支付",
                @"payName"  :@"支付宝支付",
                @"payType"  :@"2"
                },
            @{
                @"payIma"   :@"微信支付",
                @"payName"  :@"微信支付",
                @"payType"  :@"1"
                },
            @{
                @"payIma"   :@"余额支付",
                @"payName"  :@"余额支付",
                @"payType"  :@"4"
                }
            
            ];
    if ([_type isEqualToString:@"1"]) {
        self.title=@"买入";
        _lastPath2 = [NSIndexPath indexPathForRow:0 inSection:2];
        [_mTable selectRowAtIndexPath:_lastPath2 animated:YES scrollPosition:UITableViewScrollPositionNone];
      
    }
    else
    {
        self.title=@"卖出";
        _agreeBtn.hidden=YES;
        _submitBtn.backgroundColor=navigationColor;
        _submitBtn.enabled=YES;
        _xieyiBtn.hidden=YES;
        _bottomViewHHH.constant=80;
          _xieyiLab.hidden=YES;
        
    }
    
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 10;
    sup_type=@"1";
    
    [self createNav];
}
-(void)viewWillAppear:(BOOL)animated
{
    
    if ([_type isEqualToString:@"1"]) {
        NSString *saveSign = [[NSUserDefaults standardUserDefaults] objectForKey:@"saveSign"];
        if ([saveSign isEqualToString:@"saveSignOK"]) {
            _agreeBtn.selected=YES;
            
            _submitBtn.backgroundColor=navigationColor;
            _submitBtn.enabled=YES;
        }
        else
        {
            _agreeBtn.selected=NO;
            
            _submitBtn.backgroundColor=[UIColor lightGrayColor];
            _submitBtn.enabled=NO;
        }
    }
    
    
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

#pragma mark segment 点击
-(void)change:(UISegmentedControl *)sender{
    
    if (sender.selectedSegmentIndex == 0) {
        sup_type=@"1";//直接购买
    }else {
        
        sup_type=@"2";//充值赠送
    }
    [_mTable reloadData];
}
#pragma mark tableView 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([_type isEqualToString:@"1"]) {
        return 3;
    }
    else
    {
        return 2;
        
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return arr.count;//付款方式
            break;
            
        default:
            break;
    }
    
    
    return 0;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==2||section==1) {
        if ([_type isEqualToString:@"2"]) {
            return 0.01;
        }
        
        return 50;
    }
    
    return 4;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section==1) {
        if ([_type isEqualToString:@"1"]) {
            
            
            HeadView1=[[WorkDetailBtnView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
            HeadView1.but1.hidden=YES;
            HeadView1.centerLine1.hidden=YES;
            HeadView1.but2.hidden=YES;
            HeadView1.centerLine2.hidden=YES;
            HeadView1.but3.hidden=YES;
            HeadView1.centerLine3.hidden=YES;
            HeadView1.but4.hidden=YES;
            HeadView1.centerLine4.hidden=YES;
            
            HeadView1.segment.hidden=NO;
            
            if ([sup_type isEqualToString:@"1"]) {
                
                HeadView1.segment.selectedSegmentIndex=0;
            }
            else
            {
                HeadView1.segment.selectedSegmentIndex=1;
            }
            
            [HeadView1.segment addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
            
            return HeadView1;
            
            
        }}
    else  if (section==2) {
        WorkDetailHeadView * topView=[[WorkDetailHeadView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
        
        topView.flag_imageView.hidden=YES;
        topView.titleLab.text=@"请选择支付方式";
        topView.subTitleLab.hidden=YES;
        
        return topView;
    }
    
    else
    {
        UIView * topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 4)];
        topView.backgroundColor=[UIColor whiteColor];
        
        return topView;
    }
    
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0)
    {
        return 260;
    }
    else if (indexPath.section==1) {
        if ([_type isEqualToString:@"1"]) {
            if ([sup_type isEqualToString:@"2"]) {
                return 199;
            }
            return 306;
        }
        else
        {
            return 256;
        }
        
    }
    else {
        
        return 44;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section==2||section==1) {
        return 8;
    }
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        WorkFirstCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WorkFirstCell" forIndexPath:indexPath];
        [cell.imaView sd_setImageWithURL:[NSURL URLWithString:@"http://test.wujiemall.com/Uploads/Ads/2018-04-15/5ad2d223f374c.jpg"] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        
        cell.stateLab.text=@"已营业";
        
        if ( [cell.stateLab.text isEqualToString:@"已营业"]) {
            cell.progressView.hidden=YES;
            cell.progressViewHH.constant=0;
        }
        else  {
            cell.progressView.hidden=NO;
            cell.progressViewHH.constant=27;
        }
        cell.onSellNum.hidden=YES;
        cell.sumNum.hidden=YES;
        
        return cell;
    }
    else if (indexPath.section==1) {
        if ([sup_type isEqualToString:@"1"]) {
            
            BuyInContentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BuyInContentCell" forIndexPath:indexPath];
            if ([_type isEqualToString:@"1"]) {
                cell.view2_title.text=@"在售份数";
                cell.view5_title.text=@"购买份数";
                cell.sview1.hidden=NO;
                cell.sview1HHH.constant=50;
                [cell.allBtn setTitle:@"全部买入" forState:UIControlStateNormal];
                cell.view4_deductBtn.hidden=YES;
                cell.view4_addBtn.hidden=YES;
                
            }
            else
            {
                cell.view5_title.text=@"卖出份数";
                cell.view2_title.text=@"持有权益数";
                cell.sview1.hidden=YES;
                cell.sview1HHH.constant=0;
                [cell.allBtn setTitle:@"全部卖出" forState:UIControlStateNormal];
            }
            
            
            return cell;
        }
        else
        {
            BuyInChargeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BuyInChargeCell" forIndexPath:indexPath];
            return cell;
        }
        
        
    }
    else  {
        BuyInTypeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BuyInTypeCell" forIndexPath:indexPath];
        NSDictionary *dic=arr[indexPath.row];
        cell.ima_pay.image=[UIImage imageNamed:dic[@"payIma"]];
        cell.lab_payName.text=dic[@"payName"];
        if (_lastPath2.row==indexPath.row) {
            cell.ima_state.image=[UIImage imageNamed:@"对勾选中"];
        }
        else
        {
            cell.ima_state.image=[UIImage imageNamed:@"未选中图标"];
        }
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int newRow =(int) [indexPath row];
    
    
    if (indexPath.section==2) {
        int oldRow =(int)( (_lastPath2 !=nil)?[_lastPath2 row]:-1);
        if (newRow != oldRow) {
            BuyInTypeCell *newcell = [tableView cellForRowAtIndexPath:indexPath];
            newcell.ima_state.image=[UIImage imageNamed:@"对勾选中"];
            
            BuyInTypeCell *oldCell = [tableView cellForRowAtIndexPath:_lastPath2];
            oldCell.ima_state.image=[UIImage imageNamed:@"未选中图标"];
            _lastPath2 = indexPath;
            
        }
    }
}
#pragma  mark 协议
- (IBAction)readXieyiPress:(id)sender {
    XieyiDetail *detail=[[XieyiDetail alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma  mark 同意协议
- (IBAction)agreeXieYiPress:(id)sender {
    NSString *saveSign = [[NSUserDefaults standardUserDefaults] objectForKey:@"saveSign"];
    if ([saveSign isEqualToString:@"saveSignOK"]) {
        UIButton *but=(UIButton *)sender;
        but.selected=!but.selected;
        if (but.selected) {
            _submitBtn.backgroundColor=navigationColor;
            _submitBtn.enabled=YES;
        }
        else
        {
            _submitBtn.backgroundColor=[UIColor lightGrayColor];
            _submitBtn.enabled=NO;
        }
    }
    else
    {
        XieyiDetail *detail=[[XieyiDetail alloc]init];
        [self.navigationController pushViewController:detail animated:YES];
    }
    
    
}
#pragma  mark 确认购买
- (IBAction)surePress:(id)sender {
    if ([_type isEqualToString:@"1"]) {
        BuyInSuccess *success=[[BuyInSuccess  alloc]init];
        [self.navigationController pushViewController:success animated:YES];
    }
    else
    {
        
    }
    
}


@end
