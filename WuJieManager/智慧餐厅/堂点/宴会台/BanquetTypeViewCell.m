//
//  BanquetTypeViewCell.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/10.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "BanquetTypeViewCell.h"
#import "BanquetTypeViewSubCell.h"
@interface BanquetTypeViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSArray *dataArr;
}
@property (weak, nonatomic) IBOutlet UICollectionView *mCollect;

@property(nonatomic,strong)NSIndexPath *lastPath2;

@end
@implementation BanquetTypeViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _mCollect.delegate=self;
    _mCollect.dataSource=self;
    _mCollect.scrollEnabled=NO;
 
   [_mCollect registerNib:[UINib nibWithNibName:NSStringFromClass([BanquetTypeViewSubCell class]) bundle:nil] forCellWithReuseIdentifier:@"BanquetTypeViewSubCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void)reloadCell:(NSDictionary *)dic
{
    _nameLab.text=dic[@"name"];
    dataArr=dic[@"content"];

    if ([dic[@"type"]isEqualToString:@"1"])
    {
        _lastPath2 = [NSIndexPath indexPathForItem:[dic[@"subType"] integerValue] inSection:0];
        [_mCollect selectItemAtIndexPath:_lastPath2 animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    }
    else
    {
        _lastPath2=nil;
    }
   [_mCollect reloadData];
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return dataArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BanquetTypeViewSubCell * commonCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BanquetTypeViewSubCell" forIndexPath:indexPath];
    commonCell.nameLab.text=dataArr[indexPath.item];
    
    if (_lastPath2!=nil &&_lastPath2.item==indexPath.item ) {
        commonCell.nameLab.textColor=navigationHotelColor;
         commonCell.layer.borderColor =navigationHotelColor.CGColor;
        commonCell.nameLab.backgroundColor=color(252, 208, 208);
    }
    else
    {
        commonCell.nameLab.textColor=[UIColor lightGrayColor];
         commonCell.layer.borderColor =[UIColor clearColor].CGColor;
        commonCell.nameLab.backgroundColor=[UIColor groupTableViewBackgroundColor];
    }

    
    
    return commonCell;
}


#pragma mark - =========================== CollectionView的item的布局 =============================
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((self.frame.size.width-_nameLabWW.constant)/3-20,40);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    int newRow =(int) [indexPath item];

        int oldRow =(int)( (_lastPath2 !=nil)?[_lastPath2 item]:-1);
        if (newRow != oldRow) {
            BanquetTypeViewSubCell *newcell = (BanquetTypeViewSubCell *)[collectionView cellForItemAtIndexPath:indexPath];
            newcell.nameLab.textColor=navigationHotelColor;
            newcell.layer.borderColor =navigationHotelColor.CGColor;
            newcell.nameLab.backgroundColor=color(252, 208, 208);
            
            
            BanquetTypeViewSubCell *oldCell = (BanquetTypeViewSubCell *)[collectionView cellForItemAtIndexPath:_lastPath2];
            oldCell.nameLab.textColor=[UIColor lightGrayColor];
            oldCell.layer.borderColor =[UIColor clearColor].CGColor;
            oldCell.nameLab.backgroundColor=[UIColor groupTableViewBackgroundColor];
            _lastPath2 = indexPath;
        }
      else
      {
          if ( _lastPath2==nil) {
              BanquetTypeViewSubCell *newcell = (BanquetTypeViewSubCell *)[collectionView cellForItemAtIndexPath:indexPath];
              newcell.nameLab.textColor=navigationHotelColor;
              newcell.layer.borderColor =navigationHotelColor.CGColor;
              newcell.nameLab.backgroundColor=color(252, 208, 208);
              _lastPath2 = indexPath;
              
            
              
          }
          else
          {
              BanquetTypeViewSubCell *oldCell = (BanquetTypeViewSubCell *)[collectionView cellForItemAtIndexPath:_lastPath2];
              oldCell.nameLab.textColor=[UIColor lightGrayColor];
              oldCell.layer.borderColor =[UIColor clearColor].CGColor;
              oldCell.nameLab.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
              _lastPath2 = nil;
          }
      }
    [self.delegate selectIndex:_sumPath andsubIndex:_lastPath2];

}

@end
