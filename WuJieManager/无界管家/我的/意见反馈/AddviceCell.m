//
//  AddviceCell.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/29.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "AddviceCell.h"
#import "SelectPicView.h"
#import "ZLPhoto.h"
#import "UImageHelper.h"
@interface AddviceCell ()<
UINavigationControllerDelegate,UIImagePickerControllerDelegate,SelectPicViewDelegate,UIActionSheetDelegate>
{
    
   
    SelectPicView *pictureView;
    UIImagePickerController * _imagePickerPhoto;
    UIImagePickerController * _imagePickerCamera;
    NSMutableArray *saveArr;
   
}
@property (strong, nonatomic) IBOutlet UIView *picView;

@end
@implementation AddviceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    saveArr=[NSMutableArray array];
    pictureView = [[SelectPicView alloc] initWithFrame:CGRectMake(0, 0, ScreenW,  70)];
    pictureView.delegate = self;
    pictureView.typeStr=@"1";
    [_picView addSubview:pictureView];
    
    [pictureView refresPictureView:saveArr];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)removeImageView:(int)index andType:(nonnull NSString *)type {
    if (index==8000) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self  pickerCamera];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self  choiceMutSelectImageView];
        }];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action];
        [alert addAction:action2];
        [alert addAction:cancle];
        
        UIPopoverPresentationController *popover = alert.popoverPresentationController;
        if (popover)
        {
            popover.sourceView = self.superview;
            popover.sourceRect = CGRectMake(0, 0, 100, 100);
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
        
      [ [self viewController]  presentViewController:alert animated:YES completion:nil];
  }
   else
    {
        
          [pictureView refresPictureView:saveArr];
    }
}

-(void)pickerCamera
{
    _imagePickerCamera = [[UIImagePickerController alloc] init];
    _imagePickerCamera.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        _imagePickerCamera.sourceType = UIImagePickerControllerSourceTypeCamera;
        CGAffineTransform cameraTransform = CGAffineTransformMakeScale(1.25, 1.25);
        _imagePickerCamera.cameraViewTransform = cameraTransform;
        
        _imagePickerCamera.allowsEditing = YES;
        [[self viewController] presentViewController:_imagePickerCamera animated:YES completion:nil];
    }
}
#pragma mark - 相册多图
- (void)choiceMutSelectImageView {
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
 
    pickerVc.maxCount = 9-saveArr.count;
    pickerVc.status = PickerViewShowStatusCameraRoll;
    pickerVc.photoStatus = PickerPhotoStatusPhotos;
    pickerVc.topShowPhotoPicker = YES;
    pickerVc.isShowCamera = NO;
    pickerVc.callBack = ^(NSArray<ZLPhotoAssets *> *status){
        for (int i = 0; i < status.count; i++) {
            id assets = status[i];
            if ([assets isKindOfClass:[ZLPhotoAssets class]]) {
                ZLPhotoAssets * ddd = (ZLPhotoAssets *)assets;
                UIImage *   scaleImage = [UImageHelper zipIma:ddd.originImage];
                [saveArr addObject:scaleImage];
            }
        }
        
        [pictureView refresPictureView:saveArr];
    };
    [pickerVc showPickerVc:[self viewController]];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
#pragma mark 照相
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        //设置只可拍照
        _imagePickerCamera.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeImage, nil];
        NSString * sourceType = [info objectForKey:UIImagePickerControllerMediaType];
        
        if ([sourceType isEqualToString:(NSString *)kUTTypeImage]) {
            UIImage * imageCamera = info[UIImagePickerControllerEditedImage];
            
            SEL selectorToCall = @selector(imageWasSavedSuccessfully:didFinishSavingWithError:contextInfo:);
            UIImageWriteToSavedPhotosAlbum(imageCamera, self,selectorToCall, nil);
            UIImage * scaleImage= [UImageHelper zipIma:imageCamera];
             [saveArr addObject:scaleImage];
           
             [pictureView refresPictureView:saveArr];
          [[self viewController]  dismissViewControllerAnimated:YES completion:nil];
            
        }
        
    }
   
}
- (void) image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    [MBProgressHUD showSuccess:@"已成功保存到相册!" toView:[UIApplication sharedApplication].delegate.window];
}
- (void)imageWasSavedSuccessfully:(UIImage *)cameraImage didFinishSavingWithError:(NSError *)paramError contextInfo:(void *)paramContextInfo
{
    
    if (paramError == nil){
        
        NSLog(@"保存相册成功");
        
    } else {
        
        NSLog(@"保存相册时发生错误");
        NSLog(@"Error = %@", paramError);
    }
}
- (UIViewController *)viewController

{
    
    for (UIView* next = [self superview]; next; next = next.superview) {
        
        UIResponder *nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)nextResponder;
            
        }
        
    }
    
    return nil;
    
}

@end
