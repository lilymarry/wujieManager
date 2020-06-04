//
//  UIWebView+UIWebView_LoadHighChart.m
//  HighChartDemo
//
//  Created by 杜甲 on 14-1-7.
//  Copyright (c) 2014年 杜甲. All rights reserved.
//

#import "UIWebView+UIWebView_LoadHighChart.h"
#define ChartHtml @"demo.bundle/adaperHighChart.html"

@implementation UIWebView (UIWebView_LoadHighChart)
-(void)loadHightChart{

    [self performSelectorOnMainThread:@selector(loadDocument:) withObject:ChartHtml waitUntilDone:NO];
}

-(void)loadDocument:(NSString *)docName
{
    NSString *mainBundleDirectory=[[NSBundle mainBundle] bundlePath];
    NSString *path=[mainBundleDirectory stringByAppendingPathComponent:docName];
    
    NSURL *url=[NSURL fileURLWithPath:path];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    [self loadRequest:request];
    
    
}
@end
