//
//  RowNum.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/5.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "RowNum.h"
#import "SItemView.h"
#import "RowNumCell.h"
#import "RowNumDetail.h"
#import "AddRowNum.h"
#import "GetDesks.h"
#import "ChangeNumberType.h"
#import "ServerCallModel.h"
#import "ExitView.h"
#import "RowNumPadCell.h"
@interface RowNum ()<UITableViewDelegate, UITableViewDataSource>
{
    NSString* typeNum;
    UIScrollView      *scrollViewText;
    NSArray *dataArr;
    NSArray *subDataArr;
    
    NSTimer           *getDataTimer;
    NSInteger selectId;

}
@property (weak, nonatomic) IBOutlet SItemView *titleItemView;
@property (strong, nonatomic)IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UITableView *mTable;
@property (nonatomic, assign) CGFloat itemWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mTableBottom;

@end

@implementation RowNum

- (void)viewDidLoad {
    [super viewDidLoad];
    
    adjustsScrollViewInsets_NO(_mTable, self);
    typeNum=@"2";
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([RowNumCell class]) bundle:nil] forCellReuseIdentifier:@"RowNumCell"];
     [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([RowNumPadCell class]) bundle:nil] forCellReuseIdentifier:@"RowNumPadCell"];
    
       selectId=0;
    
    [self createNav];
    

    NSString *version= [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >=10.0&&version.doubleValue <11.0) {
        _mTableBottom.constant=-50;
        
    }
    else
    {
        _mTableBottom.constant=0;
        
    }
    [self initRefresh];
    [self startGetDataTimer];
    
}
-(void)startGetDataTimer
{
    getDataTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(getData) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:getDataTimer  forMode:NSRunLoopCommonModes];
}
-(void)viewDidDisappear:(BOOL)animated
{
      [getDataTimer invalidate];
    getDataTimer = nil;
}
#pragma mark - 初始化下拉刷新
- (void)initRefresh
{
    __block RowNum * blockSelf = self;
    _mTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [blockSelf getData];
    }];
    [_mTable.mj_header beginRefreshing];
}
-(void)getData
{
    GetDesks *list=[[GetDesks alloc]init];
    list.num_state=typeNum;
    [MBProgressHUD showMessage:nil toView:self.view];

    [list GetDesksSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
      
        GetDesks *list=( GetDesks *)data;
        if ([code intValue]==200) {
              dataArr=[NSArray arrayWithArray:list.data.desk_info];
               [self initScrollText];
        }
        else
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:message toView:self.view];
            });
        }
        [_mTable.mj_header endRefreshing];
        [_mTable.mj_footer endRefreshing];
    } andFailure:^(NSError * _Nonnull error) {
        [_mTable.mj_header endRefreshing];
        [_mTable.mj_footer endRefreshing];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
    
}

-(void) initScrollText{
    //获取滚动条
    
    if(!scrollViewText){
        scrollViewText = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _titleView.frame.size.width ,50)];
        scrollViewText.showsHorizontalScrollIndicator = YES;   //隐藏水平滚动条
        scrollViewText.showsVerticalScrollIndicator = YES;     //隐藏垂直滚动条
        
        //横竖屏自适应
        scrollViewText.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        [scrollViewText setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        
        //添加到当前视图
        [_titleView addSubview:scrollViewText];
    }else{
        //清除子控件
        for (UIView *view in [scrollViewText subviews]) {
            [view removeFromSuperview];
        }
    }
    
    if (dataArr.count>0) {
        
        CGFloat offsetX = 0 ,i = 0, h = 50;
        
        //设置滚动文字
        UIButton *btnText = nil;
        NSString *strTitle = [[NSString alloc] init];
        
        for (    GetDesks  *model in dataArr) {
            
            strTitle =model.name;
            
            btnText = [UIButton buttonWithType:UIButtonTypeCustom];
            NSInteger num=4;
            if (IS_PAD) {
                num=10;
                
            }
            if (dataArr.count <= num) {
                self.itemWidth = ScreenW / dataArr.count;
            }else{
                self.itemWidth = ScreenW / 4;
            }
            [btnText setFrame:CGRectMake(self.itemWidth * i,
                                         0,
                                         self.itemWidth,
                                         h)];
            
            
            [btnText setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btnText setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [btnText setTitle:strTitle forState:UIControlStateNormal];
            btnText.titleLabel.font = [UIFont systemFontOfSize: 12.0];
            
            offsetX +=CGRectGetWidth(btnText.bounds) ;
            btnText.userInteractionEnabled = YES;
            
            btnText.tag=i;
            [btnText addTarget:self action:@selector(selectTitle:) forControlEvents:UIControlEventTouchUpInside];
            //添加到滚动视图
            [scrollViewText addSubview:btnText];
            
            UILabel *lab=[[UILabel alloc ]initWithFrame:CGRectMake(CGRectGetMaxX(btnText.bounds)-20, 5, 20, 20)];
            lab.backgroundColor=color(255, 33, 33);
            lab.textColor=[UIColor whiteColor];
            lab.text=model.wait_number;
            lab.font = [UIFont systemFontOfSize:10.0];
            
            lab.textAlignment=NSTextAlignmentCenter;
            lab.layer.cornerRadius = lab.frame.size.width/2;
            lab.layer.masksToBounds = YES;
            lab.adjustsFontSizeToFitWidth = YES;
            
            [btnText addSubview:lab];
            
            if (selectId==i) {
                btnText.selected=YES;
                [btnText setBackgroundColor:[UIColor whiteColor]];
                subDataArr=[NSArray arrayWithArray:model.num_list];
            }
            i++;
        }
        [scrollViewText setContentSize:CGSizeMake(self.itemWidth * dataArr.count+50, 0)];
        [_mTable reloadData];
    }
}
-(float) getTitleLeft:(CGFloat) i {
    float left = i * 5.0f;
    
    if (i > 0) {
        for (int j = 0; j < i; j ++) {
            GetDesks *model=[dataArr objectAtIndex:j];
            NSString *   strTitle =model.name ;
            left += [strTitle length] * 18.0f;
        }
    }
    return left;
}
#pragma mark scrollView 按钮响应事件
-(void)selectTitle:(UIButton *)but
{
    if (but.selected) {
        return;
    }
    else
    {
        but.backgroundColor=[UIColor whiteColor];
        for (UIButton *button in scrollViewText.subviews) {
            if ([button isKindOfClass:[UIButton class]]) {
                if (button.tag!=but.tag) {
                    button.selected=NO;
                    button.backgroundColor=[UIColor groupTableViewBackgroundColor];
                    
                }
                
            }
        }
    }
    GetDesks  *model =dataArr[but.tag];
    selectId=but.tag;
    subDataArr=[NSArray arrayWithArray:model.num_list];
    [_mTable reloadData];
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
    if ([_type isEqualToString:@"1"]) {
        self.navigationItem.leftBarButtonItems = @[leftBtnItem1,leftBtnItem];
    }
    else
    {
        self.navigationItem.leftBarButtonItem = leftBtnItem;
    }
    
    
    
   UIImageView* _headImaView=[[UIImageView alloc ]initWithFrame:CGRectMake(0, 10, 30, 30)];
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
    
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 50);
    
    UIBarButtonItem * rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    
    [rightBtn addTarget:self action:@selector(rightPress) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font=[UIFont systemFontOfSize:14] ;
    [rightBtn setTitle:@"打号" forState:UIControlStateNormal];
    
}

-(void)rightPress
{
    AddRowNum  *add=[[ AddRowNum alloc]init];
    add.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:add animated:YES];
}
- (void)lefthBtn1Click {
    [self dismissViewControllerAnimated: YES completion:nil];
}
-(void)lefthBtn2Click
{
    ExitView *view=[[ExitView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    [self.view.window addSubview:view];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.titleItemView.itemsArray = @[@"正在排号",@"入号",@"过号"];
    self.titleItemView.SelectItemBlock = ^(NSInteger index) {
        if (index==0) {
            typeNum=@"2";
        }
        else if (index==1) {
            typeNum=@"4";
        }
        else
        {
             typeNum=@"3";
        }
        
        selectId=0;
        [scrollViewText setContentOffset:CGPointMake(0,0) animated:NO];
        
        [self getData];
    };
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return subDataArr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GetDesks  *model =  subDataArr[indexPath.row];
    
    if (IS_PAD) {
        RowNumPadCell *cell=[tableView dequeueReusableCellWithIdentifier:@"RowNumPadCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
  
        cell.nameLab.text=model.number_show;
        cell.subNameLab.text=model.take_info;
        
        if ([typeNum isEqualToString:@"2"] ) {
            cell.view1.hidden=NO;
            cell.view2.hidden=YES;
            if ([model.num_state intValue]==1) {
                cell.jiaohao_imageV.image=[UIImage imageNamed:@"叫号绿"];
                cell.jiaohaoLab.text=@"叫号";
                cell.jiaohao_btn.enabled=YES;
            }
            else
            {
                cell.jiaohao_imageV.image=[UIImage imageNamed:@"叫号灰"];
                NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"叫号%@次",model.call_num]];
                
                [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2,model.call_num.length)];
                cell.jiaohaoLab.attributedText=AttributedStr;
                cell.jiaohao_btn.enabled=NO;
            }
            cell.guohao_btn.tag=indexPath.row;
            [cell.guohao_btn addTarget:self action:@selector(guohaoPress:) forControlEvents:UIControlEventTouchUpInside];
            cell.ruhao_btn.tag=indexPath.row;
            [cell.ruhao_btn addTarget:self action:@selector(ruhaoPress:) forControlEvents:UIControlEventTouchUpInside];
            cell.jiaohao_btn.tag=indexPath.row;
            [cell.jiaohao_btn addTarget:self action:@selector(jiaohaoPress:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            cell.view1.hidden=YES;
            cell.view2.hidden=NO;
            
            if ([typeNum isEqualToString:@"4"]) {
                cell.view2_hao_lab.text=@"未入座";
                cell.view2_hao_imagV.image=[UIImage imageNamed:@"已入座"];
                
                cell.view2_zuo_lab.text=@"已入号";
                cell.view2_zuo_imagV.image=[UIImage imageNamed:@"未过号"];
                
                cell.view2_zuo_imagV.hidden=NO;
                cell.view2_zuo_lab.hidden=NO;
                cell.view2_hao_lab.hidden=NO;
                cell.view2_hao_imagV.hidden=NO;
            }
            else
            {
                cell.view2_zuo_lab.text=@"已过号";
                cell.view2_zuo_imagV.image=[UIImage imageNamed:@"已过号"];
                
                cell.view2_zuo_imagV.hidden=NO;
                cell.view2_zuo_lab.hidden=NO;
                cell.view2_hao_lab.hidden=YES;
                cell.view2_hao_imagV.hidden=YES;
            }
        }
        
        if ([typeNum isEqualToString:@"3"]) {
            cell.state_imageV.image=[UIImage imageNamed:@"not_reached"];
        }
        else
        {
            cell.state_imageV.image=[UIImage imageNamed:@"location"];
        }
      return cell;
    }
    else
    {
        RowNumCell *cell=[tableView dequeueReusableCellWithIdentifier:@"RowNumCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        cell.nameLab.text=  [NSString stringWithFormat:@"%@ %@", model.number_show,model.take_info ];
        if ([typeNum isEqualToString:@"2"] ) {
            cell.view1.hidden=NO;
            cell.view2.hidden=YES;
            if ([model.num_state intValue]==1) {
                cell.jiaohao_imageV.image=[UIImage imageNamed:@"叫号绿"];
                cell.jiaohaoLab.text=@"叫号";
                cell.jiaohao_btn.enabled=YES;
            }
            else
            {
                cell.jiaohao_imageV.image=[UIImage imageNamed:@"叫号灰"];
                NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"叫号%@次",model.call_num]];
                
                [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2,model.call_num.length)];
                cell.jiaohaoLab.attributedText=AttributedStr;
                cell.jiaohao_btn.enabled=NO;
            }
            cell.guohao_btn.tag=indexPath.row;
            [cell.guohao_btn addTarget:self action:@selector(guohaoPress:) forControlEvents:UIControlEventTouchUpInside];
            cell.ruhao_btn.tag=indexPath.row;
            [cell.ruhao_btn addTarget:self action:@selector(ruhaoPress:) forControlEvents:UIControlEventTouchUpInside];
            cell.jiaohao_btn.tag=indexPath.row;
            [cell.jiaohao_btn addTarget:self action:@selector(jiaohaoPress:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            cell.view1.hidden=YES;
            cell.view2.hidden=NO;
            
            if ([typeNum isEqualToString:@"4"]) {
                cell.view2_hao_lab.text=@"未入座";
                cell.view2_hao_imagV.image=[UIImage imageNamed:@"已入座"];
                
                cell.view2_zuo_lab.text=@"已入号";
                cell.view2_zuo_imagV.image=[UIImage imageNamed:@"未过号"];
                
                cell.view2_zuo_imagV.hidden=NO;
                cell.view2_zuo_lab.hidden=NO;
                cell.view2_hao_lab.hidden=NO;
                cell.view2_hao_imagV.hidden=NO;
            }
            else
            {
                cell.view2_zuo_lab.text=@"已过号";
                cell.view2_zuo_imagV.image=[UIImage imageNamed:@"已过号"];
                
                cell.view2_zuo_imagV.hidden=NO;
                cell.view2_zuo_lab.hidden=NO;
                cell.view2_hao_lab.hidden=YES;
                cell.view2_hao_imagV.hidden=YES;
            }
        }
        
        if ([typeNum isEqualToString:@"3"]) {
            cell.state_imageV.image=[UIImage imageNamed:@"not_reached"];
        }
        else
        {
            cell.state_imageV.image=[UIImage imageNamed:@"location"];
        }
       return cell;
    }
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 82;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
     GetDesks *subModel=subDataArr[indexPath.row];
    
    RowNumDetail *detail=[[RowNumDetail alloc]init];
    detail.idStr=subModel.id;
    detail.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:detail animated:YES];
    
}
#pragma mark 过号 num_state 1 2
-(void)guohaoPress:(UIButton *)but
{
     GetDesks *subModel=subDataArr[but.tag];
        if ([subModel.num_state intValue]==1||[subModel.num_state intValue]==2) {
              [self numOperationTitle:@"叫号无人应答，确定过号？" type:@"过号" deskId:subModel.id];
        }
  
}
#pragma  mark 入号 num_state 2
-(void)ruhaoPress:(UIButton *)but
{
    GetDesks  *model =  subDataArr[but.tag];
    [self numOperationTitle:@"确定入号？" type:@"入号" deskId:model.id];
}
#pragma  mark 叫号 num_state 1
-(void)jiaohaoPress:(UIButton *)but
{
    
    GetDesks  *model =  subDataArr[but.tag];
    if ([model.num_state intValue]==1) {
        
     [MBProgressHUD showMessage:nil toView:self.view];
    ServerCallModel *call=[[ServerCallModel alloc]init];
    call.desk_id=model.id;
    call.num_state=@"2";
    [call ServerCallModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message ,id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code intValue]==200) {
            [MBProgressHUD showSuccess:message toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self getData];
            });
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError * _Nonnull error) {
      
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    }
}

-(void)numOperationTitle:(NSString *)title type:(NSString *)type deskId:(NSString *)deskId
{
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提醒" message:title preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
      
        ServerCallModel *call=[[ServerCallModel alloc]init];
        call.desk_id=deskId;
        if ([type isEqualToString:@"入号"]) {
                 call.num_state=@"4";
        }
        else
        {
              call.num_state=@"3";
        }
      
        [MBProgressHUD showMessage:nil toView:self.view];

        [call ServerCallModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message,id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code intValue]==200) {
                [MBProgressHUD showSuccess:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self getData];
                });
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError * _Nonnull error) {
        
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    
        
    }
    ]];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
