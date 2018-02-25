//
//  AppDelegate+MainUI.m
//  CZToken
//
//  Created by jlc on 2018/2/25.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "AppDelegate+MainUI.h"
#import "HomeViewController.h"
#import "HouseSourceController.h"
#import "UserSourceController.h"
#import "ComputerController.h"
#import "MeController.h"
//#import "BaseViewController.h"
//#import "BaseNavigationController.h"

#import "CZTabBarController.h"
@implementation AppDelegate (MainUI)

- (CZTabBarController *)fetchTabbarController {
    [self appAppearanceConfig];
    NSMutableArray * array = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"duigou"],[UIImage imageNamed:@"duigou"],[UIImage imageNamed:@"duigou"],[UIImage imageNamed:@"duigou"],[UIImage imageNamed:@"duigou"], nil];
    NSMutableArray * selectedArray = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"duigou"],[UIImage imageNamed:@"duigou"],[UIImage imageNamed:@"duigou"],[UIImage imageNamed:@"duigou"],[UIImage imageNamed:@"duigou"], nil];
    NSMutableArray * titles = [NSMutableArray arrayWithObjects:@"摄影",@"旅行",@"约拍",@"我的",@"我的", nil];
    
    HomeViewController *vc1 = [[HomeViewController alloc] init];
    HouseSourceController *vc2 = [[HouseSourceController alloc] init];
    UserSourceController *vc3 = [[UserSourceController alloc] init];
    ComputerController *vc4 = [[ComputerController alloc] init];
    MeController *vc5 = [[MeController alloc] init];
    
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    UINavigationController *nav5 = [[UINavigationController alloc] initWithRootViewController:vc5];
    
    self.mainTab = [[CZTabBarController alloc] initWithTabBarSelectedImages:selectedArray normalImages:array titles:titles];
    self.mainTab.viewControllers = @[nav1,nav2,nav3,nav4,nav5];
    self.mainTab.textColor = [UIColor ActionTitleColor];
    
    return self.mainTab;
}
/*
- (NSMutableArray *)fetchAllControllers {
    NSMutableArray *titles = [NSMutableArray arrayWithObjects:@"活动",@"圈子",@"消息",@"我的",@"我的", nil];
    NSMutableArray *images = [NSMutableArray arrayWithObjects:@"ic_activity_uncheck",@"ic_circle_uncheck",@"ic_found_uncheck",@"ic_mine_uncheck",@"ic_mine_uncheck", nil];
    
    NSMutableArray *selectImages = [NSMutableArray arrayWithObjects:@"ic_activity_selected",@"ic_circle_selected",@"ic_found_selected",@"ic_mine_selected",@"ic_mine_selected", nil];
    
    NSMutableArray *classArray = [NSMutableArray arrayWithObjects:@"HomeViewController",@"HouseSourceController",@"UserSourceController",@"ComputerController",@"MeController", nil];
    
    NSMutableArray *viewControllers = [NSMutableArray array];
    
    NSInteger i = 0;
    for (NSString *className in classArray) {
        Class class = NSClassFromString(className);
        if (class) {
            BaseViewController *rootVC = [[class alloc] init];
            if ([rootVC isKindOfClass:[HomeViewController class]]) {
                UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:rootVC];
                [viewControllers addObject:nc];
            } else {
                BaseNavigationController *nc = [[BaseNavigationController alloc] initWithRootViewController:rootVC];
                [viewControllers addObject:nc];
            }
            rootVC.title = titles[i];
            if (IOS7) {
                //设置tabbar中字体与图片
                
                // xcoed6以后
                //#注意 这个地方不能用 不然就会在IOS8 中不能正常显示
                // UIImage *normalImg = [UIImage imageNamed:images[i];
                UIImage *normalImg = [[UIImage imageNamed:images[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                UIImage *selectImg = [[UIImage imageNamed:selectImages[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                
                rootVC.tabBarItem.title = titles[i];
                
                UIColor *nonorColor = [UIColor ActionTitleColor];
                UIColor *selectColor = [UIColor navbackgroundColor];
                rootVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:titles[i] image:nil tag:i+1000];
                
                [rootVC.tabBarItem setFinishedSelectedImage:selectImg withFinishedUnselectedImage:normalImg];
                
                //未选中字体颜色
                [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:nonorColor} forState:UIControlStateNormal];
                
                [rootVC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                           selectColor, NSForegroundColorAttributeName,
                                                           nil] forState:UIControlStateSelected];
                
                //                [UITabBar appearance].translucent = NO;
                //                [[UITabBar appearance] setBackgroundColor:[UIColor redColor]];
                
            }else{
                UIImage *normalImage = [[UIImage imageNamed:images[i]]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                UIImage *selectImage = [[UIImage imageNamed:selectImages[i]]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                
                UIColor *selectColor = [UIColor whiteColor];
                
                rootVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:titles[i] image:normalImage selectedImage:selectImage];
                rootVC.tabBarItem.tag = i + 1000;
                
                UIColor *nonorColor = [UIColor ActionTitleColor];
                //未选中字体颜色
                [rootVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:nonorColor} forState:UIControlStateNormal];
                
                
                [rootVC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                           selectColor, NSForegroundColorAttributeName,
                                                           nil] forState:UIControlStateSelected];
                //                [UITabBar appearance].translucent = NO;
                //                [[UITabBar appearance] setBackgroundColor:[UIColor redColor]];
            }
            
        }
        i++;
    }
    
    return viewControllers;
}
*/

- (void)appAppearanceConfig {
    // 设置UINavigationBar颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor titleNavColor]];
    
    // 设置TITLE的字体颜色
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor titleNavColor],UITextAttributeTextColor,[UIFont boldSystemFontOfSize:19],UITextAttributeFont,nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes:dict];
    
    [[UITableViewCell appearance] setTintColor:[UIColor titleNavColor]];
    
    [[UITabBar appearance] setBarTintColor:[UIColor titleWeekBlackColor]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    
    if ([UINavigationBar instancesRespondToSelector:@selector(setBackIndicatorImage:)])
    {
        // iOS 7
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 5, 5, 5);
        [[UINavigationBar appearance] setBackIndicatorImage:[[[UIImage imageNamed:@"button-Return"] imageWithAlignmentRectInsets:insets] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[[[UIImage imageNamed:@"button-Return"] imageWithAlignmentRectInsets:insets] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(5, 0) forBarMetrics:UIBarMetricsDefault]; // Takes out title
        
    }
    
    
    
    [[UISwitch appearance]setOnTintColor:[UIColor navbackgroundColor]];
}

@end
