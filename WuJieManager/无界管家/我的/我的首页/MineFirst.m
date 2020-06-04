//
//  MineFirst.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/17.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "MineFirst.h"
#import "MineFirst_top.h"
#import "MineFirstCell.h"
#import "MyQuanyiList.h"
#import "MyWork.h"
#import "MyFocous.h"
#import "HelpCenter.h"
#import "MyBag.h"
#import "SSet.h"
#import "SRegistrationCodeView.h"
#import "SUserGetSignCode.h"
#import "SendAddvice.h"
#import "TabBarController.h"
#import "RowNum.h"
#define NAVBAR_CHANGE_POINT 50
@interface MineFirst ()<UITableViewDelegate,UITableViewDataSource>
{
    MineFirst_top *top;
    
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomHH;

@end

@implementation MineFirst

- (void)viewDidLoad {
    [super viewDidLoad];

    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"MineFirstCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineFirstCell"];
    
    [self createSMineTopView];
    [self createNav];
}
-(void)viewDidAppear:(BOOL)animated
{
    
//    if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
//        SLand * land = [[SLand alloc] init];
//        UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
//        self.view.window.rootViewController = landNav;
//    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar lt_reset];
    
}
- (void)createNav {
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    UIBarButtonItem * rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [rightBtn setImage:[UIImage imageNamed:@"导航栏设置"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem =rightBtnItem ;
    
}
#pragma mark - 设置
- (void)rightBtnClick {
 
//    SSet * set = [[SSet alloc] init];
//    set.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:set animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    //透明
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self scrollViewDidScroll:_mTable];
    
    NSString *version= [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >=10.0&&version.doubleValue <11.0) {
        _bottomHH.constant=44;
        adjustsScrollViewInsets_NO(_mTable, self);
    }
    else
    {
        _bottomHH.constant=0;
        
    }
    
}

- (void)createSMineTopView {
    top = [[MineFirst_top alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 432)];
    __weak typeof(self) weakSelf = self;
    top.topBtnBlock = ^(NSInteger type) {
        [weakSelf topBtnEvent:type];
    };
    _mTable.tableHeaderView = top;
    
}
- (void)topBtnEvent:(NSInteger)num {
   
    if (num==1) {
         MyQuanyiList *list=[[MyQuanyiList alloc]init];
        list.type=@"1";
        list.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:list animated:YES];
    }
    else if  (num==2)
    {
        MyQuanyiList *list=[[MyQuanyiList alloc]init];
        list.type=@"2";
        list.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:list animated:YES];
    }
    else
    {
     
//        TabBarController  *list=[[TabBarController alloc]init];
//
//        UINavigationController *controller= list.viewControllers[0];
//        RowNum *num=(RowNum  *) controller.viewControllers[0];
//         num.type=@"1";
//
//        [self  presentViewController:list animated:YES completion:nil];
    }
  
}
#pragma mark tableView 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    if (section == 1) {
        return 4;
    }
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
 
    return 10;
 
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    MineFirstCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"MineFirstCell" forIndexPath:indexPath];
    cell.nameLab.text = @[@[@"我的卡包",@"任务中心"],@[@"参与的项目" ,@"关注的项目",@"项目推荐",@"我的邀请码"],@[@"帮助中心",@"意见反馈",@"关于我们",@"评分鼓励"]][indexPath.section][indexPath.row];
     cell.imaView.image = [UIImage imageNamed:@[@[@"我的卡包",@"任务中心"],@[@"投资的项目" ,@"关注的项目",@"项目推荐",@"我的邀请码"],@[@"帮助中心",@"意见反馈",@"关于我们",@"评分鼓励"]][indexPath.section][indexPath.row]];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
#pragma mark 我的卡包
        if (indexPath.row==0) {
            MyBag *work=[[MyBag alloc]init];
            work.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:work animated:YES];
        }
    }
    else if (indexPath.section==1)
    {
#pragma mark 参与的项目
        if (indexPath.row==0) {
            MyWork *work=[[MyWork alloc]init];
            work.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:work animated:YES];
        }
#pragma mark 关注的项目
      else  if (indexPath.row==1) {
            MyFocous *work=[[MyFocous alloc]init];
            work.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:work animated:YES];
        }
      else if (indexPath.row == 3) {
#pragma mark - 我的邀请码
          
          SRegistrationCodeView * codeView = [[SRegistrationCodeView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
          
          //给二维码添加点击手势
          UITapGestureRecognizer *codeViewImageTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(QRImageTapGesture:)];
          codeView.thisImage.userInteractionEnabled = YES;
          [codeView.thisImage addGestureRecognizer:codeViewImageTapGesture];
          
          codeView.QRCodeType =@"我的邀请码";
          [[[UIApplication sharedApplication] keyWindow] addSubview:codeView];
          codeView.SRegistrationCodeViewBack = ^{
              [codeView removeFromSuperview];
          };
          
          SUserGetSignCode * signCode = [[SUserGetSignCode alloc] init];
          [signCode sUserGetSignCodeSuccess:^(NSString *code, NSString *message, id data) {
              SUserGetSignCode * signCode = (SUserGetSignCode *)data;
              
              UIImage *qrcode = [self createNonInterpolatedUIImageFormCIImage:[self createQRForString:signCode.data.code] withSize:250.0f];
              UIImage *customQrcode = [self imageBlackToTransparent:qrcode withRed:0.0f andGreen:0.0f andBlue:0.0f];
              codeView.thisImage.image = customQrcode;
              
              [codeView.header_pic sd_setImageWithURL:[NSURL URLWithString:signCode.data.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
              
          } andFailure:^(NSError *error) {
          }];
          
      }
        
    }
    else
    {
#pragma mark  帮助中心
        if (indexPath.row==0) {
            HelpCenter *work=[[HelpCenter alloc]init];
            work.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:work animated:YES];
        }
#pragma mark 意见反馈
        else if (indexPath.row==1)
        {
            SendAddvice *work=[[SendAddvice alloc]init];
            work.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:work animated:YES];
        }
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = navigationColor;
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 50) {
        CGFloat alpha = MIN(1, 1 - ((50 + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
        
        
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
        
        
    }
    
    //获取tableView当前的y偏移
    CGFloat contentOffsety  = scrollView.contentOffset.y;
    NSString *version= [UIDevice currentDevice].systemVersion;
    //如果当前的section还没有超出navigationBar，那么就是默认的tableView的contentInset
    if (contentOffsety<=(200-64)&&contentOffsety>=0) {
        if (KIsiPhoneX) {
            _mTable.contentInset = UIEdgeInsetsMake(-88, 0, 0, 0);
        }
        else
        {
            if (version.doubleValue >=10.0&&version.doubleValue <11.0) {
                _mTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            }
            else
            {
                _mTable.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
                
            }
        }
    }
    //当section将要就如navigationBar的后面时，改变tableView的contentInset的top，那么section的悬浮位置就会改变
    else if(contentOffsety>=200-64){
        if (version.doubleValue >=10.0&&version.doubleValue <11.0) {
            _mTable.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        }
        else
        {
            _mTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            
        }
    }
}
-(void)QRImageTapGesture:(UITapGestureRecognizer *)sender {
    UIImage *image = ((UIImageView *)sender.view).image;
    UIImageWriteToSavedPhotosAlbum(image, self,@selector(image:didFinishSavingWithError:contextInfo:),NULL);
   
}
- (void) image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    [MBProgressHUD showSuccess:@"已成功保存到相册!" toView:[UIApplication sharedApplication].delegate.window];
}
- (CIImage *)createQRForString:(NSString *)qrString {
  
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    return qrFilter.outputImage;
}
#pragma mark - imageToTransparent
void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}
- (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue{
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    // create context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    // traverse pixe
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900){
            // change color
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        }else{
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    // context to image
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    // release
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent),size/CGRectGetHeight(extent));
    // create a bitmap image that we'll draw into a bitmap context at the desired size;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // Create an image with the contents of our bitmap
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    // Cleanup
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

@end
