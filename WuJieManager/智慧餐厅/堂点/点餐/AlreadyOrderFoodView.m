//
//  AlreadyOrderFoodView.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/14.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "AlreadyOrderFoodView.h"
#import "AlreadyOrderFoodCell.h"
#import "GetPriceModel.h"
#import "AddShopCart.h"
#import "DelectShopCart.h"

@interface AlreadyOrderFoodView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *delectArr;//存放购物车购买的数量设置为0时的菜品 用于更新主页model
}
@property (weak, nonatomic) IBOutlet UITableView *mTable;
@property (weak, nonatomic) IBOutlet UILabel *sumPriceLab;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;




@end

@implementation AlreadyOrderFoodView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"AlreadyOrderFoodView" owner:self options:nil];
        [self addSubview:_thisView];
        
        _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mTable.dataSource=self;
        _mTable.delegate=self;
        [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([AlreadyOrderFoodCell class]) bundle:nil] forCellReuseIdentifier:@"AlreadyOrderFoodCell"];
        delectArr=[NSMutableArray array];
    
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

-(void)saveCartDataWith:(NSString *)type
{

        AddShopCart *cart=[[AddShopCart alloc]init];
        if (_uidStr==nil) {
            _uidStr=@"0";
        }
        cart.user_id=_uidStr;
        cart.menu_id=_titleId;
        cart.data=self.dataArray;
       cart.id=_cart_id;
       cart.desk_id=_desk_id;
    
        [MBProgressHUD showMessage:nil toView:self];
        [cart AddShopCartSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
            [MBProgressHUD hideAllHUDsForView:self animated:YES];
            if ([code intValue]==200) {
                
                 self.alreadyOrderFoodViewBlock(delectArr, type);
                [self removeFromSuperview];
            }
            else
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     [MBProgressHUD showSuccess:message toView:self];
                });
              
            }
            
            
        } andFailure:^(NSError * _Nonnull error) {
            [MBProgressHUD hideAllHUDsForView:self animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self];
        }];

}
- (IBAction)cancellPress:(id)sender {
 
    if ( _sureBtn.enabled==NO) {
        [MBProgressHUD showSuccess:@"正在清空，请稍后" toView:self.superview];
        return;
    }
    
    [self saveCartDataWith:@"cancell"];
 
}
- (IBAction)surePress:(id)sender {
    
    if ( _sureBtn.enabled==NO) {
        [MBProgressHUD showSuccess:@"正在清空，请稍后" toView:self.superview];
        return;
    }
    if (self.dataArray.count>0) {
     
        [self saveCartDataWith:@"ok"];
    }
    else
    {
        [MBProgressHUD showSuccess:@"菜品不能为空" toView:self.superview];

    }
   
}

-(void)setData:(NSArray *)data
{
    self.dataArray=[NSMutableArray arrayWithArray:data];
    [self getSumPricePrice];
    [_mTable reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    AlreadyOrderFoodCell *cell=[tableView dequeueReusableCellWithIdentifier:@"AlreadyOrderFoodCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dict=self.dataArray[indexPath.row];
    NSDictionary *dic=dict[@"getPrice"];
    cell.numLab.text=[NSString stringWithFormat:@"%@", dic[@"totalNum"]];

    double priceData= [dic[@"totalPrices"] doubleValue]/[dic[@"totalNum"] intValue];

     cell.price.text=[NSString stringWithFormat:@"¥%.2f", priceData];

     cell.nameLab.text=dic[@"dish_name"];

      NSString *str1=@"";
      NSString *str2=@"";

    if ([dic[@"norm_name"] length]!=0) {
        str1=dic[@"norm_name"];
    }
    if (  [dic[@"taste_name"] length]!=0) {
        str2=dic[@"taste_name"];
    }
    cell.subNameLab.text=[NSString stringWithFormat:@"%@ %@ ",str1,str2];

    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressRecognizer:)];
    longPress.minimumPressDuration = 0.5;
    [cell addGestureRecognizer:longPress];
    [cell.addBtn addTarget:self action:@selector(addPress:) forControlEvents:UIControlEventTouchUpInside];
    cell.addBtn.tag=indexPath.row;
    [cell.reduceBtn addTarget:self action:@selector(reducePress:) forControlEvents:UIControlEventTouchUpInside];
    cell.reduceBtn.tag=indexPath.row;
 
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 87;
    
}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    //删除
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [delectArr addObject:self.dataArray[indexPath.row]];
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [_mTable reloadData];
        [self getSumPricePrice];
    }];
    
    return @[deleteRowAction];
}
-(void)addPress:(UIButton *)but
{
    NSDictionary *newDic = self.dataArray [but.tag];
    
    NSMutableDictionary *newDic1=[newDic[@"getPrice"]  mutableCopy];
    
    int num=  [newDic1[@"totalNum"] intValue];
    
        num++;
        newDic1[@"totalNum"] =[NSString stringWithFormat:@"%d",num];
        
        NSMutableDictionary *dic=[NSMutableDictionary dictionary];
        [dic setValue:newDic1 forKey:@"getPrice"];
        [self.dataArray replaceObjectAtIndex:but.tag withObject:dic];
        [self getPriceFromNet:dic  AtIndex:but.tag];

}
-(void)reducePress:(UIButton *)but
{
    
    NSDictionary *newDic = self.dataArray [but.tag];
    NSMutableDictionary *newDic1=[newDic[@"getPrice"]  mutableCopy];
    
    int num=  [newDic1[@"totalNum"] intValue];
    if (num>0) {
       num--;
    }
    newDic1[@"modelNum"] =[NSString stringWithFormat:@"%d",num];

    if (num==0) {
       [delectArr addObject:self.dataArray[but.tag]];
       [self.dataArray removeObjectAtIndex:but.tag];
       [_mTable reloadData];
       [self getSumPricePrice];
 
   }
    else
    {
        newDic1[@"totalNum"] =[NSString stringWithFormat:@"%d",num];
        NSMutableDictionary *dic=[NSMutableDictionary dictionary];
        [dic setValue:newDic1 forKey:@"getPrice"];
        [self.dataArray replaceObjectAtIndex:but.tag withObject:dic];
        [self getPriceFromNet:dic  AtIndex:but.tag];
    }
   
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:@"a", @"b", @"c",nil];
    }
    return _dataArray;
}
//cell长按拖动排序
- (void)longPressRecognizer:(UILongPressGestureRecognizer *)longPress{
    //获取长按的点及cell
    CGPoint location = [longPress locationInView:self.mTable];
    NSIndexPath *indexPath = [self.mTable indexPathForRowAtPoint:location];
    UIGestureRecognizerState state = longPress.state;
    
    static UIView *snapView = nil;
    static NSIndexPath *sourceIndex = nil;
    switch (state) {
        case UIGestureRecognizerStateBegan:{
            if (indexPath) {
                sourceIndex = indexPath;
                UITableViewCell *cell = [self.mTable cellForRowAtIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                snapView = [self customViewWithTargetView:cell];
                
                __block CGPoint center = cell.center;
                snapView.center = center;
                snapView.alpha = 0.0;
                [self.mTable addSubview:snapView];
                
                [UIView animateWithDuration:0.1 animations:^{
                    center.y = location.y;
                    snapView.center = center;
                    snapView.transform = CGAffineTransformMakeScale(1.05, 1.05);
                    snapView.alpha = 0.5;
                    
                    cell.alpha = 0.0;
                }];
            }
        }
            break;
            
        case UIGestureRecognizerStateChanged:{
            CGPoint center = snapView.center;
            center.y = location.y;
            snapView.center = center;
            
            UITableViewCell *cell = [self.mTable cellForRowAtIndexPath:sourceIndex];
            cell.alpha = 0.0;
            
            if (indexPath && ![indexPath isEqual:sourceIndex]) {
                
                [self.dataArray exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndex.row];
                
                [self.mTable moveRowAtIndexPath:sourceIndex toIndexPath:indexPath];
                
                sourceIndex = indexPath;
            }
            
        }
            break;
            
        default:{
            UITableViewCell *cell = [self.mTable cellForRowAtIndexPath:sourceIndex];
            [UIView animateWithDuration:0.25 animations:^{
                snapView.center = cell.center;
                snapView.transform = CGAffineTransformIdentity;
                snapView.alpha = 0.0;
                
                cell.alpha = 1.0;
            } completion:^(BOOL finished) {
                [snapView removeFromSuperview];
                snapView = nil;
            }];
            sourceIndex = nil;
        }
            break;
    }
}
//截取选中cell
- (UIView *)customViewWithTargetView:(UIView *)target{
    UIGraphicsBeginImageContextWithOptions(target.bounds.size, NO, 0);
    [target.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;
}
-(void)getSumPricePrice
{
    double sumPrice=0;
 
    for (NSDictionary *dic in self.dataArray) {
        NSDictionary *dict=dic[@"getPrice"];
        double price= [dict[@"totalPrices"] doubleValue] ;
        sumPrice=sumPrice+price;
    }
    _sumPriceLab.text=[NSString stringWithFormat:@"合计：￥%.2f",sumPrice];
   
    
}

-(void)getPriceFromNet:(NSDictionary *)dic  AtIndex:(NSInteger)index
{
    GetPriceModel *model=[[GetPriceModel alloc]init];
    NSDictionary *dict=dic[@"getPrice"];
    model.id=[NSString stringWithFormat:@"%@",dict[@"cid"]];
    NSString *str =[NSString stringWithFormat:@"%@", dict[@"is_dish"] ];

    if ([str isEqualToString:@"1"]) {
        //单品
        if (dict[@"norm_id"]!=nil) {
            model.norm_id=[NSString stringWithFormat:@"%d",[dict[@"norm_id"]
                                                            intValue]];
        }
        if (dict[@"taste_id"] !=nil) {
             model.taste_id=[NSString stringWithFormat:@"%d",[dict[@"taste_id"]intValue]];
        }
        
        model.add=[ExChangeJson ArrToJSONString:dict[@"addData"]];
        model.type=@"1";
    }
    else
    { //套餐
         model.dish=[ExChangeJson ArrToJSONString:dict[@"dishData"]];
         model.type=@"2";
    }
    model.is_dining=@"1";
    model.num=[NSString stringWithFormat:@"%@",dict[@"totalNum"]] ;
    _sureBtn.enabled=NO;
    _sureBtn.backgroundColor=[UIColor lightGrayColor];
    [MBProgressHUD showMessage:nil toView:self];
    [model GetPriceModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        if ([code intValue]==200) {
            GetPriceModel *model=(  GetPriceModel *)data;
            if (model.data.info.all_price.length>0) {
                
                NSMutableDictionary *data=[NSMutableDictionary dictionaryWithDictionary:dict] ;
                data[@"totalPrices"]=model.data.info.all_price;
                
                NSMutableDictionary *dic1=[NSMutableDictionary dictionary];
                [dic1 setValue:data forKey:@"getPrice"];
                [self.dataArray replaceObjectAtIndex:index withObject:dic1];
                
             
                [self getSumPricePrice];
                [_mTable reloadData];
                
                _sureBtn.enabled=YES;
                _sureBtn.backgroundColor=color(255, 106, 22);
            }
        }
        else
        {
            [MBProgressHUD showSuccess:message toView:self];
        }
       
        
    } andFailure:^(NSError * _Nonnull error) {
        
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self];
    }];
    

}

- (IBAction)clearPress:(id)sender {
    if (self.dataArray.count>0) {
      
        [self clearCart];
        
    }
    else
    {
        [MBProgressHUD showSuccess:@"菜品不能为空" toView:self.superview];
        
    }
   
}
-(void)clearCart
{
    _sureBtn.enabled=NO;
    _sureBtn.backgroundColor=[UIColor lightGrayColor];
    
    if (_cart_id.length>0) {
        DelectShopCart *cart=[[DelectShopCart alloc]init];
        cart.id=_cart_id;
        [MBProgressHUD showMessage:nil toView:self];
        [cart DelectShopCartSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
              [MBProgressHUD hideAllHUDsForView:self animated:YES];
             [MBProgressHUD showSuccess:message toView:self];
            if ([code intValue]==200) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   
                    [self removeFromSuperview];
                    self.clearBlock();
                   
                });
            }
  
        } andFailure:^(NSError * _Nonnull error) {
            [MBProgressHUD hideAllHUDsForView:self animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self];
        }];
        
    }
}



@end
