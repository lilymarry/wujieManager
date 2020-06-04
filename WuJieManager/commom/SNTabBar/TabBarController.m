//
//  SNTabBarController.m
//  SNTabBarVC
//
//  Created by wangsen on 16/3/26.
//  Copyright © 2016年 wangsen. All rights reserved.
//

#import "TabBarController.h"
#import "SNTabBarConst.h"
#import "SNTabBar.h"
#import "SNTabBarItem.h"

#import "RowNum.h"

#import "EatIn.h"
#import "TakeAway.h"

#import "DiningRoomNews.h"
#import "SuperiorAcme_Url.h"

/*
 *添加自定义的TabBar,并替换TabBarController中自带的TabBar
 */
#import "SNVersionOneTabBar.h"

@interface TabBarController () <SNTabBarDelegate>
@property (nonatomic, strong) SNTabBar * snTabBar;
@end

@implementation TabBarController
{
    
    UIButton *moreBtn;
    UIImageView * moreBtnImage;
    UILabel * moreBtnLabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //图片比例
    self.itemImageScale = 0.7f;
    self.defaultSelectedIndex = 0;
    
    /*
     *替换系统默认的TabBar为自定义的TabBar
     */
    [self setValue:[[SNVersionOneTabBar alloc] init] forKey:@"tabBar"];
    
    //创建tabBar
    [self createSNTabBar];
    
    //创建子控制器
    [self CreatChildController];
    
}

- (void)createSNTabBar {
    self.snTabBar = [[SNTabBar alloc] initWithFrame:self.tabBar.bounds];
    self.snTabBar.delegate = self;
    [self.tabBar addSubview:self.snTabBar];
}

-(void)CreatChildController{
    RowNum * vc1 = [[RowNum alloc] init];
    vc1.tabBarItem.title = @"排号";
    vc1.tabBarItem.image = [UIImage imageNamed:@"排号灰"];
    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"排号红"];
    
    EatIn * vc2 = [[EatIn alloc] init];
    vc2.tabBarItem.title = @"堂食";
    vc2.tabBarItem.image = [UIImage imageNamed:@"堂点灰"];
    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"堂点红"];
    
    TakeAway * vc3 = [[TakeAway alloc] init];
    vc3.tabBarItem.title = @"外卖";
    vc3.tabBarItem.image = [UIImage imageNamed:@"外卖灰"];
    vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"外卖红"];
    
    
    DiningRoomNews * vc4 = [[DiningRoomNews alloc] init];
    vc4.tabBarItem.title = @"工作台";
    vc4.tabBarItem.image = [UIImage imageNamed:@"工作台灰"];
    vc4.tabBarItem.selectedImage = [UIImage imageNamed:@"工作台红"];
    
    
    
    UINavigationController * nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    [nav1.navigationBar setBarTintColor:navigationHotelColor];
    nav1.navigationBar.tintColor = [UIColor whiteColor];
    nav1.navigationBar.translucent=NO; nav1.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    
    UINavigationController * nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    nav2.navigationBar.translucent=NO;
    [nav2.navigationBar setBarTintColor:navigationHotelColor];
    nav2.navigationBar.tintColor = [UIColor whiteColor];
   nav2.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    UINavigationController * nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    [nav3.navigationBar setBarTintColor:navigationHotelColor];
    nav3.navigationBar.tintColor = [UIColor whiteColor];
    nav3.navigationBar.translucent=NO; nav3.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    UINavigationController * nav4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    [nav4.navigationBar setBarTintColor:navigationHotelColor];
    nav4.navigationBar.tintColor = [UIColor whiteColor];
    nav4.navigationBar.translucent=NO; nav4.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    
    self.itemImageScale = 0.6;
    self.tabBarBgColor = [UIColor blackColor];
    self.normalItemColor = [UIColor blackColor];
    self.selectedItemColor = [UIColor blackColor];
    
    self.itemFont = [UIFont systemFontOfSize:10];
    self.defaultSelectedIndex = 0;
    
    self.viewControllers = @[nav1,nav2];
    
}


- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers {
    self.snTabBar.itemImageScale = self.itemImageScale;
    self.snTabBar.tabBarBgColor = self.tabBarBgColor;
    //   self.snTabBar.normalItemColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    // self.snTabBar.selectedItemColor = color(255, 115, 32);
    
    self.snTabBar.normalItemColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.snTabBar.selectedItemColor = navigationHotelColor;
    
    self.snTabBar.itemFont = self.itemFont;
    [viewControllers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController * vc = obj;
        UIImage * normalImage = vc.tabBarItem.image;
        UIImage * selectedImage = vc.tabBarItem.selectedImage;
        NSString * title = vc.tabBarItem.title;
        [self.snTabBar sn_addNormalImage:normalImage selectedImage:selectedImage itemTitle:title];
        [self addChildViewController:vc];
        SNTabBarItem * tabBarItem = (SNTabBarItem *)[self.snTabBar viewWithTag:idx + kItemStartTag];
        tabBarItem.tabBarItem = vc.tabBarItem;
    }];
    self.snTabBar.defaultSelectedIndex = self.defaultSelectedIndex;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //清除原有的tabBarItem
    [self removeOriginControls];
    
}

- (void)removeOriginControls {
    for (id obj in self.tabBar.subviews) {
        if ([obj isKindOfClass:[UIControl class]]) {
            [obj removeFromSuperview];
        }
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    self.snTabBar.selectedItem.selected = NO;
    SNTabBarItem * tabBarItem = self.snTabBar.items[selectedIndex];
    tabBarItem.selected = YES;
    self.snTabBar.selectedItem = tabBarItem;
}

#pragma mark - SNTabBarDelegate
- (void)tabBar:(SNTabBar *)tabBar item:(SNTabBarItem *)tabBarItem selectedIndex:(NSInteger)index {
    self.selectedIndex = index;
    
    
}

@end
