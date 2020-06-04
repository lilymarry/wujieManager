//
//  BanquetTimeView.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/5/13.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "BanquetTimeView.h"

@interface BanquetTimeView ()
@property(nonatomic, weak)IBOutlet UILabel *titleLab;
@end

@implementation BanquetTimeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"BanquetTimeView" owner:self options:nil];
        [self addSubview:_thisView];
     
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
-(void)setType:(NSString *)type
{
    _type=type;
    if ([type isEqualToString:@"1"]) {
          _titleLab.text=@"选择预定日期";
        // 设置日期选择控件的地区
        [_datapicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
        [_datapicker setCalendar:[NSCalendar currentCalendar]];
        
        [_datapicker setDate:[NSDate date]];
        
        _datapicker.minimumDate = [NSDate date];
        [_datapicker setDatePickerMode:UIDatePickerModeDate];
    }
   else if ([type isEqualToString:@"2"]) {
        _titleLab.text=@"选择开始时间";
 
        // 设置日期选择控件的地区 24小时制
      [_datapicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"en_GB"]];

        //显示年月日
        
        [_datapicker setDatePickerMode:UIDatePickerModeTime];
    }
   else if ([type isEqualToString:@"3"]) {
       _titleLab.text=@"选择结束时间";
    
       // 设置日期选择控件的地区 24小时制
       [_datapicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"en_GB"]];
       
       [_datapicker setDatePickerMode:UIDatePickerModeTime];
   }
}
- (IBAction)cancellPress:(id)sender {
    [self removeFromSuperview];
}
- (IBAction)confirmDate:(id)sender {
    
    NSDate *date=self.datapicker.date;
    NSString *dateStr;
    if ([_type isEqualToString:@"1"]) {
        dateStr=[self stringFromDate:date DateFormat:@"yyyy-MM-dd"];
    }
    else if ([_type isEqualToString:@"2"]||[_type isEqualToString:@"3"]) {
        dateStr=[self stringFromDate:date DateFormat:@"HH:mm"];
    }
  
    if (self.delgate!=nil&&[self.delgate respondsToSelector:@selector(chooseDateView:type:)]) {
        [self  removeFromSuperview];
        [self.delgate chooseDateView:dateStr type:_type];
        
    }
    
    
}

- (NSString *)stringFromDate:(NSDate *)date DateFormat:(NSString *)dateFormat {
  
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:dateFormat];
        NSString *destDateString = [dateFormatter stringFromDate:date];
        return destDateString;

}
- (IBAction)cancelPress:(id)sender {
    
     [self removeFromSuperview];
}
@end
