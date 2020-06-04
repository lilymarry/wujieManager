//
//  AppDelegate.m
//  WuJieManager
//
//  Created by 天津沃天科技 on 2019/4/17.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//


static NSString *appKey = @"8ca752e9c56ad02dc93990f9";
static NSString *channel = @"AppStore";
static BOOL isProduction = 0;//0 开发模式 1 生产模式

#import "AppDelegate.h"
#import "SNTabBarController.h"
#import "SLand.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK头文件
#import "WeiboSDK.h"

//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加”-ObjC”

#import <Hyphenate/Hyphenate.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import "SNPayManager.h"
#import "JPUSHService.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#import "LoginIn.h"
#endif

@interface AppDelegate ()<EMClientDelegate,JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window.backgroundColor = [UIColor whiteColor];
 // [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
   
    //注册ShareSDK
    [self myShreSDK];
    //注册百度地图
    [self baiduMap];
    //注册环信3.0
    [self startHyphenate:application andDic:launchOptions];
  
    //注册微信支付
    [[SNPayManager sharePayManager] registerWechatAppID:@"wxc971edce6f70ca57"];
    //注册支付宝
    [[SNPayManager sharePayManager] registerAlipayPatenerID:@"2016052801453164" seller:@"" appScheme:@"alisdkSuperiorAcme" privateKey:@""];
  
    [self landSuccess];
    
    
    return YES;
}

#pragma mark - 极光
-(void)jPushSetting:(NSDictionary *)launchOptions{
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions
                           appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
            [[NSUserDefaults standardUserDefaults] setValue:registrationID forKey:@"SA_RegistrationID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    
}


#pragma mark - 注册shareSDK
- (void)myShreSDK {
    /**初始化ShareSDK应用
     @param activePlatforms
     使用的分享平台集合
     @param importHandler (onImport)
     导入回调处理，当某个平台的功能需要依赖原平台提供的SDK支持时，需要在此方法中对原平台SDK进行导入操作
     @param configurationHandler (onConfiguration)
     配置回调处理，在此方法中根据设置的platformType来填充应用配置信息
     */
    [ShareSDK registerActivePlatforms:@[
                                        @(SSDKPlatformTypeSinaWeibo),
                                        @(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformTypeQQ),
                                        ]
                             onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"907160085"
                                           appSecret:@"7603d8595ee38675d60d66ee3737bbaf"
                                         redirectUri:@"http://api.wujiemall.com/OAuth2.html"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wxc971edce6f70ca57"
                                       appSecret:@"4d636c8301e5006ae5e035c25ffc41ae"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1106399064"
                                      appKey:@"y1JV82fc5MUE1F8b"
                                    authType:SSDKAuthTypeBoth];
                 break;
                 //echo 'ibase=10;obase=16;1106399064'|bc
             default:
                 break;
         }
     }];
}
#pragma mark - 注册百度
- (void)baiduMap {
    BMKMapManager * mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [mapManager start:@"BMBtDsRIlWXtuAGR9nKrOSIBU8Vu0LmL" generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
}
#pragma mark - 注册环信
- (void)startHyphenate:(UIApplication *)application andDic:(NSDictionary *)launchOptions{
    //AppKey:注册的AppKey，详细见下面注释。
    //apnsCertName:推送证书名（不需要加后缀），详细见下面注释。
    EMOptions *options = [EMOptions optionsWithAppkey:@"1132170721115445#wjyp"];
    options.apnsCertName = @"dis";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    //推送配置
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //注册推送, 用于iOS8以及iOS8之后的系统
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
        [application registerUserNotificationSettings:settings];
    } else {
        //注册推送，用于iOS8之前的系统
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:myTypes];
    }
    
    //遵守环信协议
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    
    [self jPushSetting:launchOptions];
}
// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationDidEnterBackground:application];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}
// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}
//当前登录账号在其它设备登录时会接收到该回调
- (void)userAccountDidLoginFromOtherDevice {
  /*
    [[SRegisterLogin shareInstance] deleteUserInfo];
    SLand * land = [[SLand alloc] init];
    UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
    self.window.rootViewController = landNav;
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的账号在另一台设备登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定" , nil];
    [alert show];
   */
}
//推送
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}
// 将得到的deviceToken传给SDK
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[EMClient sharedClient] bindDeviceToken:deviceToken];
        NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
        [JPUSHService registerDeviceToken:deviceToken];
    });
    
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"iOS7及以上系统，收到通知:%@", [self logDic:userInfo]);
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
        
      
    
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler();  // 系统要求执行这个方法
}
#endif

- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

//收到推送消息
- (void)messagesDidReceive:(NSArray *)aMessages {
    for (EMMessage *msg in aMessages) {
        UIApplicationState state = [[UIApplication sharedApplication] applicationState]
    }
}

#pragma mark - 登录
- (void)landSuccess {

    //无界餐厅
   LoginIn * tabBarController = [[LoginIn alloc] init];
    self.window.rootViewController = tabBarController;

    //无界管家
   // SNTabBarController * tabBarController = [[SNTabBarController alloc] init];
   // self.window.rootViewController = tabBarController;

}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background stat//e.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 外置app跳转返回 （iOS9之前）
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [self shareUrl:url];
}
#pragma mark - 外置app跳转返回 （iOS9+）
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    return [self shareUrl:url];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [self shareUrl:url];
}
- (BOOL)shareUrl:(NSURL *)url {
  
    if ([url.host isEqualToString:@"SFightGroups"]) {
        NSString *parameterStr = url.query;
        NSArray *parameterArray = [parameterStr componentsSeparatedByString:@"&"];
        NSMutableDictionary *dit = [NSMutableDictionary dictionary];
        for (NSString *tempStr in parameterArray) {
            NSArray *tempArray = [tempStr componentsSeparatedByString:@"="];
            [dit setObject:tempArray[1] forKey:tempArray[0]];
        }
//        SFightGroups * join = [[SFightGroups alloc] init];
//        join.group_buy_order_id = dit[@"group_buy_order_id"];
//        join.goods_id = dit[@"goods_id"];
//        join.product_id = dit[@"product_id"];
//        join.merchant_id = dit[@"merchant_id"];
//        join.group_buy_id = dit[@"group_buy_id"];
//        join.hidesBottomBarWhenPushed = YES;
//        UINavigationController *nv = ((SNTabBarController *)self.window.rootViewController).viewControllers[0];
//        [nv pushViewController:join animated:YES];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[SNPayManager sharePayManager] sn_alipayHandleOpenURL:url];
            if ([url.host isEqualToString:@"pay"]) {
                [[SNPayManager sharePayManager] sn_wechatHandleOpenURL:url];
            }
            //            [[SNPayManager sharePayManager] sn_wechatHandleOpenURL:url];
        });
    }
    return YES;
}


@end
