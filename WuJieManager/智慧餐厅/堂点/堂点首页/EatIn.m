//
//  EatIn.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/5.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "EatIn.h"
#import "EatInCell.h"
#import "SItemView.h"
#import "EatInTopView.h"
#import "BeginToEat.h"
#import "OnMeal.h"
#import "BanquetList.h"
#import "GetDesksTaiList.h"
#import "ExitView.h"
#import "OrderSubFood.h"
#import "OrderListSure.h"
@interface EatIn ()<UICollectionViewDelegate, UICollectionViewDataSource,SelectTopDelegate>

{
    UIImageView *_headImaView;
    UIScrollView *titleItemScrollView;
    UIScrollView *stateScrollView;
    
   
    EatInTopView *top;
    NSArray *dataArr;
    NSArray *desk_data;
    NSArray *allDesk_data;
    
    NSArray *stateArr;
    
    NSString *titleIndex;
    NSString * subtitleIndex;
}
@property (weak, nonatomic) IBOutlet UICollectionView *mCollect;
@property (weak, nonatomic) IBOutlet UIView *titleItemView;
@property (strong, nonatomic)IBOutlet UIView *titleSubView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomHH;
@property (nonatomic, assign) CGFloat itemWidth;
@property (weak, nonatomic) IBOutlet UILabel *sumDescribeLab;



@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation EatIn

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNav];
    
    titleIndex=@"";
    subtitleIndex=@"";
    
    [_mCollect registerNib:[UINib nibWithNibName:NSStringFromClass([EatInCell class]) bundle:nil] forCellWithReuseIdentifier:@"EatInCell"];
    
    NSString *version= [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >=10.0&&version.doubleValue <11.0) {
        _bottomHH.constant=50;
        
    }
    else
    {
        _bottomHH.constant=0;
        
    }
    stateArr= @[@"全部",@"空台",@"待点餐",@"待确认",@"待结账",@"待清台"];
    
    _backView.hidden=YES;
    
}
- (void)initRefresh
{
    __block EatIn * blockSelf = self;
    _mCollect.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [blockSelf getData];
    }];
    [_mCollect.mj_header beginRefreshing];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    titleIndex=@"";
    subtitleIndex=@"";
    [self creatTopView];
    
    [self initRefresh];
    
}
-(void)creatTopView
{
    double Yy=(KIsiPhoneX )? 88:64;
    top=[[EatInTopView alloc]initWithFrame:CGRectMake(0, Yy+60, ScreenW, ScreenH-Yy)];
    top.delegate=self;
    [self.view.window addSubview:top];
    top.hidden=YES;
}

-(void)getData
{
    GetDesksTaiList *list=[[GetDesksTaiList alloc]init];
    [MBProgressHUD showMessage:nil toView:self.view];
    [list GetDesksTaiListSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            GetDesksTaiList *list=(GetDesksTaiList *)data;
            dataArr=[NSArray arrayWithArray:list.data.desk_list];
            desk_data=[self getAllDesk_data];
            allDesk_data= [NSArray arrayWithArray:desk_data];
            [self initTitleItemScrollView];
            [self initSubScrollView];
            
            _sumDescribeLab.text=[self getSumDescribe];
            [_mCollect reloadData];
            
        }
        else
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:message toView:self.view];
            });
        }
        [_mCollect.mj_header endRefreshing];
        [_mCollect.mj_footer endRefreshing];
    } andFailure:^(NSError * _Nonnull error) {
        [_mCollect.mj_header endRefreshing];
        [_mCollect.mj_footer endRefreshing];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
-(NSString *)getSumDescribe
{
   
    CGFloat price=0;
    for (GetDesksTaiList *subList in desk_data) {
        if ([subList.use_type intValue]==1||[subList.use_type intValue]==2) {
        
            if ([subList.topay_order_price doubleValue]>0) {
                price=price+[subList.topay_order_price doubleValue];
            }
        }
    }
    return [NSString stringWithFormat:@"未结账金额：￥%.2f",price];
}
-(NSArray *)getSubTittleNum
{
    NSMutableArray *arr=[NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0", nil];
    for (int i=0; i<desk_data.count;i++) {
        GetDesksTaiList *list=desk_data[i];
        //开台
        if ([list.use_type intValue]==0) {
            NSInteger index=[arr[1] intValue];
            index=index+1;
            [arr replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%ld",(long)index]];
        }
        //待点餐
        if ([list.use_type intValue]==4) {
            NSInteger index=[arr[2] intValue];
            index=index+1;
            [arr replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%ld",(long)index]];
        }
        //待确认
        if ([list.use_type intValue]==1) {
            NSInteger index=[arr[3] intValue];
            index=index+1;
            [arr replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%ld",(long)index]];
        }
        //待结账
        if ([list.use_type intValue]==2) {
            NSInteger index=[arr[4] intValue];
            index=index+1;
            [arr replaceObjectAtIndex:4 withObject:[NSString stringWithFormat:@"%ld",(long)index]];
        }
        //待清台
        if ([list.use_type intValue]==3) {
            NSInteger index=[arr[5] intValue];
            index=index+1;
            [arr replaceObjectAtIndex:5 withObject:[NSString stringWithFormat:@"%ld",(long)index]];
        }
     
        
    }
    [arr replaceObjectAtIndex:0 withObject: [self sumNum:arr]];
    return arr;
}

-(NSArray *)getAllDesk_data
{
    NSMutableArray *arr=[NSMutableArray array];
    for (GetDesksTaiList *list in dataArr) {
       
        if (list.child.count>0) {
            for (GetDesksTaiList *subList in  list.child) {
                
                NSArray *array=subList.desk_type_list;
                for (GetDesksTaiList *subsubList in array) {
                    [arr addObjectsFromArray:subsubList.desk_data];
                    
                }
                
            }
        }
        else
        {
            for (GetDesksTaiList *subList in  list.desk_type_list) {
                    [arr addObjectsFromArray:subList.desk_data];
                
            }
        }
     
        
    }
    return arr;
}
-(void) initSubScrollView{
    //获取滚动条
    
    if(!stateScrollView){
        stateScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _titleSubView.frame.size.width ,_titleSubView.frame.size.height)];
        stateScrollView.showsHorizontalScrollIndicator = YES;   //隐藏水平滚动条
        stateScrollView.showsVerticalScrollIndicator = YES;     //隐藏垂直滚动条
        
        //横竖屏自适应
        stateScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        [stateScrollView setBackgroundColor:[UIColor clearColor]];
        
        //添加到当前视图
        [_titleSubView addSubview:stateScrollView];
    }else{
        //清除子控件
        for (UIView *view in [stateScrollView subviews]) {
            [view removeFromSuperview];
        }
    }
    
    if (stateArr.count>0) {
        
        CGFloat offsetX = 0 ,i = 0, h = _titleSubView.frame.size.height;
        
        //设置滚动文字
        UIButton *btnText = nil;
        
      NSArray *   numArr=[NSArray arrayWithArray: [self getSubTittleNum]];
        for (    NSString  *strTitle in stateArr) {
            
            NSInteger num=4;
            if (IS_PAD) {
                num=8;
                
            }
            if (stateArr.count <= num) {
                self.itemWidth = ScreenW / stateArr.count;
            }else{
                self.itemWidth = ScreenW / 4;
            }
            btnText = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [btnText setFrame:CGRectMake(self.itemWidth * i+5,
                                         10,
                                         self.itemWidth-20,
                                         h-20)];
            
            
            [btnText setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btnText setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            [btnText setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            
            btnText.layer.cornerRadius = 10;
            btnText.layer.borderColor=[UIColor clearColor].CGColor;
            btnText.layer.borderWidth=1.5;
            
            
            [btnText setTitle:strTitle forState:UIControlStateNormal];
            btnText.titleLabel.font = [UIFont systemFontOfSize: 12.0];
            
            offsetX +=CGRectGetWidth(btnText.bounds) ;
            btnText.userInteractionEnabled = YES;
            
            btnText.tag=i;
            [btnText addTarget:self action:@selector(selectSubTitle:) forControlEvents:UIControlEventTouchUpInside];
            //添加到滚动视图
            [stateScrollView addSubview:btnText];
            
            if ([[numArr objectAtIndex:i] intValue]>0) {
                
                UILabel *lab=[[UILabel alloc ]initWithFrame:CGRectMake(CGRectGetMaxX(btnText.bounds)-20, -5, 20, 20)];
                lab.backgroundColor=color(255, 33, 33);
                lab.textColor=[UIColor whiteColor];
                lab.text=[numArr objectAtIndex:i];
                lab.font = [UIFont systemFontOfSize:10.0];
                lab.textAlignment=NSTextAlignmentCenter;
                lab.layer.cornerRadius = lab.frame.size.width/2;
                lab.layer.masksToBounds = YES;
                lab.adjustsFontSizeToFitWidth = YES;
                  [btnText addSubview:lab];
            }
            
            if (i==0) {
              
                btnText.selected=YES;
                [btnText setBackgroundColor:color(254, 234, 234)];
                btnText.layer.borderColor=[UIColor redColor].CGColor;
            }
            i++;
        }
        [stateScrollView setContentSize:CGSizeMake(self.itemWidth * stateArr.count+50, 0)];
        
    }
}
-(NSString *)sumNum:(NSArray *)numArr
{
    NSInteger sum=0;
    for (NSString *str in numArr) {
        sum =sum+[str intValue];
    }
    return  [NSString stringWithFormat:@"%ld",(long)sum ];
}
#pragma mark scrollView 按钮响应事件
-(void)selectSubTitle:(UIButton *)but
{
    if (but.selected) {
        
        return;
    }
    else
    {
        but.backgroundColor=color(254, 234, 234);
        but.selected=YES;
        but.layer.borderColor=[UIColor redColor].CGColor;
        
        for (UIButton *button in stateScrollView.subviews) {
            if ([button isKindOfClass:[UIButton class]]) {
                if (button.tag!=but.tag) {
                    button.selected=NO;
                    button.backgroundColor=[UIColor groupTableViewBackgroundColor];
                    button.layer.borderColor=[UIColor clearColor].CGColor;
                    
                }
                
            }
        }
    }
    
    NSInteger index=but.tag;
    if (index==0) {
        //全部
        desk_data=[NSArray arrayWithArray:allDesk_data];
        _sumDescribeLab.text=[self getSumDescribe];
        [_mCollect reloadData];
    }
    else if (index==1)
    {// 空台
        [self getSubDeskList:0];
    }
    else if (index==2)
    {// 待点餐
        [self getSubDeskList:4];
    }
    else if (index==3)
    {// 待确认
          [self getSubDeskList:1];
    }
    else if (index==4)
    {// 待结账
          [self getSubDeskList:2];
    }
    else if (index==5)
    {// 待清台
          [self getSubDeskList:3];
    }
    
}
    
-(void)getSubDeskList:(NSInteger )num
{
    NSMutableArray *arr=[NSMutableArray array];
    for (GetDesksTaiList *list in allDesk_data) {
        
        if ([list.use_type intValue]==num) {
            [arr addObject:list];
        }
    }
    desk_data=[NSArray arrayWithArray:arr];
    _sumDescribeLab.text=[self getSumDescribe];
    [_mCollect reloadData];
}
    
    


//文字初始化
-(void) initTitleItemScrollView{
    //获取滚动条
    if(!titleItemScrollView){
        titleItemScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _titleItemView.frame.size.width ,50)];
        titleItemScrollView.showsHorizontalScrollIndicator = YES;   //隐藏水平滚动条
        titleItemScrollView.showsVerticalScrollIndicator = YES;     //隐藏垂直滚动条
        
        //横竖屏自适应
        titleItemScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        [titleItemScrollView setBackgroundColor:[UIColor whiteColor]];
        
        
        //添加到当前视图
        [_titleItemView addSubview:titleItemScrollView];
    }else{
        //清除子控件
        for (UIView *view in [titleItemScrollView subviews]) {
            [view removeFromSuperview];
        }
    }
    
    if (dataArr) {
        
        CGFloat offsetX = 0 ,i = 0, h = 50;
        
        //设置滚动文字
        UIButton *btnText = nil;
        NSString *strTitle = [[NSString alloc] init];
        
        for (   GetDesksTaiList  *model in dataArr) {
            
            strTitle =model.name;
            
            btnText = [UIButton buttonWithType:UIButtonTypeCustom];
            
            NSInteger num=4;
            if (IS_PAD) {
                num=8;
                
            }
            if (dataArr.count <= num) {
                self.itemWidth = ScreenW / dataArr.count;
            }else{
                self.itemWidth = ScreenW / 4;
            }
            [btnText setFrame:CGRectMake(self.itemWidth * i+5,
                                         10,
                                         self.itemWidth-20,
                                         h-20)];
            [btnText setTitleColor:navigationHotelColor forState:UIControlStateSelected];
            [btnText setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            
            [btnText setTitle:strTitle forState:UIControlStateNormal];
            
            btnText.titleLabel.font = [UIFont systemFontOfSize: 14.0];
            
            //横竖屏自适应
            offsetX +=CGRectGetWidth(btnText.bounds) ;
            btnText.userInteractionEnabled = YES;
            btnText.tag=i;
            [btnText addTarget:self action:@selector(selectTitle:) forControlEvents:UIControlEventTouchUpInside];
            
            [btnText setImage:[UIImage imageNamed:@"灰色三角"] forState:UIControlStateNormal];
            [btnText setImage:[UIImage imageNamed:@"红色三角"] forState:UIControlStateSelected];
            
            [btnText setTitleEdgeInsets:UIEdgeInsetsMake(0, - btnText.imageView.image.size.width, 0, btnText.imageView.image.size.width)];
            [btnText setImageEdgeInsets:UIEdgeInsetsMake(0, btnText.titleLabel.bounds.size.width, 0, -btnText.titleLabel.bounds.size.width)];
            
            //添加到滚动视图
            [titleItemScrollView addSubview:btnText];
            
            i++;
        }
        
        [titleItemScrollView setContentSize:CGSizeMake(self.itemWidth * dataArr.count+50, 0)];
    }
    
}

#pragma mark scrollView 按钮响应事件
-(void)selectTitle:(UIButton *)but
{
    
    if (but.selected) {
        
        top.hidden= !top.hidden;
    }
    else
    {
        
        titleIndex=@"";
        subtitleIndex=@"";
        but.selected=YES;
        top.hidden=NO;
        for (UIButton *button in titleItemScrollView.subviews) {
            if ([button isKindOfClass:[UIButton class]]) {
                if (button.tag!=but.tag) {
                    button.selected=NO;
                    
                }
                
            }
        }
    }
    GetDesksTaiList  *model= dataArr[ but.tag];
   
    [top reloadData:model.child index:titleIndex subIndex:subtitleIndex];
    
    if ( top.hidden==YES) {
        NSMutableArray *arr=[NSMutableArray array];
        if (model.child.count>0) {
            for (GetDesksTaiList *subList in model.child) {
                
                NSArray *array=subList.desk_type_list;
                for (GetDesksTaiList *subsubList in array) {
                    [arr addObjectsFromArray:subsubList.desk_data];
                }
            }
        }
        else
        {
            for (GetDesksTaiList *subList in  model.desk_type_list) {
                [arr addObjectsFromArray:subList.desk_data];
                
            }
        }
      
        desk_data=[NSArray arrayWithArray:arr];
        allDesk_data=[NSArray arrayWithArray:arr];
        [self initSubScrollView];
        _sumDescribeLab.text=[self getSumDescribe];
        [_mCollect reloadData];
         titleIndex=@"";
         subtitleIndex=@"";
    }
    
}
- (void)createNav {
    
    self.title=[[LoginModel shareInstance] getUserInfo].user_info.merchant_name ;
    
    
    UIButton * lefthBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn1.frame = CGRectMake(0, 0, 44, 50);
    
    [lefthBtn1 setImage:[UIImage imageNamed:@"白色返回"] forState:UIControlStateNormal];
    lefthBtn1.imageEdgeInsets = UIEdgeInsetsMake(0,  -20, 0, 0);
    
    [lefthBtn1 addTarget:self action:@selector(lefthBtn1Click) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(CGRectGetMaxX(lefthBtn1.frame), 0, 130, 50);
    [lefthBtn addTarget:self action:@selector(lefthBtn2Click) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    UIBarButtonItem * leftBtnItem1 = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn1];
    if ([_type isEqualToString:@"2"]) {
        self.navigationItem.leftBarButtonItems = @[leftBtnItem1,leftBtnItem];
    }
    else
    {
        self.navigationItem.leftBarButtonItem = leftBtnItem;
    }
    
    
    
    _headImaView=[[UIImageView alloc ]initWithFrame:CGRectMake(0, 10, 30, 30)];
    _headImaView.layer.masksToBounds = YES;
    _headImaView.layer.cornerRadius = _headImaView.frame.size.width/2;
    _headImaView.layer.borderWidth = 0.1;
    _headImaView.layer.borderColor =[UIColor clearColor].CGColor;
    [_headImaView sd_setImageWithURL:[NSURL URLWithString:[[LoginModel shareInstance] getUserInfo].user_info.head_icon] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    [lefthBtn addSubview:_headImaView];
    
    
    UILabel *nameLab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headImaView.frame)+2, 10, 100, 30)];
    nameLab.text=[[LoginModel shareInstance] getUserInfo].user_info.nick_name;
    nameLab.textColor=[UIColor whiteColor];
    [nameLab setFont:[UIFont systemFontOfSize:14]];
    [lefthBtn addSubview:nameLab];
    
    
    
    if (![_type isEqualToString:@"2"]) {
        UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(0, 0, 44, 50);
        
        UIBarButtonItem * rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
  //    self.navigationItem.rightBarButtonItem = rightBtnItem;
        
     //   [rightBtn addTarget:self action:@selector(rightPress) forControlEvents:UIControlEventTouchUpInside];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightBtn.titleLabel.font=[UIFont systemFontOfSize:14] ;
        [rightBtn setTitle:@"宴会台" forState:UIControlStateNormal];
    }
    
}
-(void)rightPress
{
    [top removeFromSuperview];
    BanquetList *list=[[BanquetList alloc]init];
    list.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:list animated:YES];
}
- (void)lefthBtn1Click {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)lefthBtn2Click
{
    ExitView *view=[[ExitView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    [self.view.window addSubview:view];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return desk_data.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    EatInCell * commonCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EatInCell" forIndexPath:indexPath];
    
    
    GetDesksTaiList *list=desk_data[indexPath.row];
    commonCell.tableNameLab.text=list.name;
      commonCell.subTableNameLab.text= [NSString stringWithFormat:@"(%@)",list.desk_type_info];
  
    if ([list.use_type intValue]==0) {
        commonCell.beginView.hidden=NO;
        
        [commonCell.beginBtn setTitle:list.status_name forState:UIControlStateNormal];
        commonCell .beginBtn.enabled=YES;
        commonCell.beginBtn.layer.borderColor=color(7, 189, 24).CGColor;
        
        commonCell.beginBtn.tag=indexPath.item;
        [commonCell .beginBtn addTarget:self action:@selector(beginToEat:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    else
    {
        
        commonCell.userNameLab.text=list.user_name;
        commonCell.timeLab.text=list.open_time_string;
        commonCell.sumMoneyLab.text=[NSString stringWithFormat:@"总额:¥%.2f",[list.total_order_price doubleValue] ];
        if ([list.topay_order_price doubleValue]>0) {
            commonCell.jiesuanLab.textColor=[UIColor redColor];
            
        }
        else
        {
            commonCell.jiesuanLab.textColor=[UIColor darkGrayColor];
        }
        commonCell.jiesuanLab.text=[NSString stringWithFormat:@"未结清:¥%.2f",[list.topay_order_price doubleValue]];
        commonCell.beginView.hidden=YES;
        
        if ([list.use_type intValue]==3) {
            commonCell.eatInBtn.layer.borderColor =color(255, 120, 0).CGColor;
            [commonCell.eatInBtn setTitleColor:color(255, 120, 0) forState:UIControlStateNormal];
            commonCell.eatInBtn.backgroundColor=color(255, 255, 255);
        }
        else
        {
            commonCell.eatInBtn.layer.borderColor =navigationHotelColor.CGColor;
            [commonCell.eatInBtn setTitleColor:navigationHotelColor forState:UIControlStateNormal];
            commonCell.eatInBtn.backgroundColor=color(247, 225, 226);
        }
        [commonCell.eatInBtn setTitle:list.status_name forState:UIControlStateNormal];
        
        commonCell.eatInBtn .tag=indexPath.item;
        [commonCell .eatInBtn addTarget:self action:@selector(onMeal:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return commonCell;
}


#pragma mark - =========================== CollectionView的item的布局 =============================
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (IS_PAD) {
        return CGSizeMake(ScreenW/4-10,250);
    }
    return CGSizeMake((ScreenW-10.5)/2,250);
    
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GetDesksTaiList *list=desk_data[indexPath.item];
    if ([list.use_type intValue]==0) {
         [self beginToEatDetail:list];
        return;
    }
    else {
        [self onMealDetail:list];
        return;
    }
}
#pragma mark - 开台
-(void)beginToEat:(UIButton *)btn
{
    GetDesksTaiList *list=desk_data[btn.tag];     //开台
    [self beginToEatDetail:list];
 
}
-(void)onMeal:(UIButton *)btn
{
    GetDesksTaiList *list=desk_data[btn.tag];
    
    [self onMealDetail:list];
}


-(void)beginToEatDetail:(  GetDesksTaiList *)list
{
    BeginToEat *eat=[[BeginToEat alloc]init];
    eat.idStr= list.id;
    eat.name=list.name;
    eat.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:eat animated:YES];
}
-(void)onMealDetail:(  GetDesksTaiList *)list
{
    if ([list.use_type intValue]==4)  {
        OrderSubFood *food=[[OrderSubFood alloc]init];
        food.desk_id=list.id;
        food.uidStr=list.uid;
        food.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:food animated:YES];
        
    }
    else
    {
        
        OrderListSure *sure=[[OrderListSure alloc]init];
        sure.desk_id=list.id;
        sure.mid=[[LoginModel shareInstance] getUserInfo].user_info.merchant_id;;
        sure.title=list.name;
        sure.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:sure animated:YES];
    }
}

-(void)selectTopWithArr:(NSArray *)Arr index:(NSString *)index subIndex:(NSString *)subIndex
{
    
    titleIndex=index;
    subtitleIndex=subIndex;
    desk_data=[NSArray arrayWithArray:Arr];
    allDesk_data=[NSArray arrayWithArray:Arr];
    top.hidden=YES;
    [self initSubScrollView];
    _sumDescribeLab.text=[self getSumDescribe];
    [_mCollect reloadData];
}
-(void)reset
{
    titleIndex=@"";
    subtitleIndex=@"";
 
    top.hidden=YES;
    [self getData];
}
@end
