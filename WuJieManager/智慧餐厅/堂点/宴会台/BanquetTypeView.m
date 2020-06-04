//
//  BanquetTypeView.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/10.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "BanquetTypeView.h"
#import "BanquetTypeViewCell.h"

@interface BanquetTypeView ()<UITableViewDelegate,UITableViewDataSource,BanquetTypeDelegate>
{
    NSMutableArray *data;
    NSMutableArray *typeArr;
}
@property (weak, nonatomic) IBOutlet UITableView *mTable;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewWW;



@end

@implementation BanquetTypeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"BanquetTypeView" owner:self options:nil];
        [self addSubview:_thisView];
        _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mTable.dataSource=self;
        _mTable.delegate=self;
        [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass([BanquetTypeViewCell class]) bundle:nil] forCellReuseIdentifier:@"BanquetTypeViewCell"];
        [self getData];
        typeArr=[NSMutableArray array];
        
        _viewWW.constant= IS_PAD ? ScreenW/3:ScreenW-10;
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (IBAction)cancellPress:(id)sender {
    [self removeFromSuperview];
}
-(void)getData
{
    data=[NSMutableArray arrayWithObjects:
          @{
            @"name"   :@"类型",
            @"content" :@[@"中式宴会1",@"法式宴会2",@"日式宴会3",@"俄式宴会4",@"法式宴会5",@"日式宴会6",@"俄式宴会7"]
            ,  @"type" :@"0"
            ,  @"subType" :@"0"
            }.mutableCopy,
  @{
    @"name"   :@"性质",
    @"content"  :@[@"自助餐",@"非自助餐"]
    ,  @"type" :@"0"
    ,  @"subType" :@"0"
    }.mutableCopy,
  @{
    @"name"   :@"性质",
    @"content"  :@[@"自助餐",@"非自助餐"]
    ,  @"type" :@"0"
    ,  @"subType" :@"0"
    }.mutableCopy,
          @{
            @"name"   :@"主题",
            @"content"  :@[@"喜宴1",@"寿宴2",@"迎宾宴3",@"喜宴4",@"寿宴5",@"迎宾宴6"]
            ,  @"type" :@"0"
            ,  @"subType" :@"0"
            }.mutableCopy,
  @{
    @"name"   :@"规格",
    @"content"  :@[@"商务宴会",@"团体宴会",@"私人宴会",@"国宴"]
    ,  @"type" :@"0"
    ,  @"subType" :@"0"
    }.mutableCopy,
  @{
    @"name"   :@"形式",
    @"content"  :@[@"立餐宴会",@"坐餐宴会",@"坐立混合"]
    ,  @"type" :@"0"
    ,  @"subType" :@"0"
    }.mutableCopy,nil];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return data.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    BanquetTypeViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BanquetTypeViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    cell.delegate=self;
    cell.sumPath=indexPath;
    [cell reloadCell: data[indexPath.row]];
    
    return cell;
    
}
-(void)selectIndex:(NSIndexPath *)index andsubIndex:(NSIndexPath *)subIndex
{
    if (subIndex==nil) {
        data[index.row][@"type"] = @"0";
        data[index.row][@"subType"] = @"0";
    }
    else
    {
        data[index.row][@"type"] = @"1";
        data[index.row][@"subType"] = [NSString stringWithFormat:@"%d",(int)subIndex.row];
    }
    [_mTable reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* arr = data[indexPath.row][@"content"];
   
    
        if (arr.count%3==0) {
            return arr.count/3 *50;
        }
        return  arr.count/3 *50+50;
}

@end
