//
//  XieyiDetail.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/19.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "XieyiDetail.h"
#import "SignName.h"

@interface XieyiDetail ()
{
    SignName *name;
}
@property (strong, nonatomic) IBOutlet UIImageView *qianZiView;

@end

@implementation XieyiDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"投资协议";
    NSString *saveSign = [[NSUserDefaults standardUserDefaults] objectForKey:@"saveSign"];
    if ([saveSign isEqualToString:@"saveSignOK"]) {
        NSArray *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cachePath = [cache objectAtIndex:0] ;
        
        NSString *voiceName = [cachePath stringByAppendingPathComponent:@"签名.png"];
    
        _qianZiView.image =[UIImage imageWithContentsOfFile:voiceName];
    }
    [self createNav];
}
- (IBAction)qianZiPress:(id)sender
{
     __weak typeof(self) weakSelf = self;
    name = [[SignName alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    name.block = ^(NSData * _Nonnull data) {
        weakSelf .qianZiView.image=[UIImage imageWithData:data];
        
        
    };
    [self.view.window addSubview:name];
   
}
- (void)createNav {
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"黑色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    
    [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
