//
//  HistoryDetailListHead.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/26.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "HistoryDetailListHead.h"

@implementation HistoryDetailListHead
{
    
    HistoryDetailListHead *view;
    
}
-(HistoryDetailListHead *)instanceChooseView
{
    
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"HistoryDetailListHead" owner:nil options:nil];
 
    view= [nibView lastObject];
    [view setBounds:CGRectMake(0, 0, 700,50)];
    return view;
}

@end
