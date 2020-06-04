//
//  LineDataCell.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/18.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "LineDataCell.h"
#import "UIWebView+UIWebView_LoadHighChart.h"
@interface LineDataCell ()<UIWebViewDelegate>
{
    NSString *title;
    NSString *color;
}
@end
@implementation LineDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
   _web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenW-16, _dataView.frame.size.height)];
    
   _web.delegate = self;
    
    _web.scrollView.bounces = false;
    [_dataView addSubview:_web];
   
  
    _segment.selectedSegmentIndex=0;
    
}
-(void)setTitleDic:(NSDictionary *)titleDic
{
    title=titleDic[@"title"];
    color=titleDic[@"color"];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSArray* cityArr = @[@"01/08",@"01/09",@"01/10",@"01/11",@"01/12",@"01/13",@"01/14",@"01/15",@"01/16"];
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:cityArr options:NSJSONWritingPrettyPrinted error:nil];
    NSString* json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSArray *arr=@[@[@"01/08",@25.840000] ,@[@"01/09",@7.270000],@[@"01/10",@2.660000],@[@"01/11",@25.840000] ,@[@"01/12",@7.270000],@[@"01/13",@2.660000],@[@"01/14",@25.840000] ,@[@"01/15",@7.270000],@[@"01/16",@2.660000]];
    double wide=(double)arr.count*50;
    if (wide<_dataView.frame.size.width) {
        wide=_dataView.frame.size.width;
    }
    NSData* jsonData1 = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
    NSString* json1 = [[NSString alloc] initWithData:jsonData1 encoding:NSUTF8StringEncoding];
    
    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"showChart($('#container'),'',%@,'',[{type:'line' ,data:%@ , name:'%@'}],'line',%f,%f,'%@')",json,json1,title,wide,_dataView.frame.size.height,color]];
    
}
@end
