//
//  Defines.h
//  CZToken
//
//  Created by jlc on 2018/2/25.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#ifndef Defines_h
#define Defines_h

//配置常量
#define kDefaultDatabase     [[SystemSupport share] databaseName]

#define TOKEN [[NSUserDefaults standardUserDefaults]objectForKey:@"token"]


//--------------------------------------------------------------------
//系统相关设置
//--------------------------------------------------------------------
#define IOSDEVICE [[[UIDevice currentDevice]systemVersion]floatValue] //系统版本

#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)

#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)

#define kBundle  [NSBundle mainBundle]

//----------------------------------------------------------------------------
//屏幕尺寸
//----------------------------------------------------------------------------
#define kScreenWidth ([[UIScreen mainScreen]bounds].size.width)//屏幕宽度

#define kScreenHeight ([[UIScreen mainScreen]bounds].size.height)//屏幕高度

#define kStatusBarHeight ([[UIApplication sharedApplication]statusBarFrame].size.height)//状态栏高度

#define kNavgationBarHeight (64.0f) //NavgationBar的高度

#define kTabBarHeight (49.0f) //下方tabBar的高度

#define kToolBarHeight (44.0f) //下方toolBar的高度

#define kTableViewCellLineHeight (1.0f/([UIScreen mainScreen].scale)) //仿tableview的cell的细线高度
//定义控件在不同系统版本下偏移量。
#define VIEWOFFSET IOS7 ? 64:0

#define kIphone4S ((kScreenHeight <= 480)?YES:NO)  //iPhone4s 以下

#define kScreenPx(px) (roundf((px)*0.3444))  //用户将px的像素长度转换为屏幕点


//判断手机型号.注意模拟器下可能不准确.
#define iPhone3GS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1336), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1080, 1920), [[UIScreen mainScreen] currentMode].size) : NO)

// 第三方

#define KWeChatKey @"" // 微信AppId

#define KWeChatAppSecret @"" // 微信appSecretkey

#define KShareURL @"" // 回调URL（微信）


//----------------------------------------------------------------------------
//有关时间
//----------------------------------------------------------------------------

#define TimeFormat          @"yyyy-MM-dd HH:mm:ss"

#define DuanDateFormat      @"MM-dd"

#define DateFormat          @"yyyy-MM-dd"

#define DateFormat_MM_dd_yyyy          @"MM/dd/yyyy"

#define DateFormatToShow    @"LLL dd, yyyy"

#define DateFormatToShow2   @"LLL dd yyyy"

#define DateFormatToShowLong    @"E, LLL dd yyyy"

#define DateFormatToShowLong2   @"EEEE, LLL dd yyyy"

#define DateFormateForOmniture  @"dd/MM/YYYY HH:mm:ss"

#define BODDateFormat          @"yyyy-MM-dd"

#define TwelveDateFormat       @"yyMMddHHmmss"

#define DateFormatHH_MM        @"HH:mm"

#define DateFormatHHMM        @"HHmm"

#define DateFormatyyyyMMdd     @"yyyyMMdd"

//----------------------------------------------------------------------------
// 常用的其它指令
//----------------------------------------------------------------------------

//修改系统log，使其在release状态下不输出
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif

//判断空字符串
#define NULL_STR(str)   (str == nil || (NSNull *)str == [NSNull null] || str.length == 0)
#define MLString(str) NSLocalizedString(str, @"")
#define SHOW_MESSAGE_VIEW(__title, __message, __cancelButtonTitle,__confirmButtonTitle)  { \
UIAlertView* alert = [[UIAlertView alloc] initWithTitle:__title message:__message delegate:nil cancelButtonTitle:__cancelButtonTitle otherButtonTitles:__confirmButtonTitle]; \
[alert show]; \
}

//#endif /* Defines_h */


//16进制的.
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define showAlert(_msg){UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:_msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定",nil];[alert show];}


//定义一些常用的参数
#define  Radius 5


#define Font12   [UIFont systemFontOfSize:12];
#define Font13   [UIFont systemFontOfSize:13];
#define Font14   [UIFont systemFontOfSize:14];
#define Font15   [UIFont systemFontOfSize:15];
#define Font16   [UIFont systemFontOfSize:16];
#define Font17   [UIFont systemFontOfSize:17];
#define Font18   [UIFont systemFontOfSize:18];
#define Font20   [UIFont systemFontOfSize:20];

#endif /* Defines_h */
