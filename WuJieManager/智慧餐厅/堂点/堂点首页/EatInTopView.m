//
//  EatInTopView.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/6.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "EatInTopView.h"
#import "GetDesksTaiList.h"
@interface EatInTopView ()<UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView *backScrollView;

    NSArray *desk_data;
    NSArray *data;
    
    NSString * titleIndex;
    NSString * subtitleIndex;
}

@property (weak, nonatomic) IBOutlet UIButton *resetBtn;

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic, assign) CGFloat itemWidth;

@end

@implementation EatInTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"EatInTopView" owner:self options:nil];
        [self addSubview:_thisView];
        
        _resetBtn.layer.masksToBounds = YES;
        _resetBtn.layer.cornerRadius = 5;
        _resetBtn.layer.borderWidth = 1;
        _resetBtn.layer.borderColor =navigationHotelColor.CGColor;
        [_resetBtn setTitleColor:navigationHotelColor forState:UIControlStateNormal];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (IBAction)cancellPress:(id)sender {
   // self.hidden=YES;
}

-(void)reloadData:(NSArray *)dataArr  index:(NSString *)index subIndex:(NSString *)subIndex
{
    data=dataArr;
    titleIndex=index;
    subtitleIndex=subIndex;
    
    [self initBackScrollView];
}
-(void)initBackScrollView
{
     if(!backScrollView){
         backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW,250)];
         backScrollView.bounces = NO;
         backScrollView.delegate = self;
         backScrollView.backgroundColor=[UIColor groupTableViewBackgroundColor];
         [self.backView addSubview:backScrollView];
     }
    else
    {
        for (UIView *view in [backScrollView subviews]) {
            [view removeFromSuperview];
        }
    }
    if ( data.count>0) {
     
        NSInteger num=4;
        if (IS_PAD) {
            num=8;
        }
        if ( data.count <= num) {
            self.itemWidth = ScreenW /  data.count;
        }else{
            self.itemWidth = ScreenW / 4;
        }
        for (int i=0; i<   [data count] ;i++) {
            UITableView *view=[[UITableView alloc]initWithFrame:CGRectMake(i* self.itemWidth+0.5, 0,  self.itemWidth-1, backScrollView.bounds.size.height)];
            view.backgroundColor=[UIColor whiteColor];
            view.tag=i;
            view.delegate=self;
            view.dataSource=self;
            view.separatorStyle = UITableViewCellSeparatorStyleNone;
            
            [backScrollView addSubview:view];
          
        }
       [backScrollView setContentSize:CGSizeMake(self.itemWidth * data.count, 0)];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    GetDesksTaiList *list=  data[tableView.tag];
    return list.desk_type_list.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    GetDesksTaiList *list= data[tableView.tag];
    if (tableView.tag==[titleIndex intValue] &&titleIndex.length>0) {
        if (subtitleIndex.length>0 &&indexPath.row==[subtitleIndex intValue]) {
            cell.textLabel.textColor=[UIColor redColor];
        }
        else
        {
            cell.textLabel.textColor=[UIColor blackColor];
        }
    }
    GetDesksTaiList *subList=list.desk_type_list[indexPath.row];
    cell.textLabel.text=subList.name;
     cell.textLabel.font = [UIFont systemFontOfSize: 14.0];
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GetDesksTaiList *list=  data[tableView.tag];
    GetDesksTaiList *subList=list.desk_type_list[indexPath.row];

    NSArray *arr=[NSArray arrayWithArray:subList.desk_data];

    if (self.delegate!=nil&&[self.delegate respondsToSelector:@selector(selectTopWithArr:index:subIndex:)]) {
        [self.delegate selectTopWithArr:arr index:[NSString stringWithFormat:@"%d",(int)tableView.tag]  subIndex:[NSString stringWithFormat:@"%d",(int)indexPath.row] ];
    
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 49)];
    headerView.backgroundColor=[UIColor whiteColor];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=headerView.frame;
    btn.tag=tableView.tag;
    if (tableView.tag==[titleIndex intValue] &&titleIndex.length>0 ) {
           [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    else
    {
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
  
    btn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    
    GetDesksTaiList *list=  data[tableView.tag];
    [btn setTitle:list.name forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(titlePress:) forControlEvents:UIControlEventTouchUpInside];
    
    [headerView addSubview: btn];
    return headerView;
}

-(void)titlePress:(UIButton *)btn
{
    NSMutableArray *arr=[NSMutableArray array];
    GetDesksTaiList *list=  data[btn.tag];
    for ( GetDesksTaiList *subList in list.desk_type_list) {
        [arr addObjectsFromArray:subList.desk_data];
    }
    if (self.delegate!=nil&&[self.delegate respondsToSelector:@selector(selectTopWithArr:index:subIndex:)]) {
        [self.delegate selectTopWithArr:arr index:[NSString stringWithFormat:@"%d",(int)btn.tag] subIndex:nil ];
    }
}
- (IBAction)resetPress:(id)sender {
    if (self.delegate!=nil&&[self.delegate respondsToSelector:@selector(reset)]) {
        [self.delegate reset ];
    }
}

@end
