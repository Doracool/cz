//
//  areaModel.h
//  CZToken
//
//  Created by jlc on 2018/3/19.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface areaModel : NSObject
@property (nonatomic, copy) NSString *Code;
@property (nonatomic, strong) NSMutableArray *Data;
@property (nonatomic, copy) NSString *Message;
@property (nonatomic, copy) NSString *Time;
@end

@interface areaDataModel : NSObject
@property (nonatomic, copy) NSString *AreaName;
@property (nonatomic, copy) NSString *CityName;
@property (nonatomic, copy) NSString *Id;
@end
