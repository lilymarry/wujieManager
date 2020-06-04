//
//  TakeAway.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/5.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "TakeAway.h"
#import "TakeAwayCell1.h"
#import "TakeAwayBtn.h"
#import "OrderDetail.h"
#import "ComplainList.h"
#import "ComplainListView.h"
#import "ExitView.h"
@interface TakeAway ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSInteger typeNum;
    UIScrollView      *scrollViewText;
    NSArray *titleData;
}

@property (strong, nonatomic)IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UICollectionView *mCollect;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomHH;

@end

@implementation TakeAway

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    adjustsScrollViewInsets_NO(_mCollect, self);
    typeNum=0;
    
    _mCollect.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [_mCollect registerNib:[UINib nibWithNibName:@"TakeAwayCell1" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"TakeAwayCell1"];
    self.title=@"RED COCK(华苑店)";
   
    titleData=@[
                @{
                    @"name"   :@" 全部 ",
                    @"num"  :@"8"
                    },
                @{
                    @"name"   :@" 新订单 ",
                    @"num"  :@"20"
                    },
                @{
                    @"name"   :@" 待配送 ",
                    @"num"  :@"6"
                    },
                @{
                    @"name"   :@" 待取货 ",
                    @"num"  :@"2"
                    }
                ,
                @{
                    @"name"   :@" 配送中 ",
                    @"num"  :@"2"
                    },
                
                @{
                    @"name"   :@" 已完成 ",
                    @"num"  :@"10"
                    },
                @{
                    @"name"   :@" 已过期 ",
                    @"num"  :@"20"
                    },
                @{
                    @"name"   :@" 已取消 ",
                    @"num"  :@"6"
                    },
                @{
                    @"name"   :@" 异常单 ",
                    @"num"  :@"2"
                    }
                ,
                @{
                    @"name"   :@" 退款单 ",
                    @"num"  :@"2"
                    }
                ];
    
    [self initScrollText];
    NSString *version= [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >=10.0&&version.doubleValue <11.0) {
        _bottomHH.constant=50;
        
    }
    else
    {
        _bottomHH.constant=0;
        
    }
    
    [self createNav];
}
- (void)createNav {
    self.title=[[LoginModel shareInstance] getUserInfo].user_info.merchant_name ;
    

    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 130, 50);
    
     [lefthBtn addTarget:self action:@selector(lefthBtn2Click) forControlEvents:UIControlEventTouchUpInside];
//    [lefthBtn1 setImage:[UIImage imageNamed:@"白色返回"] forState:UIControlStateNormal];
 //   lefthBtn1.imageEdgeInsets = UIEdgeInsetsMake(0,  -20, 0, 0);
    
  //  [lefthBtn1 addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
 //   UIBarButtonItem * leftBtnItem1 = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn1];
    
      self.navigationItem.leftBarButtonItem = leftBtnItem;
//    if ([_type isEqualToString:@"2"]) {
//        self.navigationItem.leftBarButtonItems = @[leftBtnItem1,leftBtnItem];
//    }
//    else
//    {
//        self.navigationItem.leftBarButtonItem = leftBtnItem;
//    }
    
    
    
  UIImageView *  _headImaView=[[UIImageView alloc ]initWithFrame:CGRectMake(0, 10, 30, 30)];
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

    
}
-(void)lefthBtn2Click
{
    ExitView *view=[[ExitView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    [self.view.window addSubview:view];
}
//文字初始化
-(void) initScrollText{
    
    [scrollViewText removeFromSuperview];
    
    //获取滚动条
    
    if(!scrollViewText){
        scrollViewText = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW ,50)];
        scrollViewText.showsHorizontalScrollIndicator = YES;   //隐藏水平滚动条
        scrollViewText.showsVerticalScrollIndicator = YES;     //隐藏垂直滚动条
        
        //横竖屏自适应
        scrollViewText.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        [scrollViewText setBackgroundColor:[UIColor whiteColor]];
        
        //添加到当前视图
        [_titleView addSubview:scrollViewText];
    }else{
        //清除子控件
        for (UIView *view in [scrollViewText subviews]) {
            [view removeFromSuperview];
        }
    }
    
    if (titleData) {
        
        CGFloat offsetX = 0 ,i = 0, h = 50;
        
        //设置滚动文字
        TakeAwayBtn *btnText = nil;
        NSString *strTitle = [[NSString alloc] init];
        
        for (   NSDictionary  *model in titleData) {
            
            strTitle =model[@"name"];
            
            btnText = [TakeAwayBtn buttonWithType:UIButtonTypeCustom];
            [btnText setFrame:CGRectMake([self getTitleLeft:i],
                                         0,
                                         strTitle.length * 18.0f,
                                         h)];
            
            
            [btnText setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
               [btnText setTitleColor:navigationHotelColor forState:UIControlStateSelected];
   
            [btnText setTitle:strTitle forState:UIControlStateNormal];
            btnText.titleLabel.font = [UIFont systemFontOfSize: 12.0];
            
            //横竖屏自适应
            //  btnText.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            offsetX +=CGRectGetWidth(btnText.bounds) ;
            btnText.userInteractionEnabled = YES;
            
            btnText.tag=i;
            [btnText addTarget:self action:@selector(selectTitle:) forControlEvents:UIControlEventTouchUpInside];
            //    btnText.layer.cornerRadius = 10;
            //   btnText.layer.masksToBounds = YES;
            //   btnText.layer.borderWidth = 1;
            // btnText.layer.borderColor = [UIColor lightGrayColor].CGColor;
            //添加到滚动视图
            [scrollViewText addSubview:btnText];
                        UILabel *lab=[[UILabel alloc ]initWithFrame:CGRectMake(CGRectGetMaxX(btnText.bounds)-20, 5, 20, 20)];
            lab.backgroundColor=navigationHotelColor;
            lab.textColor=[UIColor whiteColor];
            lab.text=model[@"num"];
            lab.font = [UIFont systemFontOfSize:10.0];
            //  [lab sizeToFit];
            lab.textAlignment=NSTextAlignmentCenter;
            lab.layer.cornerRadius = lab.frame.size.width/2;
            lab.layer.masksToBounds = YES;
            //    btnText.layer.borderWidth = 1;
            //   btnText.layer.borderColor = [UIColor lightGrayColor].CGColor;
            lab.adjustsFontSizeToFitWidth = YES;
            
            [btnText addSubview:lab];
            btnText.selected=NO;
             btnText.lineView.hidden=YES;
            if (i==0) {
                btnText.selected=YES;
                btnText.lineView.hidden=NO;
              //  [btnText setBackgroundColor:[UIColor whiteColor]];
                
            }
            
            
            
            i++;
        }

        [scrollViewText setContentSize:CGSizeMake(offsetX+25*titleData.count, 0)];
    }
}
-(float) getTitleLeft:(CGFloat) i {
    float left = i * 5.0f;
    
    if (i > 0) {
        for (int j = 0; j < i; j ++) {
            NSDictionary *model=[titleData objectAtIndex:j];
            NSString *   strTitle =model[@"name"] ;
            left += [strTitle length] * 18.0f;
        }
    }
    return left;
}
#pragma mark scrollView 按钮响应事件
-(void)selectTitle:(TakeAwayBtn *)but
{
    if (but.selected) {
        return;
    }
    else
    {
      // but.backgroundColor=[UIColor whiteColor];
         but.selected=YES;
         but.lineView.hidden=NO;
        for (TakeAwayBtn *button in scrollViewText.subviews) {
            if ([button isKindOfClass:[TakeAwayBtn class]]) {
                if (button.tag!=but.tag) {
                    button.selected=NO;
                    button.lineView.hidden=YES;
                  //  button.backgroundColor=[UIColor groupTableViewBackgroundColor];
                    
                }
                
            }
        }
    }
    NSString  *model= titleData[ but.tag];
  
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 12;
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (IS_PAD) {
        
        return CGSizeMake(ScreenW/2-5,243);
    }
    else
    {
        
        return CGSizeMake(ScreenW-10,243);
        
    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
        TakeAwayCell1 * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TakeAwayCell1" forIndexPath:indexPath];
        if (indexPath.row==0) {
            [cell.stateBtn setTitle:@"新订单" forState:UIControlStateNormal];
            cell.reasonFlagView.hidden=YES;
            cell.reasonLab.hidden=YES;
            cell.reasonFlagViewHH.constant=0;
            cell.oneBtn.hidden=NO;
            cell.twoBtn.hidden=NO;
            [cell.oneBtn  setTitle:@"立即接单" forState:UIControlStateNormal];
            [cell.twoBtn  setTitle:@"拒绝接单" forState:UIControlStateNormal];
        }
        else if (indexPath.row==1) {
            [cell.stateBtn setTitle:@"待配送" forState:UIControlStateNormal];
            cell.reasonFlagView.hidden=YES;
            cell.reasonLab.hidden=YES;
            cell.reasonFlagViewHH.constant=0;
            cell.oneBtn.hidden=NO;
            cell.twoBtn.hidden=YES;
            cell.oneBtn.hidden=YES;
            cell.twoBtn.hidden=YES;
        }
        else if (indexPath.row==2) {
            [cell.stateBtn setTitle:@"待取货" forState:UIControlStateNormal];
            
            cell.reasonFlagView.hidden=YES;
            cell.reasonLab.hidden=YES;
            cell.reasonFlagViewHH.constant=0;
            cell.oneBtn.hidden=NO;
            cell.twoBtn.hidden=YES;
            [cell.oneBtn  setTitle:@"订单投诉" forState:UIControlStateNormal];
        }
        else if (indexPath.row==3) {
            [cell.stateBtn setTitle:@"退款中" forState:UIControlStateNormal];
            cell.reasonFlagView.hidden=NO;
            cell.reasonLab.hidden=NO;
            cell.reasonFlagViewHH.constant=15;
            cell.oneBtn.hidden=YES;
            cell.twoBtn.hidden=YES;
            
        }
        else if (indexPath.row==4) {
            [cell.stateBtn setTitle:@"待退款" forState:UIControlStateNormal];
            cell.reasonFlagView.hidden=NO;
            cell.reasonLab.hidden=NO;
            cell.reasonFlagViewHH.constant=15;
            cell.oneBtn.hidden=NO;
            cell.twoBtn.hidden=NO;
            [cell.oneBtn  setTitle:@"同意退款" forState:UIControlStateNormal];
            [cell.twoBtn  setTitle:@"拒绝退款" forState:UIControlStateNormal];
        }
        else if (indexPath.row==5) {
            [cell.stateBtn setTitle:@"已过期" forState:UIControlStateNormal];
            cell.reasonFlagView.hidden=YES;
            cell.reasonLab.hidden=YES;
            cell.reasonFlagViewHH.constant=0;
            cell.oneBtn.hidden=YES;
            cell.twoBtn.hidden=YES;
            
        }
        else if (indexPath.row==6) {
            [cell.stateBtn setTitle:@"已取消" forState:UIControlStateNormal];
            cell.reasonFlagView.hidden=YES;
            cell.reasonLab.hidden=YES;
            cell.reasonFlagViewHH.constant=0;
            cell.oneBtn.hidden=YES;
            cell.twoBtn.hidden=YES;
        }
        else if (indexPath.row==7) {
            [cell.stateBtn setTitle:@"已完成" forState:UIControlStateNormal];
            cell.reasonFlagView.hidden=YES;
            cell.reasonLab.hidden=YES;
            cell.reasonFlagViewHH.constant=0;
            cell.oneBtn.hidden=YES;
            cell.twoBtn.hidden=YES;
        }
        else if (indexPath.row==8) {
            [cell.stateBtn setTitle:@"妥投异常" forState:UIControlStateNormal];
            cell.reasonFlagView.hidden=YES;
            cell.reasonLab.hidden=YES;
            cell.reasonFlagViewHH.constant=0;
            cell.oneBtn.hidden=YES;
            cell.twoBtn.hidden=YES;
        }
        else
        {
            [cell.stateBtn setTitle:@"妥投异常" forState:UIControlStateNormal];
            cell.reasonFlagView.hidden=YES;
            cell.reasonLab.hidden=YES;
            cell.reasonFlagViewHH.constant=0;
            cell.oneBtn.hidden=YES;
            cell.twoBtn.hidden=YES;
        }
        cell.oneBtn.tag=indexPath.row;
        cell.twoBtn.tag=indexPath.row;
        [cell.oneBtn addTarget:self action:@selector(onePress:) forControlEvents:UIControlEventTouchUpInside];
        [cell.twoBtn addTarget:self action:@selector(twoPress:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
  
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TakeAwayCell1 *cell=(TakeAwayCell1 *)[collectionView cellForItemAtIndexPath:indexPath];
        OrderDetail *detail=[[OrderDetail alloc]init];
        detail.hidesBottomBarWhenPushed=YES;
        detail.type=cell.stateBtn.titleLabel.text;
        [self.navigationController pushViewController:detail animated:YES];
}
-(void)onePress:(UIButton *)btn
{
    if ([btn.titleLabel.text isEqualToString:@"订单投诉"]) {
        
        if (IS_PAD) {
            ComplainListView *view=[[ComplainListView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
            [self. view.window addSubview:view];
        }
        else
        {
            ComplainList *list=[[ComplainList alloc]init];
            list.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:list animated:YES];
        }}
    
}
-(void)twoPress:(UIButton *)btn
{
  
}
@end
