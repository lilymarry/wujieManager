//
//  Pay.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/7/26.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "Pay.h"
#import "PayCell.h"
#import "PayTopView.h"
#import "ScanPay.h"
#import "PayTypeList.h"
#import "OrderInfo.h"
#import "PayCartList.h"
#import "UserCenter.h"
@interface Pay ()
{
    NSArray * payTypeArr;
    PayTopView *top;
    NSString *numStr;
    NSString *cartNameStr;
    
    NSString *balance;
}
@property (nonatomic ,strong)NSString *payMoney;
@property (weak, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation Pay
- (void)createTopView {
    top = [[PayTopView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 154)];
  
    _mTable.tableHeaderView = top;
    
}
- (void)createNav {
    
  
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"白色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    
    [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
  
    
    [self createTopView];
       _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
     [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([PayCell class]) bundle:nil] forCellReuseIdentifier:@"PayCell"];
    
    self.title=@"收银台";
    
    [self getPayType];
  
    
}

-(void)getPayType
{
    NSMutableArray *typeArr=[NSMutableArray array];
    
    /*
    NSMutableDictionary *dict1=      @{
                                       @"name"   :@"会员卡",
                                       @"sub_name"  :@"推荐会员卡用户使用",
                                       @"image"  :@"会员卡支付方"
                                       ,@"isSelect": @"0"
                                       ,@"sort"  :@0
                                       }.mutableCopy;
    [typeArr addObject:dict1];
   */
    

    NSMutableDictionary *dict=      @{
                                      @"name"   :@"现金",
                                      @"sub_name"  :@"土豪豪~我们做朋友吧\(^o^)/~",
                                      @"image"  :@"现金支付方"
                                      ,@"isSelect": @"1"
                                      ,@"sort"  :@4
                                      }.mutableCopy;
    [typeArr addObject:dict];
    
    PayTypeList *type=[[PayTypeList alloc]init];
    type.order_sn=_order_sn;
    [MBProgressHUD showMessage:nil toView:self.view];
    [type PayTypeListSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            PayTypeList *type=(PayTypeList *)data;
            NSArray *arr=type.data;
            if (arr.count>0) {
                if ([arr containsObject:@1]) {
                    NSMutableDictionary *dic=   @{
                                                  @"name"   :@"微信",
                                                  @"sub_name"  :@"推荐微信用户使用",
                                                  @"image"  :@"微信支付方"
                                                  ,@"isSelect": @"0"
                                                  ,@"sort"  :@2
                                                  }.mutableCopy;
                    [typeArr addObject:dic];
                }
                if ([arr containsObject:@2]) {
                    NSMutableDictionary *dic=    @{
                                                   @"name"   :@"支付宝",
                                                   @"sub_name"  :@"推荐支付宝用户使用",
                                                   @"image"  :@"支付宝支付方"
                                                   ,@"isSelect": @"0"
                                                   ,@"sort"  :@3
                                                   }.mutableCopy;
                    [typeArr addObject:dic];
                }
                
            }
            //支付方式 升序排序
            NSArray *sortDesc = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"sort" ascending:YES]];
            payTypeArr =[NSArray arrayWithArray: [typeArr sortedArrayUsingDescriptors:sortDesc]];
            
            [self getOrderInfoData];
             [_mTable reloadData];
        }
        else
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:message toView:self.view];
            });
            
            
        }
        
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
-(void)getOrderInfoData
{
    OrderInfo *order=[[OrderInfo alloc]init];
    order.order_sn=_order_sn;
    [MBProgressHUD showMessage:nil toView:self.view];
    [order OrderInfoSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if ([code intValue]==200) {
            OrderInfo *list= (OrderInfo *)data;
            
            NSString *  payPrice=[NSString stringWithFormat:@"%.2f",[list.data.total_price doubleValue]];
            
            _payMoney=payPrice;
            
            NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"订单需支付:￥%@",payPrice]];
            
            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20.0f] range:NSMakeRange(6,payPrice.length+1)];
            
            
            top.payMoneyLab.attributedText=AttributedStr;
            
            if (list.data.uid.length>0&&[list.data.uid intValue]!=0) {
                [self getBalanceWithUid:list.data.uid];
                
            }
            
        }
        else
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:message toView:self.view];
            });
        }
        
        
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
}
-(void)getBalanceWithUid:(NSString *)uid
{
    UserCenter  *center=[[UserCenter alloc]init];
    center.uid=uid;
    center.type=@"1";
    [MBProgressHUD showMessage:nil toView:self.view];
    [center UserCenterSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            UserCenter  *center=(UserCenter *)data;
            balance=center.data.balance;
            NSMutableArray *typeArr=[NSMutableArray arrayWithArray:payTypeArr];
            if ([balance doubleValue]>0 ) {
                NSMutableDictionary *dic=   @{
                                              @"name"   :@"无界余额",
                                              @"sub_name"  : [NSString stringWithFormat:@"余额(¥%.2f)",[balance doubleValue]  ],
                                              @"image"  :@"无界余额支付方"
                                              ,@"isSelect": @"0"
                                              ,@"sort"  :@1
                                              }.mutableCopy;
                [typeArr addObject:dic];
                
            }
            
            //支付方式 升序排序
            NSArray *sortDesc = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"sort" ascending:YES]];
            payTypeArr =[NSArray arrayWithArray: [typeArr sortedArrayUsingDescriptors:sortDesc]];
              [_mTable reloadData];
        }
        else
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:message toView:self.view];
            });
        }
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return payTypeArr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    PayCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PayCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dict=payTypeArr[indexPath.row];
    
    cell.nameLab.text=dict[@"name"];
    cell.subTitleLab.text=dict[@"sub_name"];
    cell.imagview.image=[UIImage imageNamed:dict[@"image"]];
    if ([dict[@"name"] isEqualToString:@"会员卡"]) {
          cell.flag_image.image=[UIImage imageNamed:@"灰色右箭头"];
          cell.cartNameLab.text=cartNameStr;
          cell.cartNameLab.hidden=NO;
    }
    else
    {
         cell.cartNameLab.hidden=YES;
    if ([dict[@"isSelect"] isEqualToString:@"1"]) {
        cell.flag_image.image=[UIImage imageNamed:@"圆形选中"];
    }
    else
    {
        cell.flag_image.image=[UIImage imageNamed:@"圆形未选中"];
    }
    }
   
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 67;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict=payTypeArr[indexPath.row];
    NSString *name=dict[@"name"];
    if (![name isEqualToString:@"会员卡"]) {
        [self setArrNotSelect];
        payTypeArr[indexPath.row][@"isSelect"] = @"1";
        cartNameStr=@"";
        numStr=@"";
        [_mTable reloadData];
      
    }
    else
    {
     
        PayCartList *cart=[[PayCartList alloc]init];
        cart.selectNum=numStr;
        cart.block = ^(NSInteger num,NSString *cartName) {
            numStr=[NSString stringWithFormat:@"%ld",num];
            [self setArrNotSelect];
            cartNameStr=cartName;
            payTypeArr[indexPath.row][@"isSelect"] = @"1";
            [_mTable reloadData];
        };
        [self.navigationController pushViewController:cart animated:YES];
    }
    
}
-(void)setArrNotSelect
{
    for (NSMutableDictionary *dic in payTypeArr) {
        dic[@"isSelect"] = @"0";
    }
}
- (IBAction)surePress:(id)sender {
    if (payTypeArr.count>0) {
        NSDictionary *dict=[self getSelectDic];
        if (dict.count==0) {
            [MBProgressHUD showSuccess:@"请选择支付方式" toView:self.view];
            return;
        }
        NSString *name=dict[@"name"];
        if (![name isEqualToString:@"会员卡"]) {
            ScanPay *pay=[[ScanPay alloc]init];
            pay.type=dict[@"name"];
            pay.order_sn=_order_sn;
            [self.navigationController pushViewController:pay animated:YES];
        }
       
    }
    
}
-(NSDictionary *)getSelectDic
{
    for (NSMutableDictionary *dic in payTypeArr) {
        if ( [dic[@"isSelect"] isEqualToString:@"1"]) {
            return dic;
        }
      
    }
    return nil;
}

@end
