//
//  HJSignatureView.h
//  HJSignatureDemo
//
//  Created by Ju on 2018/11/22.
//  Copyright © 2018 HJ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^HJSignatureViewSuccessBlock) (NSData * imageData);
typedef void(^HJSignatureViewFailureBlock) (NSString * error);
NS_ASSUME_NONNULL_BEGIN

@interface HJSignatureView : UIView


/**
 清除签名
 */
- (void)clear;



/**
 保存签名

  保存在本地的图片路径
 */
- (void)saveTheSignatureSuccess:(HJSignatureViewSuccessBlock)success andFailure:(HJSignatureViewFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
