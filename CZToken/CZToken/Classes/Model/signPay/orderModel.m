//
//  orderModel.m
//  CZToken
//
//  Created by jlc on 2018/3/27.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "orderModel.h"

@implementation orderModel
- (NSDictionary *)mj_objectClassInArray {
    return  @{@"Data":[orderDateModel class]};
}
@end

@implementation orderDateModel

@end

