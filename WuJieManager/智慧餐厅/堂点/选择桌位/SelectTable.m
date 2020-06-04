//
//  SelectTable.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/7.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "SelectTable.h"
#import "SelectTablePadCell.h"
#import "SelectTableIphoneCell.h"
#import "SItemView.h"

@interface SelectTable ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    BOOL allSele;
    NSMutableArray *indexArr;
}
@property (weak, nonatomic) IBOutlet SItemView *titleItemView;

@property (weak, nonatomic) IBOutlet UICollectionView *mCollect;
@property (weak, nonatomic) IBOutlet UIImageView *allImagView;

@end

@implementation SelectTable
-(id)initWithBlock:(finishBlock)ablock
{
    if (self=[super init]) {
        
        _block=[ablock copy];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createNav];
    
    self.titleItemView.itemsArray = @[@"一楼",@"二楼",@"三楼",@"四楼",@"五楼"];
    self.titleItemView.SelectItemBlock = ^(NSInteger index ) {
        
        
    };
    
    indexArr = [NSMutableArray new];
    allSele=NO;
    
    _mCollect.backgroundColor=[UIColor whiteColor];
    [_mCollect registerNib:[UINib nibWithNibName:@"SelectTablePadCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SelectTablePadCell"];
    
    [_mCollect registerNib:[UINib nibWithNibName:@"SelectTableIphoneCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SelectTableIphoneCell"];
    
    self.title=@"选择桌位";
    adjustsScrollViewInsets_NO(_mCollect, self);
    _mCollect .allowsMultipleSelection=YES;
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

-(IBAction)AllPress:(UIButton *)btn
{
    [indexArr removeAllObjects];
    NSString *str= allSele? @"对勾未选中":@"对勾选中";
    _allImagView.image=[UIImage imageNamed:str];
    allSele=allSele?NO:YES;
    [_mCollect reloadData];
    
}
-(IBAction)surePress:(id)sender
{
    if (_block)
    {
        _block(@"A-004");
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 8;
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (IS_PAD) {
        
        return CGSizeMake(ScreenW/4-20,140);
    }
    else
    {
        
        return CGSizeMake(ScreenW-20,50);
        
    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (IS_PAD) {
        SelectTablePadCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectTablePadCell" forIndexPath:indexPath];
        if (allSele)
        {
            cell.stateImaView.image=  [UIImage imageNamed:@"对勾选中"];
        }
        else
        {
            if ([indexArr containsObject:indexPath]) {
                cell.stateImaView.image=  [UIImage imageNamed:@"对勾选中"];
            }else{
                cell.stateImaView.image=  [UIImage imageNamed:@"对勾未选中"];
            }
        }
        return cell;
    }
    else
    {
        
        SelectTableIphoneCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectTableIphoneCell" forIndexPath:indexPath];
        
        if (allSele)
        {
            cell.stateImaView.image=  [UIImage imageNamed:@"对勾选中"];
        }
        else
        {
            if ([indexArr containsObject:indexPath]) {
                cell.stateImaView.image=  [UIImage imageNamed:@"对勾选中"];
            }else{
                cell.stateImaView.image=  [UIImage imageNamed:@"对勾未选中"];
            }
        }
        return cell;
        
    }
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_PAD) {
        SelectTablePadCell *cell = (SelectTablePadCell*)[collectionView cellForItemAtIndexPath:indexPath];
        
        cell.stateImaView.image=  [UIImage imageNamed:@"对勾选中"];
        [indexArr addObject:indexPath];
        
    }
    else
    {
        
        SelectTableIphoneCell *cell = (SelectTableIphoneCell*)[collectionView cellForItemAtIndexPath:indexPath];
        
        cell.stateImaView.image=  [UIImage imageNamed:@"对勾选中"];
        [indexArr addObject:indexPath];
        
        
        
    }
    
}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_PAD) {
        SelectTablePadCell *cell = (SelectTablePadCell*)[collectionView cellForItemAtIndexPath:indexPath];
        
        cell.stateImaView.image=  [UIImage imageNamed:@"对勾选中"];
        [indexArr addObject:indexPath];
        
    }
    else
    {
        
        SelectTableIphoneCell *cell = (SelectTableIphoneCell*)[collectionView cellForItemAtIndexPath:indexPath];
        cell.stateImaView.image=  [UIImage imageNamed:@"对勾未选中"];
        [indexArr removeObject:indexPath];
        
    }
    
}
@end
