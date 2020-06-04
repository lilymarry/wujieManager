//
//  SendAddvice.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/29.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "SendAddvice.h"
#import "SendAddviceTopCell.h"
#import "SendAddviceTypeCell.h"
#import "AddviceCell.h"
@interface SendAddvice ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *mTable;
@property(nonatomic,strong)NSIndexPath *lastPath2;
@property (strong, nonatomic) IBOutlet UIButton *subBtn;

@end

@implementation SendAddvice

- (void)viewDidLoad {
    [super viewDidLoad];
    adjustsScrollViewInsets_NO(_mTable, self);
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([SendAddviceTopCell class]) bundle:nil] forCellReuseIdentifier:@"SendAddviceTopCell"];
    
     [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([SendAddviceTypeCell class]) bundle:nil] forCellReuseIdentifier:@"SendAddviceTypeCell"];
     [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([AddviceCell class]) bundle:nil] forCellReuseIdentifier:@"AddviceCell"];
    _lastPath2 = [NSIndexPath indexPathForRow:0 inSection:1];
    [_mTable selectRowAtIndexPath:_lastPath2 animated:YES scrollPosition:UITableViewScrollPositionNone];
    self.title=@"意见反馈";
    
    _subBtn.layer.masksToBounds = YES;
    _subBtn.layer.cornerRadius = 15;
    
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ( section==0||section==2) {
        return 1;
    }
    return 2;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        
   
    SendAddviceTopCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SendAddviceTopCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
    return cell;
    }
  else  if (indexPath.section==1) {
        
        
        SendAddviceTypeCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SendAddviceTypeCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
      if (_lastPath2.row==indexPath.row) {
          cell.state_ImagV.image=[UIImage imageNamed:@"对勾选中"];
      }
      else
      {
          cell.state_ImagV.image=[UIImage imageNamed:@"对勾未选中"];
      }
      if (indexPath.row==1) {
          cell.title.text=@"其他问题";
          cell.subTitle.text=@"用的不爽、功能建议都提出来吧";
      }
      
        return cell;
    }
    else {
        
        
        AddviceCell *cell=[tableView dequeueReusableCellWithIdentifier:@"AddviceCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1)
    {
           int newRow =(int) [indexPath row];
        int oldRow =(int)( (_lastPath2 !=nil)?[_lastPath2 row]:-1);
        if (newRow != oldRow) {
            SendAddviceTypeCell *newcell = [tableView cellForRowAtIndexPath:indexPath];
            newcell.state_ImagV.image=[UIImage imageNamed:@"对勾选中"];
            
            SendAddviceTypeCell *oldCell = [tableView cellForRowAtIndexPath:_lastPath2];
            oldCell.state_ImagV.image=[UIImage imageNamed:@"对勾未选中"];
            _lastPath2 = indexPath;
            
        }
    }
}
@end
