//
//  UIBarButtonItem+Extension.m
//  CopyWeibo
//
//  Created by qingyun on 16/2/17.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+TTExtension.h"
@implementation UIBarButtonItem (Extension)
/**
 *  创建一个item
 *
 *  @param action    点击item调用的控制器
 *  @param action    点击item,调用方法
 *  @param image     正常时候的图片
 *  @param highImage 高亮时候的图片
 *
 *  @return 返回的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target Action:(SEL)action Image:(NSString *)image HighImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    btn.size = btn.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
