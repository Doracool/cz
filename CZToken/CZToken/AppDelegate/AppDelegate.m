//
//  AppDelegate.m
//  CZToken
//
//  Created by jlc on 2018/2/25.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+MainUI.h"
#import "ShareSDK/ShareSDK.h"
#import "ShareSDKConnector/ShareSDKConnector.h"
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"

@interface AppDelegate ()<WXApiDelegate>
{
    BMKMapManager *_mapManager;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //启动隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    self.window.backgroundColor = [UIColor blackColor];
    self.mainTab = [self fetchTabbarController];
    self.window.rootViewController = self.mainTab;
    
    [self.window makeKeyAndVisible];
    // 解决键盘遮挡TextView/TextFiled的工具
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
    //定位
    _mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [_mapManager start:@"aObcO5txyFHZUG6wqy5l7b4nx589Quzc" generalDelegate:nil];
    if (!ret) {
        NSLog(@"集成失败");
    }
    // 微信
    [WXApi registerApp:KWeChatKey];
    
    if (IOS7) {
        // 设置状态栏的样式  LightContent 字体为白色
        [application setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    
    [ShareSDK registerActivePlatforms:@[@(SSDKPlatformTypeQQ),@(SSDKPlatformTypeSinaWeibo),@(SSDKPlatformTypeWechat)] onImport:^(SSDKPlatformType platformType) {
        switch (platformType) {
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
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        switch (platformType) {
            case SSDKPlatformTypeSinaWeibo:
                [appInfo SSDKSetupSinaWeiboByAppKey:@"" appSecret:@"" redirectUri:@"" authType:SSDKAuthTypeBoth];
                break;
            case SSDKPlatformTypeWechat:
                [appInfo SSDKSetupWeChatByAppId:KWeChatKey appSecret:KWeChatAppSecret];
                break;
            case SSDKPlatformTypeQQ:
                [appInfo SSDKSetupQQByAppId:KQQAppId appKey:KQQAppkey authType:SSDKAuthTypeBoth];
                break;
            default:
                break;
        }
    }];
    
    return YES;
}

- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[PayResp class]]) {
        PayResp *payResult = (PayResp *)resp;
        [[NSNotificationCenter defaultCenter] postNotificationName:WXPAY_NOTIFICATION object:self userInfo:[NSDictionary dictionaryWithObject:payResult forKey:@"wxPayReturn"]];
    } else if ([resp isKindOfClass:[SendAuthResp class]]) {
        // 第三方登录
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
