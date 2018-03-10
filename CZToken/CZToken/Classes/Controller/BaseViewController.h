//
//  BaseViewController.h
//  CZToken
//
//  Created by jlc on 2018/2/26.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
/**
 * 自定义navgationBar返回item（默认pop返回）
 * image item的图片
 */
-(void)backBarButtonItem:(NSString *)image;

/**
 * 自定义navgationBar左边item（默认pop返回）
 * image item的图片
 */
-(void)leftNavBarItemWithImage:(NSString *)image;
/**
 * 自定义navgationBar左边item
 * 纯文字类型
 */
-(void)leftNavBarItemWithTitle:(NSString *)title AndSel:(SEL)selector;

/**
 * 自定义navgationBar左边item
 * image item的普通状态图片
 * selector 动态方法
 */
-(void)leftNavBarItemWithImage:(NSString *)image AndSel:(SEL)selector;
/**
 * 自定义navgationBar左边item
 * norImage item的普通状态图片
 * selImage item的选中状态图片
 * selector 动态方法
 */
-(void)leftNavBarItemWithImage:(NSString *)norImage SelectImage:(NSString *)selImage AndSel:(SEL)selector;

/**
 * 自定义navgationBar右边items 图片数组
 
 */
-(void)rightNavBarItemWithImages:(NSArray*)imgs andSel:(SEL)selector;

/**
 * 自定义navgationBar右边item
 * norImage item的普通状态图片
 * selector 动态方法
 */
-(void)rightNavBarItemWithImage:(NSString *)norImage AndSel:(SEL)selector;

/**
 * 自定义navgationBar右边item
 * norImage item的普通状态图片
 * selImage item的选中状态图片
 * selector 动态方法
 */
-(void)rightNavBarItemWithImage:(NSString *)norImage HlImage:(NSString *)hlImage AndSel:(SEL)selector;

/**
 * 自定义左边的NavigationBarItem
 */
-(void)rightNavBarItemWithTitle:(NSString *)title AndSel:(SEL)selector;

/**
 * 自定义右边的NavigationBarItem
 * 文字类型的item (分为普通标题和选中的标题)
 */
-(void)rightNavBarItemWithTitle:(NSString *)title AndSelTitle:(NSString *)selTitle AndSel:(SEL)selector;

-(void)rightNavBarItemWithTitleFaBu:(NSString*)title AndImage:(NSString*)image AndSel:(SEL)selector;


/**
 * 显示navigationBar
 */
-(void)navigationBarShow;
/**
 * 隐藏navigationBar
 */
-(void)navigationBarHidden;


/**
 * 显示tabBar
 */
-(void)tabbarShow;


/**
 * 隐藏tabBar
 */
-(void)tabbarHidden;

/**
 * 手机号验证
 */
- (BOOL)isValidateMobile:(NSString *)mobile;

/**
 * 身份证号验证
 */
- (BOOL)CheckIsIdentityCard:(NSString *)identityCard;
@end
