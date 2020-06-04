//
//  MyQuanyiShiZhiDetail.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/24.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "MyQuanyiShiZhiDetail.h"
#import "UIWebView+UIWebView_LoadHighChart.h"

@interface MyQuanyiShiZhiDetail ()

@end

@implementation MyQuanyiShiZhiDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView* web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenW-10, _dataView.bounds.size.height)];
    
    web.delegate = self;
    
    web.scrollView.bounces = false;
    [_dataView addSubview:web];
    [web loadHightChart];
    self.title=@"权益市值";
    [self createNav];
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

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSArray* cityArr = @[@"01/08",@"01/09",@"01/10",@"01/11",@"01/12",@"01/13",@"01/14",@"01/15",@"01/16"];
    
    
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:cityArr options:NSJSONWritingPrettyPrinted error:nil];
    NSString* json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSArray *arr=@[@[@"01/08",@100] ,@[@"01/09",@0.00],@[@"01/10",@2.660000],@[@"01/11",@1.00] ,@[@"01/12",@7.270000],@[@"01/13",@2.660000],@[@"01/14",@25.840000] ,@[@"01/15",@7.270000],@[@"01/16",@2.660000]];
  //  NSArray *data=@[arr,arr];
    double wide=(double)arr.count*50;
    if (wide<_dataView.frame.size.width) {
        wide=_dataView.frame.size.width;
    }
    
    
    NSData* jsonData1 = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
    NSString* json1 = [[NSString alloc] initWithData:jsonData1 encoding:NSUTF8StringEncoding];
    
    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"showChart($('#container'),'',%@,'',[{type:'line' ,data:%@ , name:'权益市值'}],'line',%f,%f,'#FF7614')",json,json1,wide,_dataView.frame.size.height]];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
