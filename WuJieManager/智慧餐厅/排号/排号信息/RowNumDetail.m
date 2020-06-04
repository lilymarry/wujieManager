//
//  RowNumDetail.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/5.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "RowNumDetail.h"
#import "RowNumDetailCell.h"
#import "NumInfoDetailModel.h"
@interface RowNumDetail ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArr;
}
@property (weak, nonatomic) IBOutlet UITableView *mTable;

@end

@implementation RowNumDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    adjustsScrollViewInsets_NO(_mTable, self);
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([RowNumDetailCell class]) bundle:nil] forCellReuseIdentifier:@"RowNumDetailCell"];
 
    dataArr=[NSMutableArray array];
    [self createNav];
  
    [self getData];
}
-(void)getData
{
   NumInfoDetailModel *detail=[[NumInfoDetailModel alloc]init];
    detail.id=_idStr;
    [MBProgressHUD showMessage:nil toView:self.view];
    [detail InfoDetailSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
       
         NumInfoDetailModel *detail =(NumInfoDetailModel *)data;
        if (detail.data.number_show.length>0) {
            NSDictionary *dic=@{@"title":@"号码",
                                 @"subTitle":detail.data.number_show
                                };
            [dataArr addObject:dic];
        }
        if (detail.data.user_name.length>0) {
            NSDictionary *dic=@{@"title":@"取号人",
                                @"subTitle":detail.data.user_name
                                };
            [dataArr addObject:dic];
        }
        if (detail.data.user_phone.length>0) {
            NSDictionary *dic=@{@"title":@"电话",
                                @"subTitle":detail.data.user_phone
                                };
            [dataArr addObject:dic];
        }
        if (detail.data.num_state.length>0) {
            NSDictionary *dic=@{@"title":@"当前状态",
                                @"subTitle":detail.data.num_state
                                };
            [dataArr addObject:dic];
        }
        if (detail.data.num_type.length>0) {
            NSDictionary *dic=@{@"title":@"取号方式",
                                @"subTitle":detail.data.num_type
                                };
            [dataArr addObject:dic];
        }
        if (detail.data.create_time.length>0) {
            NSDictionary *dic=@{@"title":@"取号时间",
                                @"subTitle":detail.data.create_time
                                };
            [dataArr addObject:dic];
        }
        [_mTable reloadData];
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
- (void)createNav {
    
      self.title = @"信息详情";
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"白色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    
    [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    RowNumDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:@"RowNumDetailCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLab.text=dataArr[indexPath.row][@"title"];
    cell.subTitle.text=dataArr[indexPath.row][@"subTitle"];
    [cell.subTitle setTextColor:([ cell.titleLab.text isEqualToString:@"当前状态"] ? navigationHotelColor:[UIColor blackColor] )];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
    
}

@end
