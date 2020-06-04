//
//  OrderDetail.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/7/29.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "PayFinishOrderDetail.h"
#import "OrderInfo.h"
#import "RowNumDetailCell.h"
#import "PayFinishOrderDetailTop.h"
@interface PayFinishOrderDetail ()<UITableViewDelegate, UITableViewDataSource>
{
      NSMutableArray *infoData_arr;//订单详情
     PayFinishOrderDetailTop *top;
 
}
@property (weak, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation PayFinishOrderDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self getData];
    [self createNav];
    self.title=@"账单详情";
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([RowNumDetailCell class]) bundle:nil] forCellReuseIdentifier:@"RowNumDetailCell"];
       [self createTopView];
}
- (void)createTopView {
    top = [[PayFinishOrderDetailTop alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 154)];
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
          [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)getData
{
  OrderInfo *order=[[OrderInfo alloc]init];
  order.order_sn=_order_sn;
  [MBProgressHUD showMessage:nil toView:self.view];
  [order OrderInfoSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
 
    if ([code intValue]==200) {
        OrderInfo *list= (OrderInfo *)data;
        

          NSString * payPrice=[NSString stringWithFormat:@"%.2f",[list.data.pay_price doubleValue]];
        
        
            NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥ %@",payPrice]];
        
            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20.0f] range:NSMakeRange(1,payPrice.length+1)];
        
        
            top.payMoneyLab.attributedText=AttributedStr;
        
        infoData_arr=[NSMutableArray array];
        
        if (list.data.user_name.length>0) {
            NSDictionary *dic=@{
                                @"name"   :@"付款人",
                                @"content"  :list.data.user_name
                                };
            [infoData_arr addObject:dic];
        }
      
        NSDictionary *dic=@{
                                        @"name"   :@"订单状态",
                                        @"content"  :@"已付款"
                                        };
          [infoData_arr addObject:dic];
        if (list.data.created_at.length>0) {
            NSDictionary *dic=@{
                                @"name"   :@"下单时间",
                                @"content"  :list.data.created_at
                                };
            [infoData_arr addObject:dic];
        }
        if (list.data.cname.length>0) {
            NSDictionary *dic=@{
                                @"name"   :@"门店名称",
                                @"content"  :list.data.cname
                                };
            [infoData_arr addObject:dic];
        }
       
        if (list.data.desk_name.length>0) {
            NSDictionary *dic=@{
                                @"name"   :@"桌台信息",
                                @"content"  :list.data.desk_name
                                };
            [infoData_arr addObject:dic];
        }
                     dic=@{
                            @"name"   :@"订单类型",
                            @"content"  :@"堂食"
                            };
        [infoData_arr addObject:dic];
        if (list.data.order_sn.length>0) {
            NSDictionary *dic=@{
                                @"name"   :@"订单编号",
                                @"content"  :list.data.order_sn
                                };
            [infoData_arr addObject:dic];
        }
       

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
  
        return infoData_arr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RowNumDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:@"RowNumDetailCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLab.text=infoData_arr[indexPath.row][@"name"];
    cell.subTitle.text=infoData_arr[indexPath.row][@"content"];
    cell.subTitle.textAlignment=NSTextAlignmentRight;
    if ([infoData_arr[indexPath.row][@"name"] isEqualToString:@"订单状态"]) {
        cell.subTitle.textColor=[UIColor redColor];
    }
    else
    {
        cell.subTitle.textColor=[UIColor blackColor];
    }
        return cell;
   
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 50;
}
- (IBAction)goFirst:(id)sender {
    TabBarController * tabBarController = [[TabBarController alloc] init];
    self.view.window.rootViewController = tabBarController;
    tabBarController.selectedIndex=1;
}

@end
