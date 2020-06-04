//
//  OrderSubFood.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/27.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "OrderSubFood.h"
#import "HDClassifyTableViewDatasource.h"
#import "HDClassifyLeftTableViewModel.h"
#import "HDClassifyRightTableViewModel.h"
#import "UIView+LayoutMethods.h"
#import "AlreadyOrderFoodView.h"
#import "OrderFoodMoneyView.h"
#import "OrderFoodAttributeView.h"
#import "OrderFoodListModel.h"
#import "TitleListView.h"
#import "GetShopCart.h"
#import "OnMeal.h"
#import "SetOrder.h"
#import "Pay.h"
#import "FoodDetail.h"

@interface OrderSubFood ()<HDClassifyLeftTableViewModelDelegate,HDClassifyRightTableViewModelDelegate>
{
    NSInteger _selectIndex;
    BOOL _isScrollDown;
    // UIButton *  titleBtn ;
    
    NSArray *menuListArr;//菜单数据
    
    NSMutableArray *selectArr;//选中的数据
    
    //  BOOL isShow;
    
    NSString *titleIdStr;
    
    
    NSMutableDictionary *mainDic;
    
    NSArray *delectArr;
    
    NSString *take_pay; //;1;先用餐 后结账
    
    NSArray *guessLike;
    
}
@property (nonatomic, strong) HDClassifyLeftTableViewModel *leftTableViewModel;
@property (nonatomic, strong) HDClassifyRightTableViewModel *rightTableViewModel;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) IBOutlet UILabel *priceContentLab;
@property (nonatomic, strong) IBOutlet UIButton *moneyBtn;
@property (nonatomic, strong) IBOutlet UILabel *selectNumLab;
@property (nonatomic, strong) IBOutlet UILabel *foodContentLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alreadyBtnWW;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectNumWW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moneyBtnWW;
@property (strong, nonatomic) TitleListView *titleListView;

@property (nonatomic, strong)  UIButton *titleBtn;
@end

@implementation OrderSubFood

#pragma mark-------------- Nav
- (void)createNav {
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"白色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -20, 0, 0);
    
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _titleBtn.frame = CGRectMake(80, 0, ScreenW-160, 50);
    [_titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_titleBtn setTitle:@"未命名" forState:UIControlStateNormal];
    [_titleBtn setImage:[UIImage imageNamed:@"白色下箭头"] forState:UIControlStateNormal];
    [_titleBtn setImage:[UIImage imageNamed:@"白色上箭头"] forState:UIControlStateSelected];
    _titleBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [_titleBtn addTarget:self action:@selector(titleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _titleBtn.selected=NO;
    
    self.navigationItem.titleView = _titleBtn;
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)titleBtnClick
{
    _titleListView=[[TitleListView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    
    __weak __typeof(self) weakSelf = self;
    _titleListView.titleListViewBlock = ^(NSString * _Nonnull title,NSString *modelid) {
        
        weakSelf.titleBtn.selected=NO;
        titleIdStr=modelid ;
        [weakSelf getData];
        
        
    };
    
    _titleListView.cansellListViewBlock = ^{
        weakSelf.titleBtn.selected=NO;
    };
    [_titleListView reloadTabView:menuListArr];
    _titleBtn.selected=YES;
    [self.view.window addSubview:_titleListView];
    
}
#pragma mark-------------- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self createNav];
    
    _priceContentLab.hidden=NO;
    _moneyBtn.hidden=YES;
    selectArr=[NSMutableArray array];
    
    
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
-(void)viewDidAppear:(BOOL)animated
{
    [self getData];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_titleListView removeFromSuperview];
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.leftTableViewModel.tableView topInContainer:0 shouldResize:NO];
    [self.leftTableViewModel.tableView setCt_width:99];
    [self.leftTableViewModel.tableView leftInContainer:0 shouldResize:NO];
    [self.leftTableViewModel.tableView bottomInContainer:50 shouldResize:YES];
    
    [self.rightTableViewModel.tableView fill];
    [self.rightTableViewModel.tableView topEqualToView:self.leftTableViewModel.tableView];
    [self.rightTableViewModel.tableView leftInContainer:99 shouldResize:YES];
    [self.rightTableViewModel.tableView bottomInContainer:50 shouldResize:YES];
}

#pragma mark-------------- getData
-(void)getData
{
   
    OrderFoodListModel *model=[[OrderFoodListModel alloc]init];
    model.channel=@"1";
    model.desk_id=_desk_id;
    model.menu_id=titleIdStr;
    
    [MBProgressHUD showMessage:nil toView:self.view];
    [model OrderFoodListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            OrderFoodListModel *model= ( OrderFoodListModel *)data;
            
            if (titleIdStr.length==0) {
                menuListArr =[NSArray arrayWithArray:model.data.menu_list];
                for (  OrderFoodListModel *model in menuListArr) {
                    NSMutableArray *arr=[NSMutableArray array];
                    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
                    [ dict setValue:model.id forKey:@"titleId"];
                    [ dict setValue:[NSString string] forKey:@"cartId"];//购物车ID
                    [ dict setValue:arr forKey:@"data"];
                    [selectArr addObject:dict];
                }
            }
            take_pay=model.data.list.take_pay;
            NSMutableDictionary *dict=[NSMutableDictionary dictionary];
            [ dict setValue:model.data.list.name forKey:@"titleName"];
            titleIdStr=model.data.list.id;
            [ dict setValue:model.data.list.menus forKey:@"data"];
            
            mainDic=[NSMutableDictionary dictionaryWithDictionary:dict];
            [self getShopCartDataFromNet:YES];
            
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
-(void)getShopCartDataFromNet:(BOOL)isfirst
{
    GetShopCart *cart=[[GetShopCart alloc]init];
    cart.menu_id=titleIdStr;
    if (_uidStr==nil) {
        _uidStr=@"0";
    }
    cart.user_id=_uidStr;
    cart.desk_id=_desk_id;
    [MBProgressHUD showMessage:nil toView:self.view];
    [cart GetShopCartModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            GetShopCart *cart=(  GetShopCart *)data;
            [self getChartId:  cart.data.id  andCartList:cart.data.cart_list isfirst:isfirst ];
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
 -(void)getChartId:(NSString *)cart_id   andCartList:(NSArray *)list isfirst:(BOOL)isfirst
{
    
    for (int i=0; i<selectArr.count; i++)
    {
        NSMutableDictionary *dic=selectArr[i];
        if ([dic[@"titleId"] isEqualToString:titleIdStr])
        {
            dic[@"cartId"]=cart_id;
            
            dic[@"data"]=[NSMutableArray arrayWithArray:list];
        }
        
    }
    if (isfirst) {
        [self loadMainView];
    }
    
    [self  getPrice];
    
}

#pragma mark-------------- loadMainView
-(void)loadMainView
{
    _titleBtn.selected=NO;
    [_titleBtn setTitle:mainDic[@"titleName"] forState:UIControlStateNormal];
    
    
    [_titleBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, - _titleBtn.imageView.image.size.width, 0, _titleBtn.imageView.image.size.width)];
    [_titleBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _titleBtn.titleLabel.bounds.size.width, 0, -_titleBtn.titleLabel.bounds.size.width)];
    
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    NSArray *   listData=[NSArray arrayWithArray:mainDic[@"data"]];
    NSArray *  selectData=[NSArray arrayWithArray:[self selectDataFromSelectArr] ];
    if (listData.count>0)
    {
        for (int i=0;i<listData.count;i++  ) {
            OrderFoodListModel *model = listData[i];
            NSMutableArray *arr1=[NSMutableArray array];
            if (model.child.count>0) {
                for (  OrderFoodListModel *subModel in model.child)
                {
                    NSMutableArray *arr2=[NSMutableArray array];
                    
                    for (  OrderFoodListModel *subsubModel in subModel.category_caipin)
                    {
                        NSString *mic_id=  [NSString stringWithFormat:@"%@",subsubModel.mic_id ];
                        if ([mic_id  isEqualToString:@"0"]) {
                              [arr2 addObject:[self setModelNumAndSelect:subsubModel idStr:subsubModel.id mic_id:@"0"  selectArr:selectData]];
                        }
                        else
                        {
                            [arr2 addObject:[self setModelNumAndSelect:subsubModel idStr:subsubModel.dishes_id mic_id:@"1" selectArr:selectData]];
                        }

                    }
                    NSDictionary *dic=@{kHDClassifyLeftTableViewModelDataKeyName: subModel.category,kHDClassifyLeftTableViewModelDataKeyChildNode:arr2,  @"img_url":subModel. img_url,
                                           @"description":model.desc.length>0 ?model.desc:@""
                                        
                                        };
                    [arr1 addObject:dic];
                }
            }
            else
            {
                NSMutableArray *arr2=[NSMutableArray array];
                for (  OrderFoodListModel *subModel in model.category_caipin)
                {
                    NSString *mic_id=  [NSString stringWithFormat:@"%@",subModel.mic_id ];
                    if ([mic_id isEqualToString:@"0"]) {
                        [arr2 addObject:[self setModelNumAndSelect:subModel idStr:subModel.id mic_id:@"0" selectArr:selectData]];
                    }
                    else
                    {
                        [arr2 addObject:[self setModelNumAndSelect:subModel idStr:subModel.dishes_id mic_id:@"1" selectArr:selectData]];
                    }
                }
                
                NSDictionary *dic=@{kHDClassifyLeftTableViewModelDataKeyName: model.category,kHDClassifyLeftTableViewModelDataKeyChildNode:arr2,
                      @"description":model.desc.length>0 ?model.desc:@"",
                                      @"img_url":model.img_url
                                    };
                [arr1 addObject:dic];
            }
            
    
            NSDictionary *para=@{ kHDClassifyLeftTableViewModelSelected:i==0?@YES:@NO,  kHDClassifyLeftTableViewModelDataKeyName:model.category,
                                  kHDClassifyLeftTableViewModelDataKeyChildNode:arr1,
                                  @"img_url":model.img_url,
                                  }.mutableCopy;
            [arr addObject:para];
            
        }
        _dataSource=[NSArray arrayWithArray:arr];
        delectArr =nil;
        
        _leftTableViewModel = [[HDClassifyLeftTableViewModel alloc] init];
        _leftTableViewModel.delegate = self;
        _leftTableViewModel.dataSource = self.dataSource;
        
        
        _rightTableViewModel = [[HDClassifyRightTableViewModel alloc] init];
        _rightTableViewModel.delegate = self;
        _rightTableViewModel.contentData = [self dataListForRightTable];
        _rightTableViewModel.dataSource = self.dataSource;
        
        [self.view addSubview:self.leftTableViewModel.tableView];
        [self.view addSubview:self.rightTableViewModel.tableView];
        
        
        [self.leftTableViewModel scrollToSelectedSection];
        
    }
}

-(OrderFoodListModel *)setModelNumAndSelect:( OrderFoodListModel *)subsubModel idStr:(NSString *)idStr mic_id:(NSString *)mic_id selectArr:(NSArray *)data
{
    if (data.count>0) {
        for (NSDictionary *dic in data) {
            
            NSDictionary *dic1=dic[@"getPrice"];
            
            NSString *str1=[NSString stringWithFormat:@"%@",dic1[@"is_dish"]];
            NSString *str2=[NSString stringWithFormat:@"%@",dic1[@"cid"]];
            if ([str1 isEqualToString:mic_id]&&[str2 isEqualToString:idStr]) {
                subsubModel.selectNum=[dic1[@"totalNum"] integerValue];
            }
            
        }
    }
    else
    {
        subsubModel.selectNum=0;
    }
    
    if (delectArr.count>0) {
        for (NSDictionary *dic in delectArr) {
            NSDictionary *dict=dic[@"getPrice"];
            NSString *str1=[NSString stringWithFormat:@"%@",dict[@"is_dish"]];
            NSString *str2=[NSString stringWithFormat:@"%@",dict[@"cid"]];
            if ([str1 isEqualToString:mic_id]&&[str2 isEqualToString:idStr]) {
                subsubModel.selectNum=0;
            }
        }
    }
    return subsubModel;
}

-(NSArray *)selectDataFromSelectArr
{
    for (NSDictionary *dict in selectArr) {
        if ([dict[@"titleId"] isEqualToString:titleIdStr]) {
            NSArray *data=dict[@"data"];
            return data;
            
        }
    }
    return nil;
}

#pragma mark-------------- HDClassifyLeftTableViewModelDelegate
- (void)classifyLeftTableViewModel:(HDClassifyLeftTableViewModel *)viewModel didSelectedAtIndexPath:(NSIndexPath *)indexPath
{
    [self.rightTableViewModel scrollToIndexPathFromLeft:indexPath];
}

#pragma mark-------------- HDClassifyRightTableViewModelDelegate
- (void)rightViewModel:(HDClassifyRightTableViewModel *)viewModel didScrollToIndexPath:(NSIndexPath *)indexPath
{
    [self.leftTableViewModel selectAtIndexPathFromRight:indexPath];
}
-(void)rightViewModel:(HDClassifyRightTableViewModel *)viewModel addToIndexPath:(NSIndexPath *)indexPath
{
    OrderFoodListModel *model=   viewModel.contentData[indexPath.section][kHDClassifyLeftTableViewModelDataKeyChildNode][indexPath.item];
    
    OrderFoodAttributeView *view =[[OrderFoodAttributeView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    view.id=model.id;//套餐ID
    view.dishes_id=model.dishes_id;//单品id
    view.mic_id=model.mic_id;
    
    view.menu_id=titleIdStr;
    view.uid=_uidStr;
    
    NSDictionary *dict=[self getCartData];
    
    view.dataArray=dict[@"data"];
    view.cart_id=dict[@"cartId"];
    NSString *str1=[NSString stringWithFormat:@"%@",model.mic_id];
    if ([str1 isEqualToString:@"0"]) {
        view.dataDic=[self attributeViewInfo:dict[@"data"] cid:model.id is_dish:@"0"];
    }
    else
    {
        view.dataDic=[self attributeViewInfo:dict[@"data"] cid:model.dishes_id is_dish:@"1"];
    }
    view.desk_id=_desk_id;
    
    [view loadOrderFoodAttributeView];
    
    
    view.orderFoodAttributeViewBlock = ^(NSInteger num) {

    [self  getShopCartDataFromNet:YES];
        
    };
    [self.view.window addSubview:view];
    
}
-(void)rightViewModel:(HDClassifyRightTableViewModel *)viewModel didSelectCellToIndexPath:(NSIndexPath *)indexPath
{
    OrderFoodListModel *model=   viewModel.contentData[indexPath.section][kHDClassifyLeftTableViewModelDataKeyChildNode][indexPath.item];
   
    FoodDetail *detail=[[FoodDetail alloc]init];

    
    detail.menu_id=titleIdStr;
    detail.uid=_uidStr;

    detail.id=model.id;
    
    detail.dishes_id=model.dishes_id;//单品id
    detail.mic_id=model.mic_id;
    NSArray *arr=[self dataListForAllRightData: viewModel.contentData];
    
    NSArray *guessData=[self getAllGuessArr:arr];
 
   /*
    NSMutableDictionary *prama=[NSMutableDictionary dictionary];
    NSArray *data=[self dataListForGuessData: arr WithType:@"0" ];
    [prama setValue:data forKey:@"0"];
    data=[self dataListForGuessData: arr WithType:@"1" ];
    [prama setValue:data forKey:@"1"];
     */
    

   NSString *str1=[NSString stringWithFormat:@"%@",model.mic_id];
    if ([str1 isEqualToString:@"0"]) {
         detail.guessArr= [self delectRepitData:guessData andSelfDataId:model.id is_dish:@"0"];
    }
    else
    {
       detail.guessArr= [self delectRepitData:guessData andSelfDataId:model.dishes_id is_dish:@"1"];
    }
   
    detail.guessAllArr=guessData;
  
    detail.desk_id=_desk_id;
    [self.navigationController pushViewController:detail animated:YES];
    
    
}
-(NSArray *)delectRepitData:(NSArray *)arr  andSelfDataId:( NSString *)cid is_dish:(NSString *)is_dish
{
    //去掉当前ID的菜品
    NSMutableArray *resultArray = [NSMutableArray arrayWithArray:arr];
    for ( OrderFoodListModel *model in arr) {
        
        if ([is_dish isEqualToString:@"0"]) {
            
            if ([model.id isEqualToString:cid] &&[model.mic_id isEqualToString:@"0"]) {
                
                [resultArray removeObject:model];
            }
        }
        
         if ([is_dish isEqualToString:@"1"])
         {
             if ([model.dishes_id isEqualToString:cid] &&(![model.mic_id isEqualToString:@"0"])) {
                 
                 [resultArray removeObject:model];
             }
        }

    }
    return resultArray;
  
}
-(NSArray *)getAllGuessArr:(NSArray *)arr
{
    //去掉相同的菜品（ID 相同的去掉）
    NSMutableArray *array = [NSMutableArray arrayWithArray:arr];
    for (int  x = 0; x < arr.count; x++) {
        for (int  y = x+1;y < arr.count; y++) {
            OrderFoodListModel *tempModel = arr[x];
            OrderFoodListModel *model = arr[y];
            if ([tempModel.mic_id isEqualToString:model.mic_id]) {
                if ([tempModel.id isEqualToString:model.id]) {
                    [array removeObject:model];
                }
            }
            
            else {
                if ([tempModel.dishes_id isEqualToString:model.dishes_id]) {
                    [array removeObject:model];
                }
            }
        }
    }
    return array;
    
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
-(void)rightViewModel:(HDClassifyRightTableViewModel *)viewModel reduceToIndexPath:(NSIndexPath *)indexPath
{
    [MBProgressHUD showSuccess:@"请在已选菜品内操作" toView:self.view];
}
#pragma mark-------------- 已点菜品
-(IBAction)alreadyPress:(id)sender
{
    AlreadyOrderFoodView *view ;
    NSArray *arr=[self getCartData][@"data"];
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
        
        view.tableViewHH.constant=87*2.5;
        
    }
    
    view.data=[NSArray arrayWithArray:arr];
    
    view.titleId=titleIdStr;
    NSDictionary *dict=[self getCartData];
    view.cart_id=dict[@"cartId"];
    view.uidStr=_uidStr;
    view.desk_id=_desk_id;
    view.alreadyOrderFoodViewBlock = ^(NSArray *  data, NSString * _Nonnull type) {
        
        delectArr=[NSArray arrayWithArray:data];
        if ([type isEqualToString:@"ok"]) {
            [self setOrder];
        }
        
        [self  getShopCartDataFromNet:YES];
    };
    view.clearBlock = ^{
        for (int i=0; i<selectArr.count; i++)
        {
            NSDictionary *dic=selectArr[i];
            if ([dic[@"titleId"] isEqualToString:titleIdStr])
            {
                NSMutableArray *arr=dic[@"data"];
                [arr removeAllObjects];
            }
        }
        [self  getShopCartDataFromNet:YES];
    };
    
    [self.view.window addSubview:view];
    
}
-(void)setOrder
{
    
    NSDictionary *dict=[self getCartData];
    SetOrder *order=[[SetOrder alloc]init];

    order.id=dict[@"cartId"];
    order.desk_id=_desk_id;
    order.source=@"3";
  //  order.server_id=[[LoginModel shareInstance] getUserInfo].user_info.uid;
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
-(IBAction)moneyPress:(id)sender
{
    OrderFoodMoneyView *view =[[OrderFoodMoneyView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    
    [self.view.window addSubview:view];
    
}
- (IBAction)setOrderPress:(id)sender {
    NSArray *arr=[self getCartData][@"data"];
    if (arr.count==0) {
        [MBProgressHUD showSuccess:@"菜品不能为空" toView:self.view];
    }
    else
    {
        [self setOrder];
    }
    
}


#pragma mark-------------- 数据来源数组
//右侧数据
- (NSArray *)dataListForRightTable
{
    NSArray *arr = [NSArray array];
    for (int i = 0; i < self.dataSource.count; i++) {
        arr = [arr arrayByAddingObjectsFromArray:self.dataSource[i][kHDClassifyLeftTableViewModelDataKeyChildNode]];
    }
    return arr;
}
//购物车数据
-(NSDictionary *)getCartData
{
    for (NSDictionary *dic in selectArr)
    {
        if ([dic[@"titleId"] isEqualToString:titleIdStr])
        {
            return dic;
        }
        
    }
    return nil;
}
//进店都买数据
- (NSArray *)dataListForAllRightData:(NSArray *)data
{
    NSArray *arr = [NSArray array];
    for (int i = 0; i < data.count; i++) {
        arr = [arr arrayByAddingObjectsFromArray:data[i][kHDClassifyLeftTableViewModelDataKeyChildNode]];
    }
    return arr;
}
-(void)getPrice
{
    for (NSDictionary *dict in selectArr) {
        
        if ([dict[@"titleId"] isEqualToString:titleIdStr]) {
            
            NSMutableArray *arr= dict[@"data"];
            
            double sumPrice=0;
            NSInteger sumNum=0;
            for (NSDictionary *dic in arr) {
                
                NSDictionary *data=dic[@"getPrice"];
                double price=  [data[@"totalPrices"] doubleValue];
                sumPrice=sumPrice+price;
                sumNum=sumNum + [data[@"totalNum"] intValue];
            }
        
            NSString *sumPriceStr=[NSString stringWithFormat:@"%.2f",
                                   sumPrice];
            NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"总金额:￥%@",sumPriceStr]];
            
      
            [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,sumPriceStr.length+1)];
            
            _foodContentLab.attributedText=AttributedStr;
            
            if (sumNum >0 ) {
                _selectNumLab.hidden=NO;
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
            return;
        }
    }
    
}


@end
