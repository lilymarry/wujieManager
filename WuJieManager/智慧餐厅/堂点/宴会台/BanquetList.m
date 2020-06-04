//
//  BanquetList.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/9.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "BanquetList.h"
#import "BanquetListCell.h"
#import "BanquetDetail.h"
#import "AddBanquet.h"
#import "BanquetListPadCell.h"
#import "EatIn.h"
@interface BanquetList ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mTable;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation BanquetList

- (void)viewDidLoad {
    [super viewDidLoad];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([BanquetListCell class]) bundle:nil] forCellReuseIdentifier:@"BanquetListCell"];
    
    [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([BanquetListPadCell class]) bundle:nil] forCellReuseIdentifier:@"BanquetListPadCell"];
    if (IS_PAD) {
        _titleLab.hidden=YES;
    }
    else
    {
        _titleLab.hidden=NO;
    }
    [self createNav];
    self.title=@"宴会台";
}
- (void)createNav {
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"白色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -20, 0, 0);
    
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 70, 50);
    
    
    UIBarButtonItem * rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    
    [rightBtn addTarget:self action:@selector(rightPress) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font=[UIFont systemFontOfSize:14] ;
    
    [rightBtn setTitle:@"添加宴会" forState:UIControlStateNormal];
    
}
-(void)rightPress
{
    AddBanquet *list=[[AddBanquet alloc]init];
    [self.navigationController pushViewController:list animated:YES];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (IS_PAD) {
        BanquetListPadCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BanquetListPadCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.detailBtn addTarget:self action:@selector(detailPress:) forControlEvents:UIControlEventTouchUpInside];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTime:)];
        cell.timeLab .tag=indexPath.row;
        cell.timeLab.userInteractionEnabled=YES;
       [cell.timeLab addGestureRecognizer:tap];
        return cell;
    }
    BanquetListCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BanquetListCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTime:)];
    cell.timeLab .tag=indexPath.row;
    cell.timeLab.userInteractionEnabled=YES;
    [cell.timeLab addGestureRecognizer:tap];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_PAD) {
        return 60;
    }
    return 108;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (!IS_PAD) {
    BanquetDetail *detail=[[BanquetDetail alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
     }
}
-(void)detailPress:(UIButton *)but
{
    BanquetDetail *detail=[[BanquetDetail alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
}
-(void)tapTime:(UITapGestureRecognizer *)recognizer
{
    UILabel *lab=(UILabel *)[recognizer view];
    NSLog(@"SSS %ld",(long)lab.tag) ;
    EatIn * eatIn=[[EatIn alloc]init];
    eatIn.type=@"2";
    [self.navigationController pushViewController:eatIn animated:YES];
    
}
@end
