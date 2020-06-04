//
//  SNTabBarController.m
//  SNTabBarVC
//
//  Created by wangsen on 16/3/26.
//  Copyright © 2016年 wangsen. All rights reserved.
//

#import "SNTabBarController.h"
#import "SNTabBarConst.h"
#import "SNTabBar.h"
#import "SNTabBarItem.h"

#import "FriendFirst.h"
#import "MineFirst.h"
#import "WorkFirst.h"

#import "ShopFirst.h"
#import "SuperiorAcme_Url.h"

/*
 *添加自定义的TabBar,并替换TabBarController中自带的TabBar
 */
#import "SNVersionOneTabBar.h"

@interface SNTabBarController () <SNTabBarDelegate>
@property (nonatomic, strong) SNTabBar * snTabBar;
@end

@implementation SNTabBarController
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
    WorkFirst * vc1 = [[WorkFirst alloc] init];
    vc1.tabBarItem.title = @"项目";
    vc1.tabBarItem.image = [UIImage imageNamed:@"项目灰"];
    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"项目黄"];
    
    ShopFirst * vc2 = [[ShopFirst alloc] init];
    vc2.tabBarItem.title = @"集市";
    
    vc2.tabBarItem.image = [UIImage imageNamed:@"集市灰"];
    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"集市黄"];
    
    FriendFirst * vc3 = [[FriendFirst alloc] init];
    vc3.tabBarItem.title = @"社交";
    vc3.tabBarItem.image = [UIImage imageNamed:@"社交灰"];
    vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"社交黄"];
    

    
    MineFirst * vc4 = [[MineFirst alloc] init];
    vc4.tabBarItem.title = @"我的";
    
    vc4.tabBarItem.image = [UIImage imageNamed:@"我的灰"];
    vc4.tabBarItem.selectedImage = [UIImage imageNamed:@"我的黄"];
   
    
    
    UINavigationController * nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
     [nav1.navigationBar setBarTintColor:[UIColor whiteColor]];
     nav1.navigationBar.tintColor = [UIColor blackColor];
    nav1.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName: [UIColor blackColor]};
    
    UINavigationController * nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    UINavigationController * nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
       UINavigationController * nav4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    
    self.itemImageScale = 0.6;
    self.tabBarBgColor = [UIColor blackColor];
    self.normalItemColor = [UIColor blackColor];
    self.selectedItemColor = [UIColor blackColor];
    
   
    self.itemFont = [UIFont systemFontOfSize:10];
    self.defaultSelectedIndex = 0;
    
    self.viewControllers = @[nav1,nav2,nav3,nav4];
    
}


- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers {
    self.snTabBar.itemImageScale = self.itemImageScale;
    self.snTabBar.tabBarBgColor = self.tabBarBgColor;
     self.snTabBar.normalItemColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.snTabBar.selectedItemColor = color(255, 115, 32);

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
