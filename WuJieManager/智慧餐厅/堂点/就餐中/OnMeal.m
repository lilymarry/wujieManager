//
//  OnMeal.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/7.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "OnMeal.h"
#import "OnMealCell.h"
#import "OnMealTopCell.h"
#import "WorkFirstTopViewCell.h"
#import "CombineTable.h"
#import "SelectTable.h"
#import "SendFood.h"
#import "OnMealContentCell.h"
#import "ReturnFood.h"
#import "OnMealPadCell.h"
#import "OnMealTopPadCell.h"
#import "OrderInfo.h"

#import "OrderFoodSet.h"

#import "OrderSubFood.h"
#import "Pay.h"
#import "UserCenter.h"
#import "OrderPrint.h"
#import "OnMealUserCell.h"
#import "GetDeskById.h"
@interface OnMeal ()<UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSArray *titleArr;
    NSMutableArray *leftArr;
    CombineTable *table;
    

    NSArray *foodData_arr;//菜品详情
    NSMutableArray *infoData_arr;//订单详情
    
    NSString *desk_id;
    NSArray *addFood_arr;//加菜详情
    
    OrderInfo *userInfo;//用户信息
    OrderInfo *serverInfo;//服务员信息
    
  //  NSString *balance;//无界优品余额
    NSString *uidStr;
    NSString *user_name;
   
    NSString *pay_way;
    NSString *pay_status;
   // pay_way  结账方式：堂食：1先用餐后结账、2先结账后用餐；外卖：1先支付后接单、2收到菜品在支付、3支付定金接单收到菜品付尾款
    
   // order_type订单类型：1堂食、2外卖
    
    NSString *typeStr;  //订单状态

    
}
@property (weak, nonatomic) IBOutlet UITableView *mTable;
@property (weak, nonatomic) IBOutlet UICollectionView *mCollect;
@property (strong, nonatomic)IBOutlet NSLayoutConstraint *mCollectHHH;
@property (strong, nonatomic) IBOutlet UIButton *btn1;
@property (strong, nonatomic) IBOutlet UIButton *btn2;

@property (weak, nonatomic) IBOutlet UILabel *order_priceLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btn1WWW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btn2WWW;

@end

@implementation OnMeal

- (void)viewDidLoad {
    [super viewDidLoad];
    adjustsScrollViewInsets_NO(_mTable, self);
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([OnMealCell class]) bundle:nil] forCellReuseIdentifier:@"OnMealCell"];
     [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([OnMealTopCell class]) bundle:nil] forCellReuseIdentifier:@"OnMealTopCell"];
     [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([OnMealContentCell class]) bundle:nil] forCellReuseIdentifier:@"OnMealContentCell"];
    
    [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([OnMealTopPadCell class]) bundle:nil] forCellReuseIdentifier:@"OnMealTopPadCell"];
    [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([OnMealPadCell class]) bundle:nil] forCellReuseIdentifier:@"OnMealPadCell"];
    
    [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([OnMealUserCell class]) bundle:nil] forCellReuseIdentifier:@"OnMealUserCell"];
    
    
    
     [_mCollect registerNib:[UINib nibWithNibName:NSStringFromClass([WorkFirstTopViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"WorkFirstTopViewCell"];
    
  
    [self createNav];
    titleArr=@[@" 用户详情",@" 菜品详情",@" 加菜详情",@" 订单详情"];
   // leftArr=@[@"加菜",@"退菜",@"折扣",@"启菜",@"催菜",@"送菜",@"并台",@"换台"];
    leftArr=[NSMutableArray arrayWithObjects:@"加菜", nil];
    


    _mCollectHHH.constant=60;
    _mCollect.hidden=NO;
   
    [self getData];
  
    self.title=@"订单详情";
}


- (void)createNav {
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"白色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -20, 0, 0);
    
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getDeskData
{
    GetDeskById *desk=[[GetDeskById alloc]init];
    desk.desk_id=desk_id;
    [MBProgressHUD showMessage:nil toView:self.view];
    [desk GetDeskByIdSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            GetDeskById *desk=(  GetDeskById *)data;
            uidStr=desk.data.uid;
        }
        else
        {
            [MBProgressHUD showSuccess:message toView:self.view];

        }
      
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
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
            userInfo =list.data.user_info;
            user_name=list.data.user_name;
            serverInfo=list.data.server_info;
            foodData_arr=[NSArray arrayWithArray:list.data.dish];
            
            addFood_arr=[NSArray arrayWithArray:list.data.dish_add];
            pay_way=list.data.pay_way;
            pay_status=list.data.pay_status;
            
         
            
            if (([list.data.status_name isEqualToString:@"待确认"]&&[pay_status intValue]==0)||[list.data.status_name isEqualToString:@"未付款"]) {
               NSString *  payPrice=[NSString stringWithFormat:@"%.2f",[list.data.total_price doubleValue]];
                NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"待付金额:￥%@",payPrice]];
                [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5,payPrice.length+1)];
                
                _order_priceLab.attributedText=AttributedStr;
            }
            
          
            desk_id=list.data.desk_id;
            [self getDeskData];
            
            infoData_arr=[NSMutableArray array];
            
            if (list.data.order_sn.length>0) {
                NSDictionary *dic=@{
                                    @"name"   :@"订单编号",
                                    @"content"  :list.data.order_sn
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
                                    @"content"  :[NSString stringWithFormat:@"%@-%@",list.data.desk.area_name,list.data.desk.name]
                                    };
                [infoData_arr addObject:dic];
            }
            if (list.data.source_name.length>0) {
                NSDictionary *dic=@{
                                    @"name"   :@"下单来源",
                                    @"content"  :[NSString stringWithFormat:@"%@",list.data.source_name]
                                    };
                [infoData_arr addObject:dic];
            }
            if (list.data.status_name.length>0) {
                NSDictionary *dic=@{
                                    @"name"   :@"订单状态",
                                    @"content"  :list.data.status_name
                                    };
                [infoData_arr addObject:dic];
            }
            
            if (list.data.created_at.length>0) {
                NSDictionary *dic=@{
                                    @"name"   :@"下单时间",
                                    @"content"  :list.data.created_at
                                    };
                [infoData_arr addObject:dic];
            }
            if ([list.data.order_type intValue]==1) {
                NSDictionary *dic=@{
                                    @"name"   :@"订单类型",
                                    @"content"  :@"堂食"
                                    };
                [infoData_arr addObject:dic];
            }
            if ([list.data.order_type intValue]==2)
            {
                NSDictionary *dic=@{
                                    @"name"   :@"订单类型",
                                    @"content"  :@"外卖"
                                    };
                [infoData_arr addObject:dic];
            }
            
            if (list.data.total_price.length>0) {
                NSDictionary *dic=@{
                                    @"name"   :@"订单合计",
                                    @"content"  :[NSString stringWithFormat:@"¥%.2f",[list.data.all_price doubleValue]]
                                    };
                [infoData_arr addObject:dic];
            }
       
            if ([list.data.pay_price doubleValue]>0) {
                NSDictionary *dic=@{
                                    @"name"   :@"实收金额",
                                    @"content"  :[NSString stringWithFormat:@"¥%.2f",[list.data.pay_price doubleValue]]
                                    };
                [infoData_arr addObject:dic];
            }

            [_mTable reloadData];
            
          
            typeStr=list.data.status_name;
            if ([typeStr isEqualToString:@"待确认"]) {
                [_btn1 setTitle:@"确认提交" forState:UIControlStateNormal];
                if (![leftArr containsObject:@"退菜"]) {
                     [leftArr addObject:@"退菜"];
                }
               
                _btn2.hidden=YES;
                _btn2WWW.constant=0;
                if (IS_PAD) {
                    _btn1WWW.constant=200;
                }
                [_mCollect reloadData];
                
            }
            if ([typeStr isEqualToString:@"未付款"]) {
                [_btn1 setTitle:@"结账" forState:UIControlStateNormal];
                if (IS_PAD) {
                    _btn1WWW.constant=200;
                    _btn2WWW.constant=200;
                }
                
            }
            if ([typeStr isEqualToString:@"已付款"]) {
                _btn1.hidden=YES;
                _btn1WWW.constant=0;
                if (IS_PAD) {
                    _btn2WWW.constant=200;
                }
                
            }
            
        }
        else
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:message toView:self.view];
            });        }
       
        
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
#pragma  mark tableView 代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
         return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if( section==0) {
        return 1;
    }
    else if (section==1)
    {
        if (foodData_arr.count>0) {
             return foodData_arr.count+1;
        }
        return foodData_arr.count;
        
    }
    else if (section==2)
    {
        if (addFood_arr.count>0) {
            return addFood_arr.count+1;
        }
        return addFood_arr.count;
        
    }
    else
    {
      return infoData_arr.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 10;
    }
    else
    {
         if (section==1)
        {
            if (foodData_arr.count>0) {
                return 35;
            }
        }
        else if (section==2)
        {
            if (addFood_arr.count>0) {
                return 35;
            }
        }
        else
        {
            if (infoData_arr.count>0) {
                return 35;
            }
        }
    }
    return 0;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
   if (section!=0) {
        if (section==1)
        {
            if (foodData_arr.count>0) {
               
                UIView * topView= [self headViewWithTittle:titleArr[section]];
                return topView;
            }


        }
        else if (section==2)
        {
            if (addFood_arr.count>0) {
                UIView * topView= [self headViewWithTittle:titleArr[section]];
                return topView;
            }


        }
        else
        {
            if (infoData_arr.count>0) {
                UIView * topView= [self headViewWithTittle:titleArr[section]];
                return topView;
            }

        }
        
    }
    else
    {
        UIView * topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        topView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        
        return topView;
    }
    return nil;
    
    
}
-(UIView *)headViewWithTittle:(NSString *)title
{
    UIView * topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 35)];
    topView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 35)];
    lab.text=title;
    lab.backgroundColor=[UIColor clearColor];
    lab.textColor=[UIColor darkGrayColor];
    [lab setFont:[UIFont systemFontOfSize:12]];
    [topView addSubview:lab];
    return topView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
     
        if (IS_PAD) {
            OnMealTopPadCell*cell=[tableView dequeueReusableCellWithIdentifier:@"OnMealTopPadCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.headImaView sd_setImageWithURL:[NSURL URLWithString:serverInfo.head_icon] placeholderImage:[UIImage imageNamed:@"默认龙纹图标"]]
            ;
            cell.nameLab.text=serverInfo.nickname;
            cell.numLab.text=typeStr;
            return cell;
        }
        OnMealTopCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OnMealTopCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.headImaView sd_setImageWithURL:[NSURL URLWithString:serverInfo.head_icon] placeholderImage:[UIImage imageNamed:@"默认龙纹图标"]]
        ;
        cell.nameLab.text=serverInfo.nickname;
         cell.stateLab.text=typeStr;
        
        if ([typeStr isEqualToString:@"待确认"]) {
            cell.hidden=YES;
        }
        else
        {
            cell.hidden=NO;
        }
        return cell;
    }
    else if(indexPath.section==1||indexPath.section==2){
        
        if (indexPath.row==0) {
            OnMealUserCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OnMealUserCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.headImag sd_setImageWithURL:[NSURL URLWithString:userInfo.head_icon] placeholderImage:[UIImage imageNamed:@"默认龙纹图标"]];
         
            cell.nameLab.text=[NSString stringWithFormat:@"%@ 钦点菜品",user_name];
           
            return cell;
        }
        OrderInfo *list;
        if(indexPath.section==1)
        {
             list=foodData_arr[indexPath.row-1];
        }
        else
        {
            list=addFood_arr[indexPath.row-1];
        }
        
        if (IS_PAD) {
            OnMealPadCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OnMealPadCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
          
            NSString *str=[NSString stringWithFormat:@"%@   x%@ ¥%@",list.dish_name,list.dish_num,[NSString stringWithFormat:@"%.2f",[list.all_price doubleValue]]] ;
            if ([list.status intValue]==1) {
                cell.nameLab.attributedText = [self setStrLine:str];
            }
            else
            {
                cell.nameLab.text=str ;
            }
            
            NSString *str1=list.norms_name;
            NSString *str2=list.taste_name;
            if (str1.length==0) {
                str1=@"";
            }
            if (str2.length==0) {
                str2=@"";
            }
            NSString *string1=[NSString stringWithFormat:@"%@ %@ ",str1,str2];
            if ([list.status intValue]==1) {
                cell.specsLab.attributedText = [self setStrLine:string1];
            }
            else
            {
                cell.specsLab.text=string1;
            }
            return cell;
        }
        OnMealCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OnMealCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
  
        if ([list.status intValue]==1) {
            cell.nameLab.attributedText = [self setStrLine:list.dish_name];
         }
        else
        {
            cell.nameLab.text=list.dish_name;
        }
       
        
        NSString *string=[NSString stringWithFormat:@"x%@  ¥%@", list.dish_num,[NSString stringWithFormat:@"%.2f",[list.all_price doubleValue]]];
        
        if ([list.status intValue]==1) {
            cell.numLab.attributedText = [self setStrLine:string];
        }
        else
        {
            cell.numLab.text=string;
        }
        
        NSString *str1=list.norms_name;
        NSString *str2=list.taste_name;
        if (str1.length==0) {
            str1=@"";
        }
        if (str2.length==0) {
            str2=@"";
        }
        
        NSString *string1=[NSString stringWithFormat:@"%@ %@ ",str1,str2];
        if ([list.status intValue]==1) {
            cell.specsLab.attributedText = [self setStrLine:string1];
        }
        else
        {
            cell.specsLab.text=string1;
        }
    
        return cell;
        
       
    }
    else
    {
        OnMealContentCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OnMealContentCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *title=infoData_arr[indexPath.row][@"name"];
        NSString *subTitle=infoData_arr[indexPath.row][@"content"];
        
        if ( [title isEqualToString:@"订单状态"]|| [title isEqualToString:@"实收金额"]) {
            
            NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@: %@",title,subTitle]];
            [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(title.length+2,subTitle.length)];
             cell.nameLab.attributedText=AttributedStr;
          
        }
        else
        {
             cell.nameLab.text= [NSString stringWithFormat:@"%@: %@",title,subTitle];
        }
        return cell;
    }
    
   
    
}
-(NSAttributedString *)setStrLine:(NSString *)str
{
    NSAttributedString *attrStr =
    [[NSAttributedString alloc]initWithString:str
                                   attributes:
     @{
       NSForegroundColorAttributeName:[UIColor blackColor],
       NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
       NSStrikethroughColorAttributeName:[UIColor blackColor]}];
    return attrStr;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==3)
    {
        return UITableViewAutomaticDimension;
    }
    else
    { if (indexPath.section==1||indexPath.section==2)
      {
          if(indexPath.row==0)
         return 50;
      }
       else if (indexPath.section==0)
       {
           if ([typeStr isEqualToString:@"待确认"]) {
               return 0;
           }
       }
        return 85;
    }
    
}
#pragma  mark collection 代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return leftArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WorkFirstTopViewCell * commonCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WorkFirstTopViewCell" forIndexPath:indexPath];
    commonCell.logo.image=[UIImage imageNamed:leftArr[indexPath.row]];
    commonCell.subTitleLab.text=leftArr[indexPath.row];
    return commonCell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(40,90);
    
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(3, 6, 3, 6);
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
#pragma  mark 加菜
    if (indexPath.row==0) {
        OrderSubFood *send=[[OrderSubFood alloc]init];
        send.desk_id=desk_id;
        send.uidStr=uidStr;
        [self.navigationController pushViewController:send animated:YES];
    }
#pragma  mark 退菜
    if (indexPath.row==1) {
        ReturnFood *send=[[ReturnFood alloc]init];
        send.order_sn=_order_sn;
        
        send.returnFoodBlock = ^{
            [self getData];
        };
        [self.navigationController pushViewController:send animated:YES];
    }
    
#pragma  mark 启菜
    if (indexPath.row==3) {
//        OrderFoodSet * set =[[OrderFoodSet alloc]init];
//        set.type=@"1";
//        NSMutableArray *arr=[NSMutableArray array];
//        for ( OrderInfo *list in foodData_arr) {
//            NSMutableDictionary *dic=[NSMutableDictionary dictionary];
//            [ dic setValue:list.id forKey:@"id"];
//            [dic setValue:@"0" forKey:@"rev_time"];
//            [arr addObject:dic];
//        }
//
//        set.dish=arr;
//
//        [set OrderFoodSetSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
//
//
//        } andFailure:^(NSError * _Nonnull error) {
//
//        }];
    }
#pragma  mark 催菜
    if (indexPath.row==4) {
  
    }
#pragma mark 送菜
  else   if (indexPath.row==5) {
         SendFood *send=[[SendFood alloc]init];
         [self.navigationController pushViewController:send animated:YES];
     }
    else if (indexPath.row==6||indexPath.row==7) {
        
#pragma mark 并台、换台
    table=[[CombineTable alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    if (indexPath.row==6) {
        [table.combineBtn setTitle:@"并台" forState:UIControlStateNormal];
        table.subTittle.text=@"设置食客选择并桌的桌号";
      
    }
    else  if (indexPath.row==7)
    {
        [table.combineBtn setTitle:@"换台" forState:UIControlStateNormal];
         table.subTittle.text=@"更换食客选择的桌号";
    }
    [table.selectTableBtn addTarget:self action:@selector(selectTable) forControlEvents:UIControlEventTouchUpInside];
    [self.view.window addSubview:table];
    }
}
-(void)selectTable
{
    SelectTable  *to=[[SelectTable alloc]initWithBlock:^(NSString *names)
                               {
                                   table.hidden=NO;
                                   table.tableNumLab.text=names;
                               }];
    table.hidden=YES;
    [self.navigationController pushViewController:to animated:YES];
}
- (IBAction)btn1Press:(id)sender {
    UIButton *btn=(UIButton *)sender;
    if ([btn.titleLabel.text isEqualToString:@"确认提交"]) {
        
        if ([pay_way intValue]==2&&[pay_status intValue]==0) {
            [MBProgressHUD showSuccess:@"此订单需要先付款" toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                Pay *pay=[[Pay alloc]init];
                pay.order_sn=_order_sn;
                [self.navigationController pushViewController:pay animated:YES];
            });

        }

        else
        {
       
        OrderFoodSet * set =[[OrderFoodSet alloc]init];
        set.type=@"5";
        set.server_id=[[LoginModel shareInstance] getUserInfo].user_info.uid;
        set.order_id=_order_sn;
         [MBProgressHUD showMessage:nil toView:self.view];
        [set OrderFoodSetSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
               [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if ([code intValue]==200) {
                [self printWithType:@"2"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
               
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
        
    }
    
     if ([btn.titleLabel.text isEqualToString:@"结账"]) {
         Pay *pay=[[Pay alloc]init];
         pay.order_sn=_order_sn;
         [self.navigationController pushViewController:pay animated:YES];
     }
}
- (IBAction)printPress:(id)sender {
    
    [self printWithType:@"1"];
    
}
-(void)printWithType:(NSString *)type
{
    OrderPrint *print=[[OrderPrint alloc]init];
    print.order_sn=_order_sn;
    print.merchant_id=[[LoginModel shareInstance] getUserInfo].user_info.merchant_id;
    if ([type isEqualToString:@"1"]) {
          print.only_front=@"1";
    }
  
    [_btn2 setBackgroundColor:[UIColor lightGrayColor]];
    _btn2.enabled=NO ;
    [print OrderPrintSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [_btn2 setBackgroundColor:color(251, 151, 9)];
        _btn2.enabled=YES ;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD showSuccess:message toView:self.view];
            
        });
        
    } andFailure:^(NSError * _Nonnull error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}

@end
