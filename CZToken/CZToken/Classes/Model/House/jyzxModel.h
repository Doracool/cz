//
//  jyzxModel.h
//  CZToken
//
//  Created by jlc on 2018/3/21.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface jyzxModel : NSObject
@property (nonatomic, copy) NSString *Code;
@property (nonatomic, strong) NSMutableArray *Data;
@property (nonatomic, copy) NSString *Message;
@property (nonatomic, copy) NSString *Time;
@end

@interface jyzxDataModel : NSObject
@property (nonatomic, copy) NSString *CenterName;
@property (nonatomic, copy) NSString *Id;
@end
