//
//  VideoGroupListView.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/24.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "VideoGroupListView.h"
#import "VideoGroupListViewCell.h"
@interface VideoGroupListView ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *mTable;

@end

@implementation VideoGroupListView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"VideoGroupListView" owner:self options:nil];
        [self addSubview:_thisView];
        
        [_mTable registerNib:[UINib nibWithNibName:@"VideoGroupListViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"VideoGroupListViewCell"];
        _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 4;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VideoGroupListViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"VideoGroupListViewCell" forIndexPath:indexPath];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self removeFromSuperview];
    if (self.videoEntryBlock) {
        self.videoEntryBlock(@"");
    }
    
}
- (IBAction)removeView:(id)sender {
      [self removeFromSuperview];
}


@end
