//
//  UIView+TTExtension.h
//  百思不得姐
//
//  Created by 李涛涛 on 16/4/7.
//  Copyright © 2016年 李涛涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TTExtension)
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
//在分类中生命的@property 只会生成方法的声明 不会生成方法的实现和带有下划线的成员变量
@end
