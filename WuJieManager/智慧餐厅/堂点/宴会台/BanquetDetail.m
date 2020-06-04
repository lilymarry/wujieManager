//
//  BanquetDetail.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/9.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "BanquetDetail.h"
#import "OrderDetailContentCell.h"

@interface BanquetDetail ()<UITableViewDelegate,UITableViewDataSource>
{
      NSArray *infoData;
    
}
@property (weak, nonatomic) IBOutlet UITableView *mTable;

@end

@implementation BanquetDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([OrderDetailContentCell class]) bundle:nil] forCellReuseIdentifier:@"OrderDetailContentCell"];
    [self createNav];
    self.title=@"查看详情";
    [self getData];
}
-(void)getData
{
    NSArray *arr1=@[
               @{
                   @"name"   :@"预定类型",
                   @"content"  :@"中餐、自助餐、国宴"
                   },
               @{
                   @"name"   :@"预订人",
                   @"content"  :@"王晓晓"
                   },
               @{
                   @"name"   :@"手机号",
                   @"content"  :@"133****1234"
                   }
               ,
               @{
                   @"name"   :@"预定金",
                   @"content"  :@"¥200"
                   }
               ];



    
    NSArray *arr2=@[
               @{
                   @"name"   :@"预定日期",
                   @"content"  :@"2019.01.01"
                   },
               @{
                   @"name"   :@"宴会时间",
                   @"content"  :@"晚宴 18：00-20：00"
                   },
               @{
                   @"name"   :@"预定桌位",
                   @"content"  :@"A-001 A-002 A-003 A-004 A-005 A-006 A-007 A-008"
                   },
               @{
                   @"name"   :@"预定菜品",
                   @"content"  :@"菜品1*01 菜品1*01 菜品1*01 菜品1*01 菜品1*01 菜品1*01 菜品1*01 菜品1*01 菜品1*01 "
                   }
            
               ];

    
    NSArray *arr3=@[
               @{
                   @"name"   :@"单桌小计",
                   @"content"  :@"¥888.0"
                   },
               @{
                   @"name"   :@"桌位数量",
                   @"content"  :@"7"
                   },
               @{
                   @"name"   :@"总计",
                   @"content"  :@"¥12888.0"
                   }
               ];
    
    infoData =@[arr1 ,arr2,arr3];
    

}
- (void)createNav {
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"白色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -20, 0, 0);
    
    // [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    


}

- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return infoData.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr=infoData[section];
    return arr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    OrderDetailContentCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OrderDetailContentCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.contentLab.font=[UIFont systemFontOfSize:14];
    
    NSArray *arr=infoData[indexPath.section];
    
    NSString  *str1=arr[indexPath.row][@"name"];
    NSString  *str2=arr[indexPath.row][@"content"];
    
    NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@: %@",str1,str2]];
    
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, str1.length+1)];
    
    
    if ([str1 isEqualToString:@"预定金"]||[str1 isEqualToString:@"单桌小计"]||[str1 isEqualToString:@"总计"]) {
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:navigationHotelColor range:NSMakeRange(str1.length+1, str2.length+1)];
    }
    cell.contentLab.attributedText = AttributedStr;
    
    
 
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==2) {
        return 0.01;
    }
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *topView=[[UIView alloc ]initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
    topView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    return topView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
        return 50;
   
  
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  
        UIView *topView=[[UIView alloc ]initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
        topView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 49)];
        lab.backgroundColor=[UIColor whiteColor];
    
    if (section==0) {
           lab.text=@"  宴会信息";
    }
    else if (section==1) {
        lab.text=@"  预定信息";
    }
    else
    {
         lab.text=@"  总计";
    }
        lab.font=[UIFont systemFontOfSize:14];
        [topView addSubview:lab];
        return topView;
    
}
-(IBAction)cancellPress:(id)sender
{
 
    
//    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
//    view.backgroundColor=[UIColor yellowColor];
//
//     BanquetCanselView *cansel=[[BanquetCanselView alloc]initWithFrame:view.frame];
//      view=cansel;
//    [self.view.window addSubview:view];
    
    

    
}

@end
