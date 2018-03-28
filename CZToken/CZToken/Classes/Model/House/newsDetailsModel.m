//
//  newsDetailsModel.m
//  CZToken
//
//  Created by jlc on 2018/3/28.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "newsDetailsModel.h"

@implementation newsDetailsModel
- (NSDictionary *)mj_objectClassInArray {
    return  @{@"Data":[newsDetailsDataModel class]};
}
@end

@implementation newsDetailsDataModel

@end
