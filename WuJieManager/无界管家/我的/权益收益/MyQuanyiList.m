//
//  MyQuanyiList.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/22.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "MyQuanyiList.h"
#import "MyQuanyiListCell.h"
#import "MyQuanyiDetail.h"
#import "MyQuanyiShiZhiDetail.h"
@interface MyQuanyiList ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *mTable;


@end

@implementation MyQuanyiList

- (void)viewDidLoad {
    [super viewDidLoad];
    adjustsScrollViewInsets_NO(_mTable, self);
    [_mTable registerNib:[UINib nibWithNibName:@"MyQuanyiListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyQuanyiListCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    if ([_type isEqualToString:@"1"]) {
        self.title=@"权益收益";
    }
    else
    {
       self.title=@"权益市值";
    }
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_type isEqualToString:@"1"]) {
         return 274;
    }
    else
    {
        return 174;
    }
    
   
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyQuanyiListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyQuanyiListCell" forIndexPath:indexPath];
    if (indexPath.row==4) {
        cell.subTitle.text=@"筹备中";
        cell.subTitle.layer.borderColor =color(0, 162, 255).CGColor;
        cell.subTitle.backgroundColor=color(199, 233, 254);
        cell.subTitle.textColor=color(0, 162, 255);
    }
    else
    {
          cell.subTitle.text=@"已营业";
      
         cell.subTitle.layer.borderColor =color(255, 75, 0).CGColor;
         cell.subTitle.backgroundColor=color(254, 215, 199);
        cell.subTitle.textColor=color(225, 75, 0);
    }
    
    if ([_type isEqualToString:@"1"]) {
        cell.view2HH.constant=98;
        cell.view2.hidden=NO;
        
    NSString *str1 =@"186";
    NSString *str2 =@"权益收益(元)";
    NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n%@",str1,str2]];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:115/255.0 blue:32/255.0 alpha:1] range:NSMakeRange(0 , str1.length)];
    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0 , str1.length)];
    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(str1.length , str2.length)];
    [cell.quanyiLab setAttributedText:AttributedStr];
        
    
        NSString *str0 =@"70";
        NSString *str0_1 =@"发券收益(元)";
        NSMutableAttributedString * AttributedStr0 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n%@",str0,str0_1]];
        [AttributedStr0 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0 , str0.length)];
        [AttributedStr0 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0 , str0.length)];
        [cell.fajuanLab setAttributedText:AttributedStr0];
    
    NSString *str3 =@"94";
    NSString *str4 =@"分红收益(元)";
    NSMutableAttributedString * AttributedStr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n%@",str3,str4]];
    [AttributedStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0 , str3.length)];
    [AttributedStr1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0 , str3.length)];
    cell.fenhongLab .attributedText=AttributedStr1;
    
    NSString *str5 =@"50";
    NSString *str6 =@"省钱收益(元)";
    
    NSMutableAttributedString * AttributedStr2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n%@",str5,str6]];
    [AttributedStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0 , str5.length)];
    [AttributedStr2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0 , str5.length)];
    cell.shenqianLab .attributedText=AttributedStr2;
    
    
    NSString *str7 =@"32";
    NSString *str8 =@"转卖收益(元)";
    
    NSMutableAttributedString * AttributedStr3 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n%@",str7,str8]];
    [AttributedStr3 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0 , str7.length)];
    [AttributedStr3 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0 , str7.length)];
    cell.zhuanMaiLab .attributedText=AttributedStr3;
        
       
    }
    else
    {
        cell.view2HH.constant=0;
        cell.view2.hidden=YES;
        
        cell.quanyiLab.hidden=YES;
        
        NSString *str1 =@"186";
        NSString *str2 =@"权益市值(元)";
        NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n%@",str1,str2]];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:115/255.0 blue:32/255.0 alpha:1] range:NSMakeRange(0 , str1.length)];
        [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0 , str1.length)];
        [cell.fajuanLab setAttributedText:AttributedStr];
        
        
        NSString *str3 =@"94";
        NSString *str4 =@"持有份数";
        NSMutableAttributedString * AttributedStr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n%@",str3,str4]];
        [AttributedStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0 , str3.length)];
        [AttributedStr1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0 , str3.length)];
        cell.fenhongLab .attributedText=AttributedStr1;
        
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_type isEqualToString:@"1"]) {
        //权益收益
        MyQuanyiDetail*detail=[[MyQuanyiDetail alloc]init];
        [self.navigationController pushViewController:detail animated:YES];
    }
    else
    {
        //权益市值
        MyQuanyiShiZhiDetail*detail=[[MyQuanyiShiZhiDetail alloc]init];
        [self.navigationController pushViewController:detail animated:YES];
    }
   
}

@end
