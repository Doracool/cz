//
//  commonSet.m
//  CZToken
//
//  Created by jlc on 2018/2/25.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "commonSet.h"

@implementation commonSet
- (NSMutableAttributedString *)AttributeName {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@""];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30.0f] range:NSMakeRange(0, 1)];
    
    return attributedString;
}
@end
