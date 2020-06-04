//
//  WorkMangerDetailCell.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/18.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WorkMangerDetailCell.h"
@interface WorkMangerDetailCell()<WKNavigationDelegate>
{
     BOOL over;
}
@end
@implementation WorkMangerDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:_titleLab.text];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:navigationColor range:NSMakeRange(0,1)];
    [AttributedStr addAttribute:NSBackgroundColorAttributeName value:navigationColor range:NSMakeRange(0,1)];
    _titleLab.attributedText = AttributedStr;
    
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta); var imgs = document.getElementsByTagName('img');for (var i in imgs){imgs[i].style.maxWidth='100%';imgs[i].style.height='auto';}";
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
    _wk_web = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0) configuration:wkWebConfig];
    _wk_web.userInteractionEnabled = YES;
    _wk_web.navigationDelegate = self;
    _wk_web.scrollView.scrollEnabled = NO;
    
    [_thisWk_web addSubview:_wk_web];
}
- (void)wk_web:(NSString *)wk_webHTML {
    [_wk_web loadHTMLString:wk_webHTML baseURL:nil];
}
//页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if (over == YES) {
        return;
    }
    [webView evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id _Nullable any, NSError * _Nullable error) {
        
        
        NSString *heightStr = [NSString stringWithFormat:@"%@",any];
     
        self->over = YES;
        self->_wk_web.frame = CGRectMake(0, 0, ScreenW, heightStr.floatValue + 15);
       
        if (self.data_HTML) {
            self.data_HTML(heightStr.floatValue);
        };
        
    }];
    
  
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
