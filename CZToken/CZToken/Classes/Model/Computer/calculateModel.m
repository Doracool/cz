//
//  calculateModel.m
//  CZToken
//
//  Created by jlc on 2018/3/26.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "calculateModel.h"

@implementation calculateModel
- (NSDictionary *)mj_objectClassInArray {
    return  @{@"Data":[calculateDataModel class]};
}
@end

@implementation calculateDataModel
@end
