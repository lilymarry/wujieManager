//
//  OrderDetail.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/9.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "OrderDetail.h"
#import "OrderDetailUserCell.h"
#import "OrderDetailGoodsCell.h"
#import "OrderDetailContentCell.h"
#import "ComplainList.h"
#import "OrderDetailUserPadCell.h"
#import "ComplainListView.h"
@interface OrderDetail ()<UITableViewDelegate, UITableViewDataSource>
{
    NSInteger typeNum;
   
    NSArray *infoData;
}
@property (weak, nonatomic) IBOutlet UITableView *mTable;
@property(weak,nonatomic)IBOutlet UIButton *oneBtn;
@property(weak,nonatomic)IBOutlet UIButton *twoBtn;
@property(weak,nonatomic)IBOutlet UILabel *sumMoneyLab;
@end

@implementation OrderDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([OrderDetailUserCell class]) bundle:nil] forCellReuseIdentifier:@"OrderDetailUserCell"];
       [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([OrderDetailUserPadCell class]) bundle:nil] forCellReuseIdentifier:@"OrderDetailUserPadCell"];
     [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([OrderDetailGoodsCell class]) bundle:nil] forCellReuseIdentifier:@"OrderDetailGoodsCell"];
     [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([OrderDetailContentCell class]) bundle:nil] forCellReuseIdentifier:@"OrderDetailContentCell"];
    
    self.title=@"订单详情";
    if ([_type isEqualToString:@"新订单"]) {
        [_oneBtn  setTitle:@"立即接单" forState:UIControlStateNormal];
        [_twoBtn  setTitle:@"拒绝接单" forState:UIControlStateNormal];
        
    }
   else if ([_type isEqualToString:@"待配送"])
   {
       _oneBtn.hidden=YES;
       _twoBtn.hidden=YES;
   }
   else if ([_type isEqualToString:@"待取货"])
   {
       [_oneBtn  setTitle:@"订单投诉" forState:UIControlStateNormal];
       _twoBtn.hidden=YES;
   }
  
    else if ([_type isEqualToString:@"待退款"])
    {
        [_oneBtn  setTitle:@"同意退款" forState:UIControlStateNormal];
        [_twoBtn  setTitle:@"拒绝退款" forState:UIControlStateNormal];
    }
    else 
    {
        _twoBtn.hidden=YES;
        _oneBtn.hidden=YES;
    }
    [self getData];
    
    [_oneBtn addTarget:self action:@selector(onePress:) forControlEvents:UIControlEventTouchUpInside];
    [_twoBtn addTarget:self action:@selector(twoPress:) forControlEvents:UIControlEventTouchUpInside];
     adjustsScrollViewInsets_NO(_mTable, self);
}
-(void)getData
{
    if ([_type isEqualToString:@"新订单"]||[_type isEqualToString:@"待配送"]||[_type isEqualToString:@"已过期"]||[_type isEqualToString:@"已取消"]) {
        
        infoData=@[
                   @{
                       @"name"   :@"订单编号",
                       @"content"  :@"2899 7643 4114"
                       },
                   @{
                       @"name"   :@"下单时间",
                       @"content"  :@"2018/01/02 17:15:54"
                       },
                   @{
                       @"name"   :@"支付方式",
                       @"content"  :@"微信支付"
                       },
                   @{
                       @"name"   :@"订单备注",
                       @"content"  :@"不要放香菜，切记，切记"
                       }
                   
                   ];
    }
    
  else  if ([_type isEqualToString:@"待取货"]) {
        
        infoData=@[
                   @{
                       @"name"   :@"订单编号",
                       @"content"  :@"2899 7643 4114"
                       },
                   @{
                       @"name"   :@"下单时间",
                       @"content"  :@"2018/01/02 17:15:54"
                       },
                   @{
                       @"name"   :@"支付方式",
                       @"content"  :@"微信支付"
                       },
                   @{
                       @"name"   :@"订单备注",
                       @"content"  :@"不要放香菜，切记，切记"
                       }
                   ,
                   @{
                       @"name"   :@"配送骑手",
                       @"content"  :@"可爱的小donkey"
                       }
                   ];
    }
  else  if ([_type isEqualToString:@"待退款"]||[_type isEqualToString:@"退款中"]) {
      
      infoData=@[
                 @{
                     @"name"   :@"订单编号",
                     @"content"  :@"2899 7643 4114"
                     },
                 @{
                     @"name"   :@"下单时间",
                     @"content"  :@"2018/01/02 17:15:54"
                     },
                 @{
                     @"name"   :@"支付方式",
                     @"content"  :@"微信支付"
                     },
                 @{
                     @"name"   :@"订单备注",
                     @"content"  :@"不要放香菜，切记，切记"
                     }
                 ,
                 @{
                     @"name"   :@"退款原因",
                     @"content"  :@"汤撒了----"
                     }
                 ];
      _sumMoneyLab.text=@"退款金额: ¥200";
  }
  else  if ([_type isEqualToString:@"妥投异常"]) {
      
      infoData=@[
                 @{
                     @"name"   :@"订单编号",
                     @"content"  :@"2899 7643 4114"
                     },
                 @{
                     @"name"   :@"下单时间",
                     @"content"  :@"2018/01/02 17:15:54"
                     },
                 @{
                     @"name"   :@"支付方式",
                     @"content"  :@"微信支付"
                     },
                 @{
                     @"name"   :@"订单备注",
                     @"content"  :@"不要放香菜，切记，切记不要放香菜，切记，切记不要放香菜，切记，切记不要放香菜，切记，切记不要放香菜，切记，切记不要放香菜，切记，切记不要放香菜，切记，切记不要放香菜，切记，切记不要放香菜，切记，切记不要放香菜，切记，切记不要放香菜，切记，切记不要放香菜，切记，切记不要放香菜，切记，切记不要放香菜，切记，切记不要放香菜，切记，切记不要放香菜，切记，切记不要放香菜，切记，切记"
                     }
                 ,
                 @{
                     @"name"   :@"配送骑手",
                     @"content"  :@"可爱的小donkey"
                     }
                 ,
                 @{
                     @"name"   :@"异常原因",
                     @"content"  :@"一直联系不上买家"
                     }
                 ];
  }
  else  if ([_type isEqualToString:@"已完成"]) {
      
      infoData=@[
                 @{
                     @"name"   :@"订单编号",
                     @"content"  :@"2899 7643 4114"
                     },
                 @{
                     @"name"   :@"下单时间",
                     @"content"  :@"2018/01/02 17:15:54"
                     },
                 @{
                     @"name"   :@"支付方式",
                     @"content"  :@"微信支付"
                     },
                 @{
                     @"name"   :@"订单备注",
                     @"content"  :@"不要放香菜，切记，切记"
                     }
                 ,
                 @{
                     @"name"   :@"配送骑手",
                     @"content"  :@"可爱的小donkey"
                     }
                 ,
                 @{
                     @"name"   :@"送达时间",
                     @"content"  :@"2018/01/02 17:15:54"
                     }
                 ];
  }
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    else if (section ==1)
    {
        return 2;
    }
    else
    {
        return infoData.count;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (IS_PAD) {
            OrderDetailUserPadCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OrderDetailUserPadCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        OrderDetailUserCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OrderDetailUserCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.section==1)
    {
        OrderDetailGoodsCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OrderDetailGoodsCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.headImaView sd_setImageWithURL:[NSURL URLWithString:@"http://test.wujiemall.com/Uploads/Ads/2018-04-15/5ad2d223f374c.jpg"] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.stateLab.text=_type;
        if (indexPath.row==0) {
            cell.stateLab.hidden=NO;
          
        }
        else
        {
            cell.stateLab.hidden=YES;
        }
        return cell;
    }
    else
    {
        OrderDetailContentCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OrderDetailContentCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        NSString  *str1=infoData[indexPath.row][@"name"];
        NSString  *str2=infoData[indexPath.row][@"content"];
        NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@: %@",str1,str2]];
 
        
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, str1.length+1)];
      
        if ([str1 isEqualToString:@"退款原因"]||[str1 isEqualToString:@"异常原因"]) {
              [AttributedStr addAttribute:NSForegroundColorAttributeName value:navigationHotelColor range:NSMakeRange(str1.length+1, str2.length+1)];
        }
        cell.contentLab.attributedText = AttributedStr;
        
        return cell;
    }
    
  
 
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==2) {
        return 0.01;
    }
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *topView=[[UIView alloc ]initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
    topView.backgroundColor=[UIColor groupTableViewBackgroundColor];
  
    return topView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==2) {
        return 50;
    }
    else
    {
        return 0.01;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==2) {
        UIView *topView=[[UIView alloc ]initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
        topView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 49)];
        lab.backgroundColor=[UIColor whiteColor];
        lab.text=@"  订单详情";
        lab.font=[UIFont systemFontOfSize:12];
        [topView addSubview:lab];
        return topView;
    }
    else
    {
        return nil;
    }
}
-(void)onePress:(UIButton *)btn
{
    if ([_oneBtn.titleLabel.text isEqualToString:@"订单投诉"]) {
        
        if (IS_PAD) {
            ComplainListView *view=[[ComplainListView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
            [self. view.window addSubview:view];
        }
        else
        {
        ComplainList *list=[[ComplainList alloc]init];
        [self.navigationController pushViewController:list animated:YES];
        }}
}
-(void)twoPress:(UIButton *)btn
{
    
}
@end
