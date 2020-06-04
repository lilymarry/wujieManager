//
//  AddBanquet.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/10.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "AddBanquet.h"
#import "AddBanquetCell_1.h"
#import "AddBanquetCell_2.h"
#import "AddBanquetCell_3.h"
#import "BanquetTypeView.h"//预定类型
#import "BanquetPayType.h"//结账方式
#import "BanquetTimeView.h"//宴会日期
#import "SelectTable.h"
#import "OrderSubFood.h"
@interface AddBanquet ()<UITableViewDelegate,UITableViewDataSource,ChooseDateViewDelegate>
{
    NSString *dateStr;
      NSString *startStr;
      NSString *endStr;
}
@property (weak, nonatomic) IBOutlet UITableView *mTable;

@end

@implementation AddBanquet

- (void)viewDidLoad {
    [super viewDidLoad];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([AddBanquetCell_1 class]) bundle:nil] forCellReuseIdentifier:@"AddBanquetCell_1"];
       [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([AddBanquetCell_2 class]) bundle:nil] forCellReuseIdentifier:@"AddBanquetCell_2"];
       [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([AddBanquetCell_3 class]) bundle:nil] forCellReuseIdentifier:@"AddBanquetCell_3"];
    [self createNav];
    self.title=@"添加宴会";
    dateStr=@"未设置";
    startStr=@"未设置";
    endStr=@"未设置";
      [_mTable addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScrollView)]];
}

- (void)createNav {
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"白色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -20, 0, 0);
    
    // [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}
- (void)tapScrollView{
    
    [self.view endEditing:YES];
    
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 3;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        AddBanquetCell_1 *cell=[tableView dequeueReusableCellWithIdentifier:@"AddBanquetCell_1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.typeBtn addTarget:self action:@selector(selectType) forControlEvents:UIControlEventTouchUpInside];//预定类型
        cell.payBtn.tag=1004;
        [cell.payBtn addTarget:self action:@selector(selectPay:) forControlEvents:UIControlEventTouchUpInside];//付款方式
      
        return cell;
    }
  else  if (indexPath.row==1) {
        AddBanquetCell_2 *cell=[tableView dequeueReusableCellWithIdentifier:@"AddBanquetCell_2"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
      cell.dateBtn.tag=1001;
      [cell.dateBtn addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventTouchUpInside];
      cell.startBtn.tag=1002;
      [cell.startBtn addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventTouchUpInside];
      cell.endBtn.tag=1003;
      [cell.endBtn addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventTouchUpInside];
      
      cell.typeBtn.tag=1005;
      [cell.typeBtn addTarget:self action:@selector(selectPay:) forControlEvents:UIControlEventTouchUpInside];
        [cell.tableBtn addTarget:self action:@selector(selectTable) forControlEvents:UIControlEventTouchUpInside];
       [cell.foodBtn addTarget:self action:@selector(selectFood) forControlEvents:UIControlEventTouchUpInside];
      
      cell.dateLab.text=dateStr;
      cell.startLab.text=startStr;
      cell.endLab.text=endStr;
      if ([dateStr isEqualToString:@"未设置"]) {
          cell.typeView.hidden=YES;
          cell.typeViewHH.constant=0;
          cell.startView.hidden=YES;
          cell.startViewHH.constant=0;
          cell.endView.hidden=YES;
          cell.endViewHH.constant=0;
      }
      else
      {
          cell.typeView.hidden=NO;
          cell.typeViewHH.constant=50;
          cell.startView.hidden=NO;
          cell.startViewHH.constant=50;
          cell.endView.hidden=NO;
          cell.endViewHH.constant=50;
      }
        return cell;
    }
   else {
        AddBanquetCell_3 *cell=[tableView dequeueReusableCellWithIdentifier:@"AddBanquetCell_3"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
    
}
-(void)selectType
{
    [self.view endEditing:YES];
    BanquetTypeView *type=[[BanquetTypeView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    [self.view.window addSubview:type];
}
-(void)selectPay:(UIButton *)but
{
    [self.view endEditing:YES];
    BanquetPayType *type=[[BanquetPayType alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    if (but.tag==1004) {
          type.type=@"1";
    }
    else
    {
         type.type=@"2";
    }
  
    [self.view.window addSubview:type];
}
-(void)selectDate:(UIButton *)but
{
    [self.view endEditing:YES];
      BanquetTimeView *type=[[BanquetTimeView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    if (but.tag==1001) {
      
        type.type=@"1";
      
    }
  else  if (but.tag==1002) {
     
        type.type=@"2";
      
    }
   else if (but.tag==1003) {
       
        type.type=@"3";
       
    }
    type.delgate=self;
      [self.view.window addSubview:type];
}
-(void)chooseDateView:(NSString *)data type:(NSString *)type
{
  
    if ([type isEqualToString:@"1"]) {
        dateStr=data;
    }
    else if ([type isEqualToString:@"2"])
    {
        startStr=data;
    }
    else
    {
        endStr=data;
    }
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:0];
   
    [_mTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)selectTable
{
    [self.view endEditing:YES];
    SelectTable  *to=[[SelectTable alloc]initWithBlock:^(NSString *names)
                      {
                      
                       
                      }];
  
    [self.navigationController pushViewController:to animated:YES];
}
-(void)selectFood
{
    [self.view endEditing:YES];
     OrderSubFood*food=[[OrderSubFood alloc]init];
   // food.type=@"1";
    [self.navigationController pushViewController:food animated:YES];
}
@end
