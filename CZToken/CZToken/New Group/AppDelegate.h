//
//  AppDelegate.h
//  CZToken
//
//  Created by jlc on 2018/2/25.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZTabBarController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) CZTabBarController *mainTab;
@end

