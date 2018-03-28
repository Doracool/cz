//
//  houseSourceModel.m
//  CZToken
//
//  Created by jlc on 2018/3/28.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "houseSourceModel.h"

@implementation houseSourceModel
- (NSDictionary *)mj_objectClassInArray {
    return  @{@"Data":[houseDataModel class]};
}
@end
@implementation houseDataModel
- (NSDictionary *)mj_objectClassInArray {
    return  @{@"data":[sourceDataModel class]};
}
@end
@implementation sourceDataModel

@end
