//
//  CZTabBarController.h
//  CZToken
//
//  Created by jlc on 2018/2/25.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CZTabbarControllerDelegate <NSObject>
@optional
-(void)cz_selectedViewController:(UIViewController *)viewController;
@end

@interface CZTabBarController : UITabBarController

@property (nonatomic, assign) NSInteger selectedItem;

/** 是否显示中间按钮，默认为NO */
@property (nonatomic, assign) BOOL showCenterItem;

/** 中间按钮的图片 */
@property (nonatomic, strong) UIImage * centerItemImage;

/** 中间按钮控制的试图控制器 */
@property (nonatomic, strong) UIViewController * cz_centerViewController;

/** 文字颜色 */
@property (nonatomic, strong) UIColor * textColor;

@property (nonatomic, weak) id<CZTabbarControllerDelegate>CZDelegate;
    
    /**
     * 指定item设置badgeValue
     */

/**
 *  指定item设置badgeValue
 */
-(void)tabBarBadgeValue:(NSUInteger)value item:(NSInteger)index;

/**
 *  隐藏或显示TabBar
 */
-(void)czTabBarHidden:(BOOL)hidden animated:(BOOL)animated;

/**
 *  隐藏或显示中间试图控制器
 */
-(void)showCenterViewController:(BOOL)show animated:(BOOL)animated;

- (id)initWithTabBarSelectedImages:(NSMutableArray *)selected
                      normalImages:(NSMutableArray *)normal
                            titles:(NSMutableArray *)titles;





@end

@interface CZButton : UIButton
@property (nonatomic, assign) NSUInteger badgeValue;
+ (instancetype)cz_shareButton;

@end
