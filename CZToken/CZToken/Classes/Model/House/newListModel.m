//
//  newListModel.m
//  CZToken
//
//  Created by jlc on 2018/3/28.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "newListModel.h"

@implementation newListModel
- (NSDictionary *)mj_objectClassInArray {
    return  @{@"Data":[newListDataModel class]};
}
@end


@implementation newListDataModel

@end
