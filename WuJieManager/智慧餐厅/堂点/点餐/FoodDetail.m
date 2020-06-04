//
//  FoodDetail.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/8/21.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "FoodDetail.h"
#import "OrderFoodAtterModel.h"
#import "FoodDetailTopView.h"
#import "FoodDetailWebCell.h"
#import "FoodDetailFootView.h"
#import "FoodDetailContentCell.h"
#import "OrderFoodAttributeView.h"
#import "GetShopCart.h"
#import "GetPriceModel.h"
#import "DelectShopCart.h"
#import "OrderSubFood.h"
#import "AddShopCart.h"
#import "AlreadyOrderFoodView.h"
#import "SetOrder.h"
#import "OnMeal.h"

@interface FoodDetail ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *desc;
    NSInteger wek_web_num;
    OrderFoodAtterModel *mainModel;
    NSArray *  materialArr;
    NSArray *dishList;
    NSString *num;
}
@property (strong, nonatomic) NSMutableArray *dataArray;//购物车数据
@property (strong, nonatomic) NSString *cart_id;//购物车ID

@property (weak, nonatomic) IBOutlet UITableView *mTable;
@property (nonatomic, strong) IBOutlet UILabel *selectNumLab;
@property (nonatomic, strong) IBOutlet UILabel *foodContentLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alreadyBtnWW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectNumWW;
@end

@implementation FoodDetail
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
    NSArray *arr=   self.navigationController.viewControllers;
    for (UIViewController *controll in arr) {
        if ([controll isKindOfClass:[OrderSubFood class]]) {
            [self.navigationController popToViewController:controll animated:YES];
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav ];
    wek_web_num=50;
    
    [self getData];
    [_mTable registerNib:[UINib nibWithNibName:@"FoodDetailContentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FoodDetailContentCell"];
    [_mTable registerNib:[UINib nibWithNibName:@"FoodDetailWebCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FoodDetailWebCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _foodContentLab.hidden=NO;
    
    if (IS_PAD) {
        _alreadyBtnWW.constant=ScreenW/4-20;
        _selectNumWW.constant=(ScreenW/4-20)/2-20;
    }
    else
    {
        _alreadyBtnWW.constant=100;
    }
    
    _selectNumLab.layer.cornerRadius= _selectNumLab.frame.size.width/2;
    _selectNumLab.layer.masksToBounds=YES;
    _selectNumLab.hidden=YES;
    
 
}
-(NSArray *)delectRepitData:(NSArray *)arr  andSelfDataId:( NSString *)cid is_dish:(NSString *)is_dish
{
    NSMutableArray *resultArray = [NSMutableArray arrayWithArray:arr];
    for ( OrderFoodListModel *model in arr) {
        
        if ([is_dish isEqualToString:@"0"]) {
            
            if ([model.id isEqualToString:cid] &&[model.mic_id isEqualToString:@"0"]) {
                
                [resultArray removeObject: model];
            }
        }
        
        if ([is_dish isEqualToString:@"1"])
        {
            if ([model.dishes_id isEqualToString:cid] &&(![model.mic_id isEqualToString:@"0"])) {
                
              [resultArray removeObject: model];
            }
        }
        
    }
    return resultArray;
    
}

-(void)viewDidAppear:(BOOL)animated
{
//    NSString *str=[NSString stringWithFormat:@"%@",_mic_id];
//    if ([str isEqualToString:@"0"]) {
//        _guessArr=[NSArray arrayWithArray:_guessDic[@"1"]];
//    }
//    else
//    {
//        _guessArr=[NSArray arrayWithArray:_guessDic[@"0"]];
//        
//    }
    [self getShopCartData];
}

-(void)getData
{
    OrderFoodAtterModel *model=[[OrderFoodAtterModel alloc]init];
    NSString *str=[NSString stringWithFormat:@"%@",_mic_id];
    if ([str isEqualToString:@"0"]) {
        model.id=_id;//套餐
        model.type=@"2";
    }
    else
    {
        model.id=_dishes_id;
        model.type=@"1";
        
    }
    [MBProgressHUD showMessage:nil toView:self.view];
    [model OrderFoodAtterModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            OrderFoodAtterModel *model=( OrderFoodAtterModel *)data;
            if ([str isEqualToString:@"0"]) {
                mainModel=model.data.d;
                self.title=mainModel.name;
                desc=mainModel.desc;
                dishList=[NSArray arrayWithArray:model.data.dishList];
                
                
            }
            else
            {
                mainModel=model.data.dishData;
                self.title=mainModel.name;
                desc=mainModel.desc;
                materialArr=[NSArray arrayWithArray:model.data.dishMaterial];
                
            }
            [_mTable reloadData];
        }
        else
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:message toView:self.view ];
            });
            
            
        }
        
        
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return materialArr.count+1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==materialArr.count) {
        FoodDetailWebCell *cell=[tableView dequeueReusableCellWithIdentifier:@"FoodDetailWebCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (desc.length>0) {
            [cell wk_web:desc];
        }
        
        cell.data_HTML  = ^(NSInteger num) {
            self->wek_web_num = num + 15;
            [self->_mTable reloadData];
        };
        return cell;
    }
    else
    {
        FoodDetailContentCell *cell=[tableView dequeueReusableCellWithIdentifier:@"FoodDetailContentCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        OrderFoodAtterModel *model=   materialArr[indexPath.row];
        
        cell.subTitleLab.text =  [self subTittle:model.data_one];
        cell.titleLab.text =model.name;
        
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==materialArr.count) {
        
        return wek_web_num+30;
    }
    else
    {
        OrderFoodAtterModel *model=   materialArr[indexPath.row];
        
      NSString *  str =  [self subTittle:model.data_one];
        
        CGSize titleSize = [str sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(ScreenW-55,  MAXFLOAT)];
        CGFloat height =titleSize.height+10;
        if (height<30) {
            height=30;
        }
        return height;
        
       
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NSString *str=[NSString stringWithFormat:@"%@",_mic_id];
    if (IS_PAD) {
        CGFloat weigh=(ScreenW/2-60)*2/3+30;
        if ([str isEqualToString:@"0"]) {
            weigh=(ScreenW/2-60)*2/3+135+30;
        }
        return weigh;
    }
    else
    {
        CGFloat weigh=ScreenW*2/3+135+30;
        if ([str isEqualToString:@"0"]) {
            weigh=ScreenW*2/3+120+135+30;
        }
        return weigh;
    }
   
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSString *str=[NSString stringWithFormat:@"%@",_mic_id];
    CGFloat weigh=0;
    if (IS_PAD) {
        CGFloat weigh=(ScreenW/2-60)*2/3+30;
        if ([str isEqualToString:@"0"]) {
            weigh=(ScreenW/2-60)*2/3+135+30;
        }
    }
    else
    {
        weigh=ScreenW*2/3+135+30;
        if ([str isEqualToString:@"0"]) {
           weigh=ScreenW*2/3+120+135+30;
        }
       
    }
    
    FoodDetailTopView   *topView=[[FoodDetailTopView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, weigh)];
    [topView.headImaView sd_setImageWithURL:[NSURL URLWithString:mainModel.picture_path] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    
    topView.goods_nameLab.text=mainModel.name;
    topView.priceLab.text=[NSString stringWithFormat:@"￥%@起",mainModel.canteen_price];
    
    if (IS_PAD) {
        topView.headImaViewWW.constant=ScreenW/2-60;
        topView.contentViewTop.constant=10;
        topView.contentViewX.constant=ScreenW/2-60;
        topView.contentViewHH.constant=(ScreenW/2-60)*2/3+10;
    }
    else
    {
        topView.headImaViewWW.constant=ScreenW;
        topView.contentViewTop.constant=ScreenW*2/3+10;
        topView.contentViewX.constant=0;
        topView.contentViewHH.constant=120;
    }
    [topView.addBtn addTarget:self action:@selector(addPress) forControlEvents:UIControlEventTouchUpInside];
    
    [topView.reduceBtn addTarget:self action:@selector(reducePress) forControlEvents:UIControlEventTouchUpInside];
    if ([num intValue]>0) {
        topView.reduceBtn.hidden=NO;
        topView.numLab.hidden=NO;
        topView.numLab.text=num;
    }
    else
    {
        topView.reduceBtn.hidden=YES;
        topView.numLab.hidden=YES;
        
    }
    
    if ([str isEqualToString:@"0"]) {
        [topView loadCollectonView:dishList WithType:@"1"];
        topView.selectTopViewBlock = ^(OrderFoodAtterModel * _Nonnull model) {
            FoodDetail *detail=[[FoodDetail alloc]init];
            detail.id=@"";
            detail.dishes_id=model.dish_id;
            detail.mic_id=@"5";
            detail.guessAllArr=_guessAllArr;
            detail.menu_id=_menu_id;
            detail.uid=_uid;
            detail.desk_id=_desk_id;
            detail.guessArr= [self delectRepitData:_guessAllArr andSelfDataId:model.dish_id is_dish:@"1"];;
            
            [self.navigationController pushViewController:detail animated:YES];
        };
    }
    else
    {
        topView.backView.hidden=YES;
        topView.backViewHHH.constant=0;
    }
    return topView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (_guessArr.count>0) {
        if (IS_PAD) {
             return 250;
        }
        else
        {
            if (_guessArr.count<=2) {
                 return 250;
            }
           
        }
        return 450;
    }
    else
    {
        return 0.01;
    }
 
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (_guessArr.count>0) {
        CGFloat height=450;
        if (IS_PAD) {
            height= 250;
        }
        else
        {
            if (_guessArr.count<=2) {
                height=250;
            }
        }
    FoodDetailFootView *footView=[[FoodDetailFootView alloc]initWithFrame:CGRectMake(0, 0, ScreenW,  height)];
    
    [footView loadCollectonView:_guessArr];
    footView.selectFootViewBlock = ^(OrderFoodListModel * _Nonnull model) {
        FoodDetail *detail=[[FoodDetail alloc]init];
        detail.id=model.id;
        detail.dishes_id=model.dishes_id;//单品id
        detail.mic_id=model.mic_id;
        detail.guessAllArr=_guessAllArr;
        detail.menu_id=_menu_id;
        detail.uid=_uid;
        detail.desk_id=_desk_id;
        
        NSString *str1=[NSString stringWithFormat:@"%@",model.mic_id];
        if ([str1 isEqualToString:@"0"]) {
            detail.guessArr= [self delectRepitData:_guessAllArr andSelfDataId:model.id is_dish:@"0"];
        }
        else
        {
            detail.guessArr= [self delectRepitData:_guessAllArr andSelfDataId:model.dishes_id is_dish:@"1"];
        }
        
        
        [self.navigationController pushViewController:detail animated:YES];
        
    };
    return footView;
        
    }
    else
    {
        return nil;
    }
    
}
//材料内容
-(NSString *)subTittle: (NSArray *)data
{
    NSMutableString *str=[[NSMutableString alloc]init];
    
    for ( OrderFoodAtterModel *model in data) {
        [str appendString:model.name];
        [str appendString:@" "];
        NSArray *arr= model.data_two;
        
        for (OrderFoodAtterModel *subModel in arr) {
            [str appendString:subModel.norms_label];
            [str appendString:@" "];
            [str appendString:[NSString stringWithFormat:@"%@%@",subModel.num,model.unit_name]];
            [str appendString:@" "];
        }
        
        [str appendString:@"\n"];
    }
    
    
    return str;
}
-(void)addPress
{
    OrderFoodAttributeView *view =[[OrderFoodAttributeView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    view.id=_id;//套餐ID
    view.dishes_id=_dishes_id;//单品id
    view.mic_id=_mic_id;
    
    view.menu_id=_menu_id;
    view.uid=_uid;
    
    
    view.dataArray=_dataArray;
    view.dataDic=_dataDic;
    
    view.cart_id=_cart_id;
    
    view.desk_id=_desk_id;
    [view loadOrderFoodAttributeView];
    
    
    view.orderFoodAttributeViewBlock = ^(NSInteger numStr) {
        [self getShopCartData];
    };
    [self.view.window addSubview:view];
    
}

-(void)reducePress
{
    
    NSMutableDictionary *newDic1=[_dataDic  mutableCopy];
    
    int numStr=  [newDic1[@"totalNum"] intValue];
    if (numStr>0) {
        numStr--;
    }
    num=[NSString stringWithFormat:@"%d",numStr];
    newDic1[@"totalNum"] =[NSString stringWithFormat:@"%d",numStr];
    
    _dataDic=[NSDictionary dictionaryWithDictionary:newDic1];
    if (numStr==0) {
        
        [self replaceOrDeleteDataArray:@"delete"];
        
        [_mTable reloadData];
        [self getSumPrice];
        
    }
    else
    {
        [self getPriceFromNet];
    }
    
}
-(void)getShopCartData
{
    GetShopCart *cart=[[GetShopCart alloc]init];
    cart.menu_id=_menu_id;
    if (_uid==nil) {
        _uid=@"0";
    }
    cart.user_id=_uid;
    cart.desk_id=_desk_id;
    [MBProgressHUD showMessage:nil toView:self.view];
    [cart GetShopCartModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            GetShopCart *cart=(  GetShopCart *)data;
            _cart_id= cart.data.id ;
            _dataArray=[NSMutableArray arrayWithArray:cart.data.cart_list];
            
            NSString *str=[NSString stringWithFormat:@"%@",_mic_id];
            
            if ([str isEqualToString:@"0"]) {
                _dataDic=[self attributeViewInfo:_dataArray cid:_id is_dish:@"0"];
            }
            else
            {
                _dataDic=[self attributeViewInfo:_dataArray cid:_dishes_id is_dish:@"1"];
            }
            if (_dataDic!=nil) {
                num=[NSString stringWithFormat:@"%@",_dataDic[@"totalNum"]];
            }
            else
            {
                num=@"0";
            }
            [_mTable reloadData];
            [self getSumPrice];
            
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
-(NSDictionary *)attributeViewInfo:(NSArray *)arr cid:(NSString *)cid  is_dish:(NSString *) is_dish
{
    for (NSDictionary *dic in arr) {
        NSDictionary *dict=   dic[@"getPrice"];
        NSString *str1=[NSString stringWithFormat:@"%@",dict[@"cid"]];
        NSString *str2=[NSString stringWithFormat:@"%@",dict[@"is_dish"]];
        if([str1 isEqualToString:cid] &&[str2 isEqualToString:is_dish] )
        {
            return dict;
        }
    }
    return nil;
}
-(void)getSumPrice
{
    double sumPrice=0;
    NSInteger sumNum=0;
    for (NSDictionary *dic in _dataArray) {
        
        NSDictionary *data=dic[@"getPrice"];
        double price=  [data[@"totalPrices"] doubleValue];
        sumPrice=sumPrice+price;
        sumNum=sumNum + [data[@"totalNum"] intValue];
    }
    
    NSString *sumPriceStr=[NSString stringWithFormat:@"%.2f",
                           sumPrice];
    NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"总金额￥%@",sumPriceStr]];
    
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3,sumPriceStr.length+1)];
    
    _foodContentLab.attributedText=AttributedStr;
    
    if (sumNum >0 ) {
        _selectNumLab.hidden=NO;
        if (sumNum<100) {
             _selectNumLab.text=[NSString stringWithFormat:@"%ld",sumNum];
        }
        else
        {
            _selectNumLab.text=@"...";
        }
      
    }
    else
    {
        _selectNumLab.hidden=YES;
        
    }
   
}

-(void)getPriceFromNet
{
    GetPriceModel *model=[[GetPriceModel alloc]init];
    NSDictionary *dict=_dataDic;
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
    
    [MBProgressHUD showMessage:nil toView:self.view];
    [model GetPriceModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            GetPriceModel *model=(  GetPriceModel *)data;
            if (model.data.info.all_price.length>0) {
                
                NSMutableDictionary *data=[NSMutableDictionary dictionaryWithDictionary:dict] ;
                data[@"totalPrices"]=model.data.info.all_price;
                
                _dataDic=[NSDictionary dictionaryWithDictionary:data];
                [self replaceOrDeleteDataArray:@"replace"];
                
                [self getSumPrice];
                [_mTable reloadData];
                
                
            }
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
-(void)replaceOrDeleteDataArray:(NSString *)type
{
    
    NSString *cid=[NSString stringWithFormat:@"%@",_dataDic[@"cid"]]  ;
    NSString *is_dish=[NSString stringWithFormat:@"%@",_dataDic[@"is_dish"]]  ;
    
    for (int i=0 ;i<self.dataArray.count;i++) {
        NSDictionary *dic=self.dataArray[i];
        NSDictionary *dict=dic[@"getPrice"];
        NSString *cid1=[NSString stringWithFormat:@"%@",dict[@"cid"]]  ;
        NSString *is_dish1=[NSString stringWithFormat:@"%@",dict[@"is_dish"]]  ;
        
        if ([cid isEqualToString:cid1]&&[is_dish isEqualToString:is_dish1]) {
            NSDictionary *prama=@{@"getPrice":_dataDic};
            if ([type isEqualToString:@"replace"]) {
                [self.dataArray replaceObjectAtIndex:i withObject:prama];
                break;
            }
            else
            {
                [self.dataArray removeObjectAtIndex:i];
                _dataDic=nil;
                break;
            }
        }
    }
    [self saveCartData];
    
}
-(void)saveCartData
{
    
    AddShopCart *cart=[[AddShopCart alloc]init];
    if (_uid==nil) {
        _uid=@"0";
    }
    cart.user_id=_uid;
    cart.menu_id=_menu_id;
    cart.data=self.dataArray;
    cart.id=_cart_id;
    cart.desk_id=_desk_id;
    [MBProgressHUD showMessage:nil toView:self.view];
    [cart AddShopCartSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
    
}
#pragma mark-------------- 已点菜品
-(IBAction)alreadyPress:(id)sender
{
    AlreadyOrderFoodView *view ;
    NSArray *arr=[NSArray arrayWithArray:self.dataArray];
    if (IS_PAD) {
        view =[[AlreadyOrderFoodView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        view.viewWW.constant=(ScreenW-100)/2;
        view.tableViewHH.constant=ScreenH-44-140-20;
        view.backgroundColor=[UIColor clearColor];
        UIColor *color = [UIColor blackColor];
        view.thisView.backgroundColor = [color colorWithAlphaComponent:0];
        
        
    }
    else
    {
        view =[[AlreadyOrderFoodView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        view.viewWW.constant=ScreenW;
        
        view.tableViewHH.constant=ScreenH/2-184;
        
    }
    
    view.data=[NSArray arrayWithArray:arr];
    
    view.titleId=_menu_id;
    
    view.cart_id=_cart_id;
    view.uidStr=_uid;
    
    view.desk_id=_desk_id;
    view.alreadyOrderFoodViewBlock = ^(NSArray *  data, NSString * _Nonnull type) {
        
        if ([type isEqualToString:@"ok"]) {
            [self setOrder];
        }
        
        [self getShopCartData];
    };
    view.clearBlock = ^{
        NSArray *arr=   self.navigationController.viewControllers;
        for (UIViewController *controll in arr) {
            if ([controll isKindOfClass:[OrderSubFood class]]) {
                [self.navigationController popToViewController:controll animated:YES];
            }
        }
    };
    
    
    [self.view.window addSubview:view];
    
}
-(void)setOrder
{
    SetOrder *order=[[SetOrder alloc]init];
    
    order.id=_cart_id;
    order.desk_id=_desk_id;
    order.source=@"3";
    //order.server_id=[[LoginModel shareInstance] getUserInfo].user_info.uid;
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [order SetOrderSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if ([code intValue]==200) {
            
            SetOrder *order=(SetOrder *)data;
            OnMeal *onmeal=[[OnMeal alloc]init];
            onmeal.order_sn=order.data.order_sn;
            [self.navigationController pushViewController:onmeal animated:YES];
            
            return ;
            
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

- (IBAction)setOrderPress:(id)sender {
    
    if (self.dataArray.count==0) {
        [MBProgressHUD showSuccess:@"菜品不能为空" toView:self.view];
    }
    else
    {
        [self setOrder];
    }
    
}

@end
