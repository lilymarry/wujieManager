//
//  OrderFoodAttributeView.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/16.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "OrderFoodAttributeView.h"
#import "BanquetTypeViewCell.h"
#import "OrderFoodAttributeCell.h"
#import "OrderFoodAtterModel.h"
#import "OrderFoodAttributeSubCell.h"
#import "OrderFoodAttributeAddCell.h"
#import "ExChangeJson.h"
#import "GetPriceModel.h"
#import "OrderFoodAttributePriceCell.h"
#import "AddShopCart.h"

@interface OrderFoodAttributeView ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>
{
    
    NSArray *dataArr;//套餐数组
    
    NSArray *addArr;//加菜数组
    NSArray *normsArr;//规格数组
    NSArray *tasteArr;//口味数组

    NSString *make_price;//加工费
    
    NSString *single_price;//单品价格
   
}
@property (weak, nonatomic) IBOutlet UIView *singleView;
@property (weak, nonatomic) IBOutlet UILabel *singleLab;
@property (weak, nonatomic) IBOutlet UICollectionView *singleTable;
@property (weak, nonatomic) IBOutlet UIScrollView *mScrollView;
@property (weak, nonatomic) IBOutlet UILabel *sumPriceLab;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UITextField *num_tf;
@property (strong, nonatomic) IBOutlet UIView *backView;
@end

@implementation OrderFoodAttributeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"OrderFoodAttributeView" owner:self options:nil];
        [self addSubview:_thisView];
        _mScrollView.backgroundColor=[UIColor whiteColor];
        
        _singleTable.backgroundColor=[UIColor whiteColor];
        [_singleTable registerNib:[UINib nibWithNibName:@"OrderFoodAttributeSubCell" bundle:nil] forCellWithReuseIdentifier:@"OrderFoodAttributeSubCell"];
        [_singleTable registerNib:[UINib nibWithNibName:@"OrderFoodAttributeAddCell" bundle:nil] forCellWithReuseIdentifier:@"OrderFoodAttributeAddCell"];
        [_singleTable registerNib:[UINib nibWithNibName:@"OrderFoodAttributePriceCell" bundle:nil] forCellWithReuseIdentifier:@"OrderFoodAttributePriceCell"];
        [_singleTable registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyHiden:) name: UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyWillAppear:) name:UIKeyboardWillChangeFrameNotification object:nil];
       _num_tf.text=@"1";
       make_price=@"";
   
        [_sureBtn setBackgroundColor:[UIColor lightGrayColor]];
        _sureBtn.enabled=NO ;
    }
    return self;
}
-(void)keyHiden:(NSNotification *)notification
{
    
    [UIView animateWithDuration:0.25 animations:^{
        //恢复原样
        _backView.transform = CGAffineTransformIdentity;
        
    }];
    
    
}
-(void)keyWillAppear:(NSNotification *)notification
{
    //获得通知中的info字典
    NSDictionary *userInfo = [notification userInfo];
    CGRect rect= [[userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
    
    [UIView animateWithDuration:0.25 animations:^{
        _backView.transform = CGAffineTransformMakeTranslation(0, -([UIScreen mainScreen].bounds.size.height-rect.origin.y)+100);
    }];
    
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

-(void)loadOrderFoodAttributeView
{
  
        if (_dataDic.count>0) {
          
    _num_tf.text=[NSString stringWithFormat:@"%@",_dataDic[@"totalNum"] ];
        }
    [self getData];
 
}
-(void)initBackScrollView
{
    for (UIView *view in [_mScrollView subviews]) {
        [view removeFromSuperview];
    }
    
    if ( dataArr.count>0) {
        NSInteger i=0;
        CGFloat sumHeight=0;
     
        for (OrderFoodAtterModel *model in  dataArr) {
            CGFloat num = 0.0;
            
            CGFloat height1= [self getCollectionViewHeigth:model.dishes_taste_diff] ;
            CGFloat height2= [self getCollectionViewHeigth:model.dishes_type_diff] ;
            CGFloat height3= model.dishAdd.count *50;
            
            if (model.dishes_taste_diff.count>0) {
                num=num+50;
            }
            if (model.dishes_type_diff.count>0)
            {
                  num=num+50;
            }
            if (model.dishAdd.count>0)
            {
                   num=num+50;
            }
            CGFloat height=height1+height2+height3+num+50+20;
            sumHeight=sumHeight+height;
        
             UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, sumHeight-height, _mScrollView.frame.size.width, 40)];
            lab.text=[NSString stringWithFormat:@" ● %@",model.dish_name];
            lab.textColor=[UIColor redColor];
            lab.textAlignment=NSTextAlignmentLeft;
            lab.font=[UIFont systemFontOfSize:14];
            [_mScrollView addSubview:lab];
            
            UICollectionViewFlowLayout   *     _flowLayout = [[UICollectionViewFlowLayout alloc] init];
             UICollectionView *view=[[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lab.frame),  _mScrollView.frame.size.width, height-1)collectionViewLayout:_flowLayout];
            view.backgroundColor=[UIColor whiteColor];
            view.tag=i+1000;
            view.delegate=self;
            view.dataSource=self;
            [view registerNib:[UINib nibWithNibName:@"OrderFoodAttributeSubCell" bundle:nil] forCellWithReuseIdentifier:@"OrderFoodAttributeSubCell"];
            [view registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
            [view registerNib:[UINib nibWithNibName:@"OrderFoodAttributeAddCell" bundle:nil] forCellWithReuseIdentifier:@"OrderFoodAttributeAddCell"];
          
            if (_dataDic.count>0) {
               NSArray *  selectArr=   _dataDic[@"dishData"];
                for (NSDictionary *dic in selectArr) {
                    NSString *str =[NSString stringWithFormat:@"%@",dic[@"dish_id"]];
                    if ([str isEqualToString:model.dish_id]) {
                           [self setMaxItemSelect:model.dishes_taste_diff iddic:dic];
                           [self setMaxItemSelect:model.dishes_type_diff iddic:dic];
                           [self setMaxAddNum:model.dishAdd iddic:dic];
                        
                    }
                }
                
            }
            else
            {
            [self setFirstItemSelect:model.dishes_taste_diff];
            [self setFirstItemSelect:model.dishes_type_diff];
            }
     
            
            [_mScrollView addSubview:view];
            i++;
        }
        [_mScrollView setContentSize:CGSizeMake(0, sumHeight+50)];
    }
}

-(void)getData
{
    OrderFoodAtterModel *model=[[OrderFoodAtterModel alloc]init];
    if ([_mic_id isEqualToString:@"0"]) {
         model.id=_id;//套餐
         model.type=@"2";
    }
    else
    {
         model.id=_dishes_id;
         model.type=@"1";
        
    }
    [MBProgressHUD showMessage:nil toView:self];
    [model OrderFoodAtterModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        if ([code intValue]==200) {
            OrderFoodAtterModel *model=( OrderFoodAtterModel *)data;
            if ([_mic_id isEqualToString:@"0"]) {
            
                _mScrollView.hidden=NO;
                _singleLab.text=model.data.d.name;
                dataArr=[NSArray arrayWithArray:model.data.dishList];
                [self initBackScrollView];
            }
            else
            {
                
                _mScrollView.hidden=YES;
                _singleLab.text=model.data.dishData.name;
                addArr=[NSArray arrayWithArray:model.data.dishAdd];
                normsArr=[NSArray arrayWithArray:model.data.dishNorms];
                tasteArr=[NSArray arrayWithArray:model.data.dishTaste];
                if (model.data.dishProduce.price.length>0) {
                    make_price=model.data.dishProduce.price;
                }
                if (_dataDic.count>0) {
                    [self setSingleItemSelect:model.data.dishTaste idstr:_dataDic[@"taste_id"]];
                     [self setSingleItemSelect:model.data.dishNorms idstr:_dataDic[@"norm_id"]];
                    [self  setSingleAddNum:model.data.dishAdd idArr:_dataDic[@"addData"]];
                }
                else
                {
                    [self setFirstItemSelect:normsArr];
                    [self setFirstItemSelect:tasteArr];
                }
                
               
                [_singleTable reloadData];
            }
            [self getPrice];
        }
        else
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:message toView:self ];
            });

           
        }
    
        
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self];
    }];
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView==_singleTable) {
        return 4;
    }
    else
    {
        return 3;
    }
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView==_singleTable) {
        if (section==0) {
            return normsArr.count;
            
           
        }
        else if (section==1)
        {
            
            return tasteArr.count;
        }
        else if (section==2)
        {
            
            return addArr.count;
        }
        else
        {
            if (make_price.length>0) {
                 return 1;
            }
            else
            {
                 return 0;
            }
           
        }
        
    }
    else
    {
        if (section==0) {
            OrderFoodAtterModel *model=   dataArr[ collectionView.tag-1000];
            return model.dishes_type_diff.count;
            
          
        }
        else  if (section==1)
        {
            OrderFoodAtterModel *model=   dataArr[ collectionView.tag-1000];
            return model.dishes_taste_diff.count;
        }
        else
        {
            OrderFoodAtterModel *model=   dataArr[ collectionView.tag-1000];
            return model.dishAdd.count;
        }
    }
    
    
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
      OrderFoodAtterModel *model;
    if (collectionView==_singleTable) {
        
        if (indexPath.section==0||indexPath. section==1) {
            OrderFoodAttributeSubCell * commonCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OrderFoodAttributeSubCell" forIndexPath:indexPath];
         
            if (indexPath. section==0) {
                model=  normsArr [ indexPath.item];
                commonCell.nameLab.text=model.norms_label;
                
            }
            else  {
              
                model= tasteArr  [ indexPath.item];
                commonCell.nameLab.text=model.taste_name;
            }
            
            if (model.isSelect) {
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
        
        else  if (indexPath.section==2)
        {
             OrderFoodAttributeAddCell * commonCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OrderFoodAttributeAddCell" forIndexPath:indexPath];
              model=   addArr[ indexPath.item];
            commonCell.nameLab.text=[NSString stringWithFormat:@"%@ ¥%@",model.name,model.dish_here_selttle];
            [commonCell.addBtn addTarget:self action:@selector(addPress:) forControlEvents:UIControlEventTouchUpInside];
            commonCell.addBtn.tag=indexPath.item;
            
            [commonCell.reduceBtn addTarget:self action:@selector(reducePress:) forControlEvents:UIControlEventTouchUpInside];
            commonCell.reduceBtn.tag=indexPath.item;
            commonCell.numLab.text=[NSString stringWithFormat:@"%ld",(long)model.selectNum];
            return commonCell;
        }
       
      else
      {
          OrderFoodAttributePriceCell * commonCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OrderFoodAttributePriceCell" forIndexPath:indexPath];
          commonCell.priceLab.text=[NSString stringWithFormat:@"  %@",make_price];
          return commonCell;
      }
        
    }
    
    else
    {
       
    OrderFoodAtterModel *model=   dataArr[ collectionView.tag-1000];
    OrderFoodAtterModel *submodel;
    if (indexPath. section==0 ||indexPath. section==1) {
        if (indexPath. section==0) {
              submodel=model.dishes_type_diff[indexPath.item];
        }
       else
       {
            submodel=model.dishes_taste_diff[indexPath.item];
       }
        OrderFoodAttributeSubCell * commonCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OrderFoodAttributeSubCell" forIndexPath:indexPath];
        commonCell.nameLab.text=submodel.name;
        if (submodel.isSelect) {
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
    else
    {
        
        submodel=model.dishAdd[indexPath.item];
        OrderFoodAttributeAddCell * commonCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OrderFoodAttributeAddCell" forIndexPath:indexPath];
       
        commonCell.nameLab.text=[NSString stringWithFormat:@"%@ ¥%@",submodel.name,submodel.dish_here_selttle];
        [commonCell.addBtn addTarget:self action:@selector(addPress:) forControlEvents:UIControlEventTouchUpInside];
        commonCell.addBtn.tag=indexPath.item;
        commonCell.addBtn.sumIndexPath=collectionView.tag;
        
        [commonCell.reduceBtn addTarget:self action:@selector(reducePress:) forControlEvents:UIControlEventTouchUpInside];
        commonCell.reduceBtn.tag=indexPath.item;
         commonCell.reduceBtn.sumIndexPath=collectionView.tag;
        
        commonCell.numLab.text=[NSString stringWithFormat:@"%ld",(long)submodel.selectNum];
        return commonCell;
        
    }
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (collectionView==_singleTable) {
       
            if (section==0) {
                
                if (normsArr.count>0) {
                    CGSize size = {_mScrollView.frame.size.width,50};
                    return size;
                }
                
            }
            else if (section==1)
            {
                if (tasteArr.count>0) {
                    CGSize size = {_mScrollView.frame.size.width,50};
                    return size;
                }
                
                
            }
            else   if (section==2)
            {
                if (addArr.count>0) {
                    CGSize size = {_mScrollView.frame.size.width,50};
                    return size;
                }
                
            }
            else
            {
                if (make_price.length>0) {
                    CGSize size = {_mScrollView.frame.size.width,50};
                    return size;
                }
            }
            
            
        }
        else
        {
            OrderFoodAtterModel *model=   dataArr[ collectionView.tag-1000];
            if (section==0) {
                if (model.dishes_type_diff.count>0) {
                    CGSize size = {_mScrollView.frame.size.width,50};
                    return size;
                }
                
                
            }
            else  if (section==1)
            {
                if (model.dishes_taste_diff.count>0) {
                    CGSize size = {_mScrollView.frame.size.width,50};
                    return size;
                }
                
            }
            else
            {
                if (model.dishAdd.count>0) {
                    CGSize size = {_mScrollView.frame.size.width,50};
                    return size;
                }
            }
        }
         CGSize size =  {0.01,0.01};
         return size;
    }
#pragma mark 设置 HeadView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        if(headerView == nil)
        {
            headerView = [[UICollectionReusableView alloc] init];
            
        }
        headerView.backgroundColor = [UIColor whiteColor];
        for(UIView *subView in headerView.subviews ) {
            [subView removeFromSuperview];
        }
        
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(8, 0, 130, 50)];
   
        
        if (collectionView==_singleTable) {
            if (indexPath. section==0) {
               
                if (normsArr.count>0) {
                    lab.text=@"规格";
                }
                
            }
            else if (indexPath. section==1)
            {
                if (tasteArr.count>0) {
                    lab.text=@"味道";
                }
                
                
            }
            else   if (indexPath. section==2)
            {
                if (addArr.count>0) {
                     lab.text=@"加菜";
                }
                
            }
            else
            {
                if (make_price.length>0) {
                     lab.text=@"加工费";
                }
            }
           
            
        }
        else
        {
        OrderFoodAtterModel *model=   dataArr[ collectionView.tag-1000];
        if (indexPath.section==0) {
            if (model.dishes_type_diff.count>0) {
                lab.text=@"规格";
            }
           
            
        }
        else  if (indexPath.section==1)
        {
            if (model.dishes_taste_diff.count>0) {
                lab.text=@"味道";
            }
            
        }
            else
            {
                if (model.dishAdd.count>0) {
                    lab.text=@"加菜";
                }
            }
        }
        lab.textColor=[UIColor lightGrayColor];
        
        [lab setFont:[UIFont systemFontOfSize:14]];
        [headerView addSubview:lab];
        
        return headerView;
    }
    
    
    
    return nil;
}


//#pragma mark CollectionView布局
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView==_singleTable) {
        if (indexPath.section==2||indexPath.section==3) {
            return CGSizeMake(_singleTable.frame.size.width,50);
        }
        else
        {
          return CGSizeMake((_singleTable.frame.size.width-20)/3,50);
        }
       
    }
    else
    {
        if (indexPath.section==2)
        {
              return CGSizeMake(collectionView.frame.size.width,50);
        }
        return CGSizeMake((collectionView.frame.size.width-20)/3,50);
    }
    
}
-(CGFloat)getCollectionViewHeigth:(NSArray *)arr
{
    if (arr.count%3==0) {
        return arr.count/3 *50;
    }
    else
    {
        return  arr.count/3 *50+50;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
      [_num_tf resignFirstResponder];
    if (collectionView==_singleTable) {
        OrderFoodAtterModel *model;
        if (indexPath. section==0) {
           [self setModelNotSelect:normsArr ];
            model=   normsArr[indexPath.item];
            model.isSelect=YES;
            [self getPrice];
        
        }
        else if (indexPath. section==1)
        {   [self setModelNotSelect:tasteArr ];
            model=   tasteArr[indexPath.item];
            model.isSelect=YES;
          [self getPrice];
       
            
        }
       
    }
    else
    {
    OrderFoodAtterModel *model=   dataArr[ collectionView.tag-1000];
    
    if (indexPath. section==0) {
           [self setModelNotSelect:model.dishes_type_diff ];
        OrderFoodAtterModel *submodel=model.dishes_type_diff[indexPath.item];
        submodel.isSelect=YES;
     
         [self getPrice];
      
        
    }
    else  if (indexPath. section==1)
    {
         [self setModelNotSelect:model.dishes_taste_diff ];
        OrderFoodAtterModel *submodel=model.dishes_taste_diff[indexPath.item];
        submodel.isSelect=YES;
        [self getPrice];
    }
        
    }
  
    [collectionView reloadData];
    
}

-(void)setModelNotSelect:(NSArray *)arr
{
    
    for ( OrderFoodAtterModel *submodel in arr ) {
        if (submodel.isSelect) {
            submodel.isSelect=NO;
        }
    }
    
}
-(void)setFirstItemSelect:(NSArray *)arr
{
    if (arr.count>0) {
        OrderFoodAtterModel *submodel=arr[0];
        submodel.isSelect=YES;
    }
}
-(void)setMaxItemSelect:(NSArray *)arr iddic:(NSDictionary *)iddic
{
    if (arr.count>0) {
        for (OrderFoodAtterModel *submodel in arr) {
              NSString *str =[NSString stringWithFormat:@"%@",iddic[@"norms_id"]];
            if ([str isEqualToString:submodel.dishes_type]) {
                submodel.isSelect=YES;
            }
             NSString *str1 =[NSString stringWithFormat:@"%@",iddic[@"taste_id"]];
            if ([str1 isEqualToString:submodel.dishes_taste]) {
                submodel.isSelect=YES;
            }
        }

    }
}
-(void)setMaxAddNum:(NSArray *)arr iddic:(NSDictionary *)iddic
{
    if (arr.count>0) {
        NSArray *data=iddic[@"add"];
        if (data.count>0) {
            for (NSDictionary *dic in data) {
               for (OrderFoodAtterModel *submodel in arr) {
                     NSString *str =[NSString stringWithFormat:@"%@",dic[@"add_id"]];
                   if ([str isEqualToString:submodel.id]) {
                       submodel.selectNum=[dic[@"num"] integerValue];
                   }
               }
               
            }
        }
    }
}
-(void)setSingleItemSelect:(NSArray *)arr idstr:(NSString *)idStr
{
    if (arr.count>0) {
        for (OrderFoodAtterModel *submodel in arr) {
            NSString *str =[NSString stringWithFormat:@"%@",idStr];
            if ([str isEqualToString:submodel.id]) {
                submodel.isSelect=YES;
            }
           
        }
        
    }
}
-(void)setSingleAddNum:(NSArray *)arr idArr:(NSArray *)idArr
{
    if (arr.count>0) {
            for (NSDictionary *dic in idArr) {
                for (OrderFoodAtterModel *submodel in arr) {
                      NSString *str =[NSString stringWithFormat:@"%@",dic[@"add_id"]];
                    if ([str isEqualToString:submodel.id]) {
                        submodel.selectNum=[dic[@"num"] integerValue];
                    }
                }
                
            }
       
    }
}

-(void)addPress:(OrderFoodRightBtn *)but
{
    [_num_tf resignFirstResponder];
    if ([_mic_id isEqualToString:@"0"]) {
    
        OrderFoodAtterModel *model=   dataArr[ but.sumIndexPath-1000];
        OrderFoodAtterModel *submodel=model.dishAdd[but.tag];
        submodel.selectNum++;
         [self getPrice];
      
        UICollectionView *table=(UICollectionView *)[_mScrollView viewWithTag:but.sumIndexPath ];
        if ([table isKindOfClass:[UICollectionView class]]) {
              [table reloadData];
        }
      
    }
    else
    {
        OrderFoodAtterModel*   model=   addArr[ but.tag];
        model.selectNum++;
        [self getPrice];
        [_singleTable reloadData];
        
    }
 
}
-(void)reducePress:(OrderFoodRightBtn *)but
{
    [_num_tf resignFirstResponder];
    if ([_mic_id isEqualToString:@"0"]) {
        OrderFoodAtterModel *model=   dataArr[ but.sumIndexPath-1000];
        OrderFoodAtterModel *submodel=model.dishAdd[but.tag];
        if ( submodel.selectNum>0) {
            submodel.selectNum--;
            [self getPrice];
         
            UICollectionView *table=(UICollectionView *)[_mScrollView viewWithTag:but.sumIndexPath];
            if ([table isKindOfClass:[UICollectionView class]]) {
                [table reloadData];
            }
        }
   
    }
    else
    {
    OrderFoodAtterModel*   model=   addArr[ but.tag];
    if ( model.selectNum>0) {
        model.selectNum--;
        [self getPrice];
        [_singleTable reloadData];
    }
    }
}
- (IBAction)surePress:(id)sender {
  
    if ([_num_tf.text isEqualToString:@"0"]) {
        [MBProgressHUD showSuccess:@"至少购买一份" toView:self.superview];
        return;
    }

    NSMutableDictionary *data=[NSMutableDictionary dictionary];
    if ([_mic_id isEqualToString:@"0"]) {
        //套餐
        [data setValue:@"0" forKey:@"is_dish"];
        [data setValue:_id forKey:@"cid"];
        [data setValue:[self getMultipleSelectModel] forKey:@"dishData"];
    
        
    }
    else
    {
        [data setValue:@"1" forKey:@"is_dish"];
        [data setValue:_dishes_id forKey:@"cid"];
        [data setValue:[self getAddData:addArr] forKey:@"addData"];
        [data setValue:[self getNorm_idData][@"norm_id"] forKey:@"norm_id"];
        [data setValue:[self getNorm_idData][@"name"] forKey:@"norm_name"];
        [data setValue: [self getTaste_idData][@"taste_id"] forKey:@"taste_id"];
        [data setValue:[self getTaste_idData][@"name"] forKey:@"taste_name"];
      
    }
    [data setValue: _singleLab.text forKey:@"dish_name"];
    [data setValue:single_price forKey:@"single_price"];
    [data setValue:_sumPriceLab.text forKey:@"totalPrices"];
    [data setValue:_num_tf.text forKey:@"totalNum"];
    
    NSDictionary *dict=@{@"getPrice":data};
    
     if ([_mic_id isEqualToString:@"0"]) {
         
          [self chertDataId:_id withDic:dict newDic_isDish:@"0"];
     }
    else
    {
          [self chertDataId:_dishes_id withDic:dict newDic_isDish:@"1"];
    }
  
   
    AddShopCart *cart=[[AddShopCart alloc]init];
    if (_uid.length==0) {
        _uid=@"0";
    }
    cart.user_id=_uid;
    cart.menu_id=_menu_id;
    cart.data=_dataArray;
    cart.id=_cart_id;
    cart.desk_id=_desk_id;
   // [MBProgressHUD showMessage:nil toView:self.superview];
    
    [cart AddShopCartSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
     //   [MBProgressHUD hideAllHUDsForView:self.superview animated:YES];

        if ([code intValue]==200) {
               [self removeFromSuperview];
               self.orderFoodAttributeViewBlock([_num_tf.text integerValue]);
        }
       else
       {  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [MBProgressHUD showSuccess:message toView:self.superview];
       });
       }
      
    } andFailure:^(NSError * _Nonnull error) {
       // [MBProgressHUD hideAllHUDsForView:self.superview animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.superview];
    }];

}
-(void)chertDataId:(NSString *)cid withDic:(NSDictionary *)newDic newDic_isDish:(NSString *)is_dish
{
    BOOL isExit=NO;
    for (int i=0; i<_dataArray.count; i++)
    {
        NSDictionary *dict=_dataArray[i][@"getPrice"];
        NSString *str=[NSString stringWithFormat:@"%@",dict[@"cid"]];
        NSString *str2=[NSString stringWithFormat:@"%@",dict[@"is_dish"]];
        if ([str isEqualToString:cid] && [str2 isEqualToString:is_dish])
        {
            [_dataArray replaceObjectAtIndex:i withObject:newDic];
            isExit=YES;
        }
       
    }
    if (isExit==NO) {
        
        [_dataArray addObject:newDic];
    }
}
//套餐
-(NSArray *)getMultipleSelectModel
{
    NSMutableArray *arr=[NSMutableArray array];
    for ( OrderFoodAtterModel *model in dataArr ) {
        NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:@{@"dish_id":model.dish_id}];
        if (model.dishes_taste_diff.count>0) {
            for (OrderFoodAtterModel *submodel in model.dishes_taste_diff) {
                if (submodel.isSelect) {
                    
                    [ dic setValue:submodel.dishes_taste forKey:@"taste_id"];
                    
                }
            }
        }
        else
        {
              [ dic setValue:@"" forKey:@"taste_id"];
        }
        
          if (model.dishes_type_diff.count>0) {
        for (OrderFoodAtterModel *submodel in model.dishes_type_diff) {
            if (submodel.isSelect) {
             [ dic setValue:submodel.dishes_type forKey:@"norms_id"];
            }
        }
          }
        else
        {
            [ dic setValue:@"" forKey:@"norms_id"];
        }
        
        if (model.dishAdd.count>0) {
            [dic setValue:[self getAddData:model.dishAdd] forKey:@"add"];
        }
        
        
        [arr addObject:dic];
      
    }
    return arr;
}
//规格
-(NSDictionary *)getNorm_idData
{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    for ( OrderFoodAtterModel *model in normsArr ) {
        if (model.isSelect) {
            
            [ dic setValue:model.id forKey:@"norm_id"];
            [ dic setValue:model.norms_label forKey:@"name"];
        }
    
    }
    return dic;
}
//味道
-(NSDictionary *)getTaste_idData
{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    for ( OrderFoodAtterModel *model in tasteArr ) {
        if (model.isSelect) {
            
            [ dic setValue:model.id forKey:@"taste_id"];
            [ dic setValue:model.taste_name forKey:@"name"];
        }
        
    }
    return dic;
}
//加菜数据
-(NSArray *)getAddData:(NSArray *)data
{
    NSMutableArray *arr=[NSMutableArray array];
    for ( OrderFoodAtterModel *model in data ) {
        if (model.selectNum>0) {
            NSMutableDictionary *dic=[NSMutableDictionary dictionary];
            [ dic setValue:model.id forKey:@"add_id"];
            [ dic setValue:[NSString stringWithFormat:@"%d",(int)model.selectNum] forKey:@"num"];
            [arr addObject:dic];
        }
    }
    return arr;
}

-(void)getPrice
{
    if ([_num_tf.text intValue]<1) {
        [MBProgressHUD showSuccess:@"至少购买一份" toView:self.superview];
        return;
    }
    GetPriceModel *model=[[GetPriceModel alloc]init];
    
    if ([_mic_id isEqualToString:@"0"]) {
        //套餐
        model.id=_id;
        model.type=@"2";
        model.dish=[ExChangeJson ArrToJSONString:[self getMultipleSelectModel]];
    }
    else
    {
        model.id=_dishes_id;
        model.type=@"1";
        if ([self getNorm_idData] .count >0) {
               model.norm_id=[NSString stringWithFormat:@"%@",[self getNorm_idData][@"norm_id"]];
        }
       
        if ([self getTaste_idData] .count >0) {
           model.taste_id=[NSString stringWithFormat:@"%@",[self getTaste_idData][@"taste_id"]];
        }

        NSArray *arr=[self getAddData:addArr];
        if (arr.count>0) {
            model.add=[ExChangeJson ArrToJSONString:arr];
        }
        
    }
    model.is_dining=@"1";
 
    model.num= _num_tf.text;
   
    [_sureBtn setBackgroundColor:[UIColor lightGrayColor]];
    _sureBtn.enabled=NO ;
    [MBProgressHUD showMessage:nil toView:self];
    [model GetPriceModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
           [MBProgressHUD hideAllHUDsForView:self animated:YES];
        if ([code intValue]==200) {
            [_sureBtn setBackgroundColor:color(242, 48, 48)];
            _sureBtn.enabled=YES ;
            
            GetPriceModel *model=(  GetPriceModel *)data;
            if (model.data.info.all_price.length>0) {
                // 总价
                    _sumPriceLab.text=[NSString stringWithFormat:@"%@",model.data.info.all_price];
                
            }
            if (model.data.info.single_price.length>0) {
                //单品价格
                   single_price=[NSString stringWithFormat:@"%@",model.data.info.single_price];
            }
        }
        else
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:message toView:self];
            });

            
        }
      
    } andFailure:^(NSError * _Nonnull error) {
        
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self];
    }];
    
}

- (IBAction)addNumPress:(id)sender {
       [_num_tf resignFirstResponder];
    
    NSInteger num= [ _num_tf.text integerValue];
    num ++;
    _num_tf.text=[NSString stringWithFormat:@"%ld",(long)num];
      [self getPrice];
    
}
- (IBAction)reduceNumPress:(id)sender {
     [_num_tf resignFirstResponder];
    NSInteger num= [ _num_tf.text integerValue];
    if (num>1) {
        num --;
        _num_tf.text=[NSString stringWithFormat:@"%ld",(long)num];
        [self getPrice];
    }
}
- (IBAction)cancellPress:(id)sender {
    [self removeFromSuperview];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self validateNumber:string];
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    _num_tf.text=[NSString stringWithFormat:@"%d",[textField.text intValue]];
    if ([textField.text intValue]>0) {
        [self getPrice];
       
    }
    else
    {
        [MBProgressHUD showSuccess:@"至少购买一份" toView:self.superview];
        return;
    }

}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [_sureBtn setBackgroundColor:[UIColor lightGrayColor]];
    _sureBtn.enabled=NO ;
}


@end
