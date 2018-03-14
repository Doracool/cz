//
//  commonSet.m
//  CZToken
//
//  Created by jlc on 2018/2/25.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "commonSet.h"

@implementation commonSet
+ (NSMutableAttributedString *)AttributeNameFont:(CGFloat )font Color:(UIColor *)color Space:(CGFloat )space qingxie:(CGFloat )qingxie text:(NSString *)Str Range:(NSRange )myRange{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:Str];
    // 字体大小
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:myRange];
    // 字体颜色
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:myRange];
    // 字符间距 正加宽  负变窄  0默认
    [attributedString addAttribute:NSKernAttributeName value:@(space) range:myRange];
    
    // 下划线
    
    // 字体倾斜 正直向右
    [attributedString addAttribute:NSObliquenessAttributeName value:@(qingxie) range:myRange];
    return attributedString;
}
@end
