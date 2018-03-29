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

#import "loginController.h"

@interface AppDelegate ()<WXApiDelegate,NSURLConnectionDelegate>
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rootView:) name:@"rootView" object:nil];
    self.mainTab = [self fetchTabbarController];
    loginController *loginVC = [[loginController alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
    
    navVC.navigationBar.translucent = NO;
    navVC.navigationBar.barStyle   = UIBarStyleDefault;
    
    //更改导航栏背景色
    navVC.navigationBar.barTintColor = [UIColor navbackgroundColor];
    //更改导航栏字体颜色
    [navVC.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19.0f],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
//    [self.window setRootViewController:navVC];
    
    self.window.rootViewController = navVC;
    
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
    
    [ShareSDK registerActivePlatforms:@[@(SSDKPlatformTypeQQ),@(SSDKPlatformTypeSinaWeibo),@(SSDKPlatformSubTypeWechatSession),@(SSDKPlatformSubTypeWechatTimeline)] onImport:^(SSDKPlatformType platformType) {
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

- (void)rootView:(NSNotification *)notification {
    self.mainTab = [self fetchTabbarController];
    self.window.rootViewController = self.mainTab;
}

- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[PayResp class]]) {
        PayResp *payResult = (PayResp *)resp;
        [[NSNotificationCenter defaultCenter] postNotificationName:WXPAY_NOTIFICATION object:self userInfo:[NSDictionary dictionaryWithObject:payResult forKey:@"wxPayReturn"]];
    } else if ([resp isKindOfClass:[SendAuthResp class]]) {
        // 第三方登录
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            
            NSString *dic = [resultDic objectForKey:@"result"];
            NSData *jsonData = [dic dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:nil];
            
            int  staute = [resultDic intValueForKey:@"resultStatus"];
            switch (staute) {
                case 9000:
                    [self requsetPay:[jsonDic objectForKey:@"sign"]];
                    SHOW_MESSAGE_VIEW(nil, @"支付成功", @"确定", nil);
                    break;
                case 8000:
                    SHOW_MESSAGE_VIEW(nil, @"正在处理中", @"确定", nil);
                    break;
                case 4000:
                    SHOW_MESSAGE_VIEW(nil, @"订单支付失败", @"确定", nil);
                    break;
                case 6001:
                    SHOW_MESSAGE_VIEW(nil, @"用户中途取消", @"确定", nil);
                    break;
                case 6002:
                    SHOW_MESSAGE_VIEW(nil, @"网络连接出错", @"确定", nil);
                    break;
                default:
                    break;
            }
        }];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            
            NSString *dic = [resultDic objectForKey:@"result"];
            NSData *jsonData = [dic dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:nil];
            
            int  staute = [resultDic intValueForKey:@"resultStatus"];
            switch (staute) {
                case 9000:
                    [self requsetPay:[jsonDic objectForKey:@"sign"]];
                    break;
                case 8000:
                    SHOW_MESSAGE_VIEW(nil, @"正在处理中", @"确定", nil);
                    break;
                case 4000:
                    SHOW_MESSAGE_VIEW(nil, @"订单支付失败", @"确定", nil);
                    break;
                case 6001:
                    SHOW_MESSAGE_VIEW(nil, @"用户中途取消", @"确定", nil);
                    break;
                case 6002:
                    SHOW_MESSAGE_VIEW(nil, @"网络连接出错", @"确定", nil);
                    break;
                default:
                    break;
            }
        }];
    }
    return YES;
}

-(void)requsetPay:(NSString *)sign {
    NSString *orderNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"orderNum"];
    NSString *URL = [NSString stringWithFormat:@"%@/Passport/Register/CheckOrder",BaseUrl];
    NSDictionary *params = @{@"SN":orderNum,@"Token":TOKEN,@"Source":@"ios"};
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        if ([dic intValueForKey:@"Code"] == 0) {
            SHOW_MESSAGE_VIEW(nil, @"支付成功", @"确定", nil);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"paySuc" object:nil userInfo:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
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
