//
//  WorkDetail.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/18.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WorkDetail.h"
#import "WorkDetailTopView.h"
#import "BuyOutListCell.h"
#import "WorkDetailHeadView.h"
#import "WorkDetailBtnView.h"
#import "WorkMangerCell.h"
#import "WorkMangerDetailCell.h"
#import "LineDataCell.h"
#import "HistoryListCell.h"
#import "SIndexHeadInfo.h"
#import "HistoryDetailList.h"
#import "BuyIn.h"
#import "VideoList.h"
#import "BuyOutList.h"
#import "QuanYiOnSell.h"
#import "WorkDetailGroup.h"
#import "VideoGroupListView.h"
#import "ThingReportCell.h"
#import "AShare.h"
#import "UIWebView+UIWebView_LoadHighChart.h"
@interface WorkDetail ()<UITableViewDelegate,UITableViewDataSource>
{
    WorkDetailBtnView * HeadView1;
    NSString *sub_type;
    NSArray *arr;
    NSInteger tapNum;
    NSString *newStr;
    NSInteger wek_web_num;
    NSArray *colorArr;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property (strong, nonatomic) IBOutlet UIButton *sureBtn;
@property (strong, nonatomic) WorkDetailTopView * topView;

@end

@implementation WorkDetail

- (void)viewDidLoad {
    [super viewDidLoad];
     adjustsScrollViewInsets_NO(_mTable, self);

    [_mTable registerNib:[UINib nibWithNibName:@"BuyOutListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BuyOutListCell"];
      [_mTable registerNib:[UINib nibWithNibName:@"WorkMangerCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WorkMangerCell"];
      [_mTable registerNib:[UINib nibWithNibName:@"WorkMangerDetailCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WorkMangerDetailCell"];
       [_mTable registerNib:[UINib nibWithNibName:@"LineDataCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LineDataCell"];
     [_mTable registerNib:[UINib nibWithNibName:@"HistoryListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HistoryListCell"];
      [_mTable registerNib:[UINib nibWithNibName:@"ThingReportCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ThingReportCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
   
    sub_type=@"1";//默认项目介绍
    arr=[NSArray arrayWithObjects:@"净值额",@"营业额",@"权益值", nil];
    colorArr=[NSArray arrayWithObjects:@"#E62124",@"#20D8FF",@"#FFBD20", nil];
    wek_web_num=50;
    
    
    SIndexHeadInfo * info = [[SIndexHeadInfo alloc] init];
    info.headlines_id = @"1";
    [MBProgressHUD showMessage:nil toView:self.view];
    [info sIndexHeadInfoSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            SIndexHeadInfo * info = (SIndexHeadInfo *)data;
            
     
            self->newStr=info.data.content;
       
            [self->_mTable reloadData];
            
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    if ([_type isEqualToString:@"1"]) {
        [_sureBtn setTitle:@"立即买入" forState:UIControlStateNormal];
        
    }
    else
    {
      [_sureBtn setTitle:@"立即卖出" forState:UIControlStateNormal];
    }
    if ([_isGroup isEqualToString:@"1"]) {
         self.title=@"项目组详情";
    }
    else
    {
          self.title=@"项目详情";
    }
    
    [self createNav];
}


- (void)createNav {
    
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    UIBarButtonItem * rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
 
    [rightBtn setImage:[UIImage imageNamed:@"分享黑"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.navigationItem.rightBarButtonItem =rightBtnItem ;
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"黑色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    
    [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];

    
}
-(void)rightBtnClick
{
    AShare * shareVC = [[AShare alloc] init];
    shareVC.thisUrl = @"https://www.baidu.com";
    shareVC.thisImage = @"http://test.wujiemall.com/Uploads/Ads/2018-04-15/5ad2d223f374c.jpg";
    shareVC.thisTitle = @"无界掌柜";
    shareVC.thisContent = @"选择无界掌柜，您无悔的选择";
    shareVC.thisType = @"1";
    shareVC.id_val = @"1";
    shareVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    shareVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:shareVC animated:YES completion:nil];
    shareVC.AShare_back = ^{
        //        [backGroundView removeFromSuperview];
        //        [view removeFromSuperview];
    };
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([sub_type isEqualToString:@"2"]||[sub_type isEqualToString:@"4"]) {
        return 4;
    }
  else
  {
    return 5;
  }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
            
        case 0:  //转让信息
            return 3;
            break;
       
        case 1://历史成交价格
            return 1;
            break;
        case 2: //历史收益记录
            return 3;
            break;
        case 3://项目介绍与规则说明
        {
            if ([sub_type isEqualToString:@"2"]) {
                    return 3;  //数据统计
            }
          else  if ([sub_type isEqualToString:@"4"]) {
                return 1; //大事记
            }
            else
            {
                return 3;//项目管理者
            }
          
        }
        
            break;
        case 4:
            return 1;  //项目详情
            break;
        default:
            break;
    }
    return 0;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        if ([_isGroup isEqualToString:@"1"]) {
            return 617;  //项目组
        }
        else
        {
            return 617-133; //隐藏项目组项目
        }
        
        
    }
    else if (section>0&&section<=3)
    {
      
        
        return 50;
    }
  
    return 10;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section==0) {
        double yy;
        if ([_isGroup isEqualToString:@"1"]) {
          yy= 617;
        }
        else
        {
           yy= 617-133;
        }
       _topView=[[WorkDetailTopView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, yy)];
        [_topView.topImage sd_setImageWithURL:[NSURL URLWithString:@"http://test.wujiemall.com/Uploads/Ads/2018-04-15/5ad2d223f374c.jpg"] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
       _topView.progressView.hidden=YES;
       _topView.progressViewHH.constant=0;
     
        if ([_isGroup isEqualToString:@"1"]) {
            _topView.colViewHHH.constant=133;
            _topView.colView.hidden=NO;
      
        }
        else
        {
            _topView.colViewHHH.constant=0;
            _topView.colView.hidden=YES;
         
        }
        _topView.isGroup=_isGroup;
       [_topView.BuyOutBtn addTarget:self action:@selector(BuyOutPress) forControlEvents:UIControlEventTouchUpInside];
          __weak typeof(self) weakSelf = self;
        _topView.workDetailEntryBlock = ^(NSString * _Nonnull typeModel) {
#pragma mark 项目组详情
            WorkDetailGroup *detail=[[WorkDetailGroup alloc]init];
            [weakSelf.navigationController pushViewController:detail animated:YES];
        
        };
        
        return _topView;
    }
    else if (section>0&&section<=2)
    {
// 历史成交价格 历史收益记录
        WorkDetailHeadView * topView=[[WorkDetailHeadView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
        if (section==1) {
            topView.flag_imageView.hidden=YES;
            topView.titleLab.text=@"历史成交价格";
            topView.subTitleLab.text=@"单位(元)";
        }
       else  {
            topView.flag_imageView.hidden=NO;
            topView.titleLab.text=@"历史收益记录";
            topView.subTitleLab.hidden=YES;
           [topView.HeadViewBtn addTarget:self action:@selector(historyPress) forControlEvents:UIControlEventTouchUpInside];
        }
        return topView;
    }
    else if (section==3)
    {
       // 项目介绍 数据统计 大事记 规格说明
      HeadView1=[[WorkDetailBtnView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
        if ([sub_type isEqualToString:@"1"]) {
            HeadView1.but1.selected=YES;
            HeadView1.but2.selected=NO;
            HeadView1.but3.selected=NO;
            HeadView1.but4.selected=NO;
            HeadView1.centerLine1.hidden= NO ;
            HeadView1.centerLine2.hidden=YES;
            HeadView1.centerLine3.hidden=YES;
            HeadView1.centerLine4.hidden=YES;
        }
        else  if([sub_type isEqualToString:@"2"])
        {
            HeadView1.but1.selected=NO;
            HeadView1.but2.selected=YES;
            HeadView1.but3.selected=NO;
            HeadView1.but4.selected=NO;
            HeadView1.centerLine1.hidden= YES ;
            HeadView1.centerLine2.hidden=NO;
            HeadView1.centerLine3.hidden=YES;
            HeadView1.centerLine4.hidden=YES;
        }
        else if([sub_type isEqualToString:@"3"])
        {
            HeadView1.but1.selected=NO;
            HeadView1.but2.selected=NO;
            HeadView1.but3.selected=YES;
            HeadView1.but4.selected=NO;
            HeadView1.centerLine1.hidden= YES ;
            HeadView1.centerLine2.hidden=YES;
            HeadView1.centerLine3.hidden=NO;
            HeadView1.centerLine4.hidden=YES;
        }
        else
        {
            HeadView1.but1.selected=NO;
            HeadView1.but2.selected=NO;
            HeadView1.but3.selected=NO;
            HeadView1.but4.selected=YES;
            HeadView1.centerLine1.hidden= YES ;
            HeadView1.centerLine2.hidden=YES;
            HeadView1.centerLine3.hidden=YES;
            HeadView1.centerLine4.hidden=NO;
        }
        [HeadView1.but1 addTarget:self action:@selector(selectBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        [HeadView1.but2 addTarget:self action:@selector(selectBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        [HeadView1.but3 addTarget:self action:@selector(selectBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        [HeadView1.but4 addTarget:self action:@selector(selectBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        return HeadView1;
    }
    else
    {
        UIView * topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        topView.backgroundColor=[UIColor whiteColor];
        
        return topView;
    }
   
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section==0||section==2) {
         return 10;
    }
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0)
    {
        return 59;  //权益转让信息
    }
    else if (indexPath.section==1) {
      
        return 305;  //历史成交价格
    }
    else if (indexPath.section==2) {
     
        return 66; //历史收益记录
    }
    else if (indexPath.section==3) {
        if ([sub_type isEqualToString:@"2"]) {
            return 305;  //数据统计
        }
        else  if ([sub_type isEqualToString:@"4"]) {
            return 4*80*2+2*35;//大事记
        }
        else
        {
            //项目管理者
        if (indexPath.row==0) {
             return 75;
        }
        else
        {
            return 41;
        }
        }
    }
    else  {
        return wek_web_num+30;//项目详情
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        //权益转让记录
        BuyOutListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BuyOutListCell" forIndexPath:indexPath];
        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:@"http://dev.wujiemall.com/Uploads/Merchant/2019-03-06/5c7f5beca8470.jpg"] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        [cell.jiaobtn addTarget:self action:@selector(jiaoyiPress:) forControlEvents:UIControlEventTouchUpInside];
        cell.jiaobtn.tag=indexPath.row;
        return cell;
    }
   else if (indexPath.section==1) {
       //历史成交价格
        LineDataCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LineDataCell" forIndexPath:indexPath];
      cell.titleDic=@{@"title":@"历史成交价格",@"color":@"#ff6553"};
     cell.titleLab.text=@"";
       if (_mTable.dragging==NO && _mTable.decelerating==NO) {
           [cell.web loadHightChart];
       }
        return cell;
    }
   else if (indexPath.section==2) {
       //历史收益记录
       HistoryListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryListCell" forIndexPath:indexPath];
       

       return cell;
   }
   else if (indexPath.section==3) {
       if ([sub_type isEqualToString:@"2"]) {
           //数据统计
        LineDataCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LineDataCell" forIndexPath:indexPath];
       cell.titleDic=@{@"title":arr[indexPath.row],@"color":colorArr[indexPath.row]};
           //lazy加载
           if (_mTable.dragging==NO && _mTable.decelerating==NO) {
               [cell.web loadHightChart];
           }

 
        NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"I %@",arr[indexPath.row]]];
           [AttributedStr addAttribute:NSForegroundColorAttributeName value:navigationColor range:NSMakeRange(0,1)];
            [AttributedStr addAttribute:NSBackgroundColorAttributeName value:navigationColor range:NSMakeRange(0,1)];
           //NSTextAttachment可以将要插入的图片作为特殊字符处理
           NSTextAttachment *attch = [[NSTextAttachment alloc] init];
           //定义图片内容及位置和大小
            attch.image = [UIImage imageNamed:@"问号"];
           attch.bounds = CGRectMake(0, 0, 15, 15);
           //创建带有图片的富文本
           NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
           //将图片放在最后一位
           [AttributedStr appendAttributedString:string];
           cell.titleLab.attributedText = AttributedStr;
           [ cell.titleLab addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap:)]];
           cell.titleLab.userInteractionEnabled = YES;
           cell.titleLab.tag=indexPath.row;
           return cell;
       }
      if ([sub_type isEqualToString:@"4"]) {
          //大事记
          ThingReportCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ThingReportCell" forIndexPath:indexPath];
          return cell;
      }
       else
       {
           //项目管理者
       WorkMangerCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WorkMangerCell" forIndexPath:indexPath];
       if (indexPath.row==0) {
           cell.topHHH.constant=33.5;
           cell.titleLab.hidden=NO;
       }
       else
       {
           cell.topHHH.constant=0;
           cell.titleLab.hidden=YES;
       }
       
       return cell;
       }
   }
   else  {
       //项目详情
       WorkMangerDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WorkMangerDetailCell" forIndexPath:indexPath];
        [cell wk_web:newStr];
       cell.data_HTML  = ^(NSInteger num) {
           self->wek_web_num = num + 15;
           [self->_mTable reloadData];
           
           
       };
       
       return cell;
   }
}
#pragma mark scrollView 代理
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
      [self loadwebView];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
  [self loadwebView];
}
-(void)loadwebView
{
      NSArray * visibleCells = [_mTable visibleCells];
    for (UITableViewCell *cell in visibleCells) {
        if ([cell isKindOfClass:[LineDataCell class]]) {
            LineDataCell * cell1 = (LineDataCell *) cell;
            [cell1.web loadHightChart];
        }
    }

}
#pragma mark 按钮选择
-(void)selectBtnPress:(UIButton *)but
{
    if (but.selected) {
        return;
    }
    else{
        but.selected=YES;

        for (UIButton *button in HeadView1.subviews) {
            if ([button isKindOfClass:[UIButton class]]) {
                button.selected=NO;
            }
            
        }
        sub_type=[NSString stringWithFormat:@"%d",(int)but.tag];
        [_mTable reloadData];
    }
}
#pragma  mark 数据统计 点击❓
-(void)labelTap:(UITapGestureRecognizer *)sender{
    NSLog(@"ssssss %@", arr[sender.view.tag] ) ;

    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"此处是该数据表的具体说明" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:cancelAction];
  
    [self presentViewController:alertVC animated:YES completion:nil];
}
#pragma  mark   历史收益记录 更多
-(void)historyPress
{
    HistoryDetailList *list=[[HistoryDetailList alloc]init];
    [self.navigationController pushViewController:list animated:YES];
}
#pragma mark 立即买入 卖出
- (IBAction)buyPress:(id)sender {
    if ([_type isEqualToString:@"1"]) {
        
        QuanYiOnSell*list=[[QuanYiOnSell alloc]init];
        [self.navigationController pushViewController:list animated:YES];
    }
    else
    {
        BuyIn * list=[[BuyIn alloc]init];
        list.type=@"2";
        [self.navigationController pushViewController:list animated:YES];
    }
   
}
#pragma mark 视察
- (IBAction)videoList:(id)sender {
    
    if ([_isGroup isEqualToString:@"1"]) {
        VideoGroupListView *list=[[VideoGroupListView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
         __weak typeof(self) weakSelf = self;
        list.videoEntryBlock = ^(NSString * _Nonnull typeModel) {
            VideoList * list=[[VideoList alloc]init];
            [weakSelf.navigationController pushViewController:list animated:YES];
        };
        [self.view.window addSubview:list];
    }
    else
    {
        VideoList * list=[[VideoList alloc]init];
        [self.navigationController pushViewController:list animated:YES];
    }
    

 
}
#pragma mark 关注
- (IBAction)guanzhuPress:(id)sender {
    UIButton *but=(UIButton *)sender;
    but.selected=!but.selected;
    
}
#pragma mark  权益转让信息 更多
-(void)BuyOutPress
{
    BuyOutList  * list=[[BuyOutList alloc]init];
    [self.navigationController pushViewController:list animated:YES];
}
#pragma mark 权益转让信息 交易
-(void)jiaoyiPress:(UIButton *)but
{
    BuyIn * list=[[BuyIn alloc]init];
    list.type=_type;
    [self.navigationController pushViewController:list animated:YES];
}
@end
