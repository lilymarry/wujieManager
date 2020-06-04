//
//  AddRowNum.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/5.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "AddRowNum.h"
#import "AddRowNumTxtCell.h"
#import "AddRowNumTableCell.h"
#import "RowNumPicView.h"
#import "NumTableListModel.h"
#import "ViewTablePicModel.h"
#import "TakeNumberModel.h"
@interface AddRowNum ()<UICollectionViewDelegate, UICollectionViewDataSource,UITextFieldDelegate>
{
   
    NSString * phone;
    NSString *userName;
    
    NSArray *desk_list;
    NSString *floorName;
    NSArray *sub_desk_list;
    
    NSString *numStr;
    NSString *deskStr;
    
}
@property (weak, nonatomic) IBOutlet UICollectionView *mCollect;
@property(nonatomic,strong)NSIndexPath *lastPath;


@end

@implementation AddRowNum

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    adjustsScrollViewInsets_NO(_mCollect, self);
    self.title = @"打号录入";
    numStr=@"0";
    deskStr=@"";
    [_mCollect registerNib:[UINib nibWithNibName:NSStringFromClass([AddRowNumTxtCell class]) bundle:nil] forCellWithReuseIdentifier:@"AddRowNumTxtCell"];
    [_mCollect registerNib:[UINib nibWithNibName:NSStringFromClass([AddRowNumTableCell class]) bundle:nil] forCellWithReuseIdentifier:@"AddRowNumTableCell"];
    
    [_mCollect registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    
    [_mCollect registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footView"];
    [self getData];
    userName=@"";
    phone=@"";
  
    
}

-(void)getData
{
    [self.mCollect layoutIfNeeded];
    NumTableListModel  *get=[[NumTableListModel alloc]init];
  
     [MBProgressHUD showMessage:nil toView:self.view];
    [get NumTableListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message,NSDictionary * data) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
           NumTableListModel  *get=(NumTableListModel *)data;
        if ([code intValue]==200) {
            sub_desk_list =[NSArray arrayWithArray: get.data.desk_list];
            if (sub_desk_list.count>0) {
                    NSIndexPath *index;
                    if (self.lastPath==nil) {
                        index=  [NSIndexPath indexPathForRow:0 inSection:0];
                        
                    }
                    else
                    {
                        index=self.lastPath;
                        
                    }
                    
                    [self setSelectIndexPath:index];
                    
                
                NumTableListModel *list=sub_desk_list[index.row];
                numStr=list.wait_number;
                deskStr=list.name;
            
                }

            [_mCollect reloadData];

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
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView

{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==1) {
        return 1;
    }
    return sub_desk_list.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        AddRowNumTableCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddRowNumTableCell" forIndexPath:indexPath];
        NumTableListModel*get=  sub_desk_list[indexPath.item];
        cell.titleLab.text=get.name;
        if (_lastPath.row==indexPath.row&&_lastPath!=nil) {
            cell.titleLab.textColor=navigationHotelColor;
            cell.titleLab.backgroundColor=color(252, 208, 208);
        }
        else
        {
            cell.titleLab.textColor=[UIColor blackColor];
            cell.titleLab.backgroundColor=[UIColor groupTableViewBackgroundColor];
        }
        cell.pic_btn.tag=indexPath.row;
        [cell.pic_btn addTarget:self action:@selector(picBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
        
    }
    else
    {
       AddRowNumTxtCell *   txtCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddRowNumTxtCell" forIndexPath:indexPath];
        txtCell.phone_tf.text=phone;
        txtCell.name_tf.text=userName;
        txtCell.phone_tf.delegate=self;
        txtCell.name_tf.delegate=self;
        txtCell.phone_tf.tag=100;
        txtCell.name_tf.tag=101;
        return txtCell;
    }
    
}


#pragma mark - CollectionView的item的布局
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (IS_PAD) {
            return CGSizeMake(ScreenW/2-20,48);
        }
        else
        {
            return CGSizeMake(ScreenW-20,48);
        }
    }
    else
    {
        return CGSizeMake(ScreenW,140);
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        CGSize size = {ScreenW,50};
        return size;
    }
    
    
    else
    {
        
        CGSize size = {0.01,0.01};
        
        return size;
    }
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        CGSize size = {ScreenW,50};
        return size;
    }
    else
    {
        
        CGSize size = {0.01,0.01};
        
        return size;
    }
}
#pragma mark 设置 HeadView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView *headerView = [_mCollect dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        if(headerView == nil)
        {
            headerView = [[UICollectionReusableView alloc] init];
            
        }
        headerView.backgroundColor = [UIColor whiteColor];
        for(UIView *subView in headerView.subviews ) {
            [subView removeFromSuperview];
        }
        if (indexPath.section==0) {
            
            UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(8, 0, 130, 50)];
            lab.text=@"请选择用餐总人数";
            lab.textColor=[UIColor lightGrayColor];
     
            [lab setFont:[UIFont systemFontOfSize:14]];
            [headerView addSubview:lab];
            
        }
        
        return headerView;
    }
    else    if([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        UICollectionReusableView *headerView = [_mCollect dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footView" forIndexPath:indexPath];
        if(headerView == nil)
        {
            headerView = [[UICollectionReusableView alloc] init];
            
        }
        headerView.backgroundColor = [UIColor whiteColor];
        for(UIView *subView in headerView.subviews ) {
            [subView removeFromSuperview];
        }
        if (indexPath.section==0) {
            
            UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(8, 0, ScreenW-16, 50)];
             lab.textColor=[UIColor lightGrayColor];
            
            [lab setFont:[UIFont systemFontOfSize:14]];
            if (_lastPath!=nil) {
                NumTableListModel *list=sub_desk_list[_lastPath.item];
                NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@，前边排队人数%@位 ",list.name,list.wait_number]];
                
                [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(list.name.length+7,list.wait_number.length)];
                lab.attributedText=AttributedStr;
            }
            [headerView addSubview:lab];
    
        }
        
        return headerView;
    }

    
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    int newRow =(int) [indexPath row];
    
    
    if (indexPath.section==0) {
        int oldRow =(int)( (_lastPath !=nil)?[_lastPath row]:-1);
        if (newRow != oldRow) {
            AddRowNumTableCell *newcell =(AddRowNumTableCell *)[collectionView cellForItemAtIndexPath:indexPath];
            newcell.titleLab.textColor=navigationHotelColor;
            newcell.titleLab.backgroundColor=color(252, 208, 208);
            
            AddRowNumTableCell *oldCell =(AddRowNumTableCell *)[collectionView cellForItemAtIndexPath:_lastPath];
            
            oldCell.titleLab.textColor=[UIColor blackColor];
            oldCell.titleLab.backgroundColor=[UIColor groupTableViewBackgroundColor];
            _lastPath = indexPath;
             [self getData];
        
        }
    }
}
#pragma mark  查看图片
-(void)picBtnPress:(UIButton *)but
{
   NumTableListModel  *get=  sub_desk_list[but.tag];
    ViewTablePicModel *picView=[[ViewTablePicModel alloc]init];
   picView.desk_type_id=[NSString stringWithFormat:@"%d",[get.id intValue ]];
   
     [MBProgressHUD showMessage:nil toView:self.view];
    [picView ViewTablePicModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message,NSDictionary *picDic ) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        if ([code intValue]==200) {
            RowNumPicView *pic=[[RowNumPicView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
            pic.urlArr=picDic[@"img"];
            [self.view.window addSubview:pic];
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
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    switch (textField.tag) {
        case 100:
          phone = textField.text;
            break;
        case 101:
            userName = textField.text;
            break;
            
    }
    [_mCollect reloadData];
    
    return YES;
}
- (IBAction)submitPress:(id)sender {
    TakeNumberModel *model=[[TakeNumberModel alloc]init];
    if (userName.length==0) {
         [MBProgressHUD showSuccess:@"请输入联系人" toView:self.view];
        return;
    }
 
    if (phone.length==0) {
        [MBProgressHUD showSuccess:@"请输入手机号" toView:self.view];
        return;
    }
    NSString *str =[ValiMobile valiMobile:phone];
    if (str.length>0) {
        [MBProgressHUD showSuccess:str toView:self.view];
        return;
    }
    if (sub_desk_list. count>0) {
        NumTableListModel *list=sub_desk_list[_lastPath.item];
        model.desk_type_id=[NSString stringWithFormat:@"%d",[list.id intValue]];
    }
    else
    {
        [MBProgressHUD showSuccess:@"选择桌位类型" toView:self.view];
        return;
    }
 
    model.merchant_id=[[LoginModel shareInstance] getUserInfo].user_info.merchant_id ;
    model.num_type=@"1";
    model.create_user_type=@"2";
    model.create_user_id=[[LoginModel shareInstance] getUserInfo].user_info.uid;
    model.use_time=@"0";
    model.user_name=userName;
    model.user_phone=phone;
     [MBProgressHUD showMessage:nil toView:self.view];
    [model TakeNumberModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, NSDictionary * _Nonnull dataDic) {
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
     
        if ([code intValue]==200) {
            [MBProgressHUD showSuccess:message toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self .navigationController popViewControllerAnimated:YES];
            });
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
      
    } andFailure:^(NSError * _Nonnull error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];

    }];
    
}
-(void)setSelectIndexPath:(NSIndexPath *)indexPath
{
    _lastPath = indexPath;
    [_mCollect  selectItemAtIndexPath: _lastPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    [_mCollect reloadData];

}
@end
