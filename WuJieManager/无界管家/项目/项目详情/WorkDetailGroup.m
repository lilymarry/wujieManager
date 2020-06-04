//
//  WorkDetailGroup.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/24.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WorkDetailGroup.h"
#import "WorkDetailTopView.h"
#import "WorkDetailBtnView.h"
#import "WorkMangerCell.h"
#import "WorkMangerDetailCell.h"
#import "LineDataCell.h"
#import "SIndexHeadInfo.h"
#import "UIWebView+UIWebView_LoadHighChart.h"
@interface WorkDetailGroup ()<UITableViewDelegate,UITableViewDataSource>
{
    WorkDetailBtnView * HeadView1;
    NSString *sup_type;
    NSArray *arr;
    NSInteger tapNum;
    NSString *newStr;
    NSInteger wek_web_num;
       NSArray *colorArr;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;

@property (strong, nonatomic) WorkDetailTopView * topView;

@end

@implementation WorkDetailGroup

- (void)viewDidLoad {
    [super viewDidLoad];
   adjustsScrollViewInsets_NO(_mTable, self);
    
    [_mTable registerNib:[UINib nibWithNibName:@"WorkMangerCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WorkMangerCell"];
    [_mTable registerNib:[UINib nibWithNibName:@"WorkMangerDetailCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WorkMangerDetailCell"];
    [_mTable registerNib:[UINib nibWithNibName:@"LineDataCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LineDataCell"];

    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    sup_type=@"1";
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
 
    self.title=@"项目详情";
    
    [self createNav];
}
- (void)createNav {
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"黑色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    
    [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([sup_type isEqualToString:@"2"]) {
        return 2;
    }
    return 3;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return 0;
    }
    else  if (section==1) {
        if ([sup_type isEqualToString:@"2"]) {
            return 3;
            
        }
        else
        {
             return 5;
        }
    }
    
    else
    {
      return 1;
    }
    
    return 0;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
       
            return 617-133-50-20;
    
    }
    else if (section==1)
    {
        
        
        return 50;
    }
    
    return 10;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section==0) {
      
        _topView=[[WorkDetailTopView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 617-133-50)];
        [_topView.topImage sd_setImageWithURL:[NSURL URLWithString:@"http://test.wujiemall.com/Uploads/Ads/2018-04-15/5ad2d223f374c.jpg"] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        _topView.progressView.hidden=YES;
        _topView.progressViewHH.constant=0;
        _topView.colViewHHH.constant=0;
        _topView.colView.hidden=YES;
        _topView.collection.hidden=YES;
        _topView.quanyiView.hidden=YES;
       _topView.quanyiViewHHH.constant=0;
        
        
        return _topView;
    }

    else if (section==1)
    {
        HeadView1=[[WorkDetailBtnView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
         HeadView1.but2.hidden=YES;
        HeadView1.centerLine2.hidden=YES;
        HeadView1.but4.hidden=YES;
        HeadView1.centerLine4.hidden=YES;
        
        [HeadView1.but1 setTitle:@"项目介绍" forState:UIControlStateNormal];
         [HeadView1.but1 setTitle:@"项目介绍" forState:UIControlStateSelected];
        [HeadView1.but3 setTitle:@"数据统计" forState:UIControlStateNormal];
         [HeadView1.but3 setTitle:@"数据统计" forState:UIControlStateSelected];
        if ([sup_type isEqualToString:@"1"]) {
            
            HeadView1.but1.selected=YES;
        
            HeadView1.but3.selected=NO;
            
            HeadView1.centerLine1.hidden= NO ;
          
            HeadView1.centerLine3.hidden=YES;
        }
        else
        {
            HeadView1.but1.selected=NO;
           
            HeadView1.but3.selected=YES;
            HeadView1.centerLine1.hidden= YES ;
        
            HeadView1.centerLine3.hidden=NO;
        }
      
        [HeadView1.but1 addTarget:self action:@selector(selectBtnPress:) forControlEvents:UIControlEventTouchUpInside];
      
        [HeadView1.but3 addTarget:self action:@selector(selectBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        
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
        return 0.01;
    }
    else if (indexPath.section==1) {
        if ([sup_type isEqualToString:@"2"]) {
            return 305;
            
        }
        else
        {
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
        return wek_web_num+30;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
       LineDataCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LineDataCell" forIndexPath:indexPath];
        if (_mTable.dragging==NO && _mTable.decelerating==NO) {
            [cell.web loadHightChart];
        }
        return cell;
    }
 
    else if (indexPath.section==1) {
        if ([sup_type isEqualToString:@"2"]) {
            LineDataCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LineDataCell" forIndexPath:indexPath];
         
           
          cell.titleDic=@{@"title":arr[indexPath.row],@"color":colorArr[indexPath.row]};
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
        
        else
        {
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
        WorkMangerDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WorkMangerDetailCell" forIndexPath:indexPath];
        if (newStr.length>0) {
              [cell wk_web:newStr];
        }
      
        cell.data_HTML  = ^(NSInteger num) {
            self->wek_web_num = num + 15;
            [self->_mTable reloadData];
            
            
        };
        
        return cell;
    }
}
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
        if (but.tag==1) {
            sup_type=@"1";
            
        }

        else
        {
            sup_type=@"2";
            
        }
        [_mTable reloadData];
    }
}
-(void)labelTap:(UITapGestureRecognizer *)sender{
    NSLog(@"ssssss %@", arr[sender.view.tag] ) ;
    
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"此处是该数据表的具体说明" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:cancelAction];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}
#pragma mark - 延迟加载关键
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

@end
