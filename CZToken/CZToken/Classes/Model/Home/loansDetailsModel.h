//
//  loansDetailsModel.h
//  CZToken
//
//  Created by jlc on 2018/3/22.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface loansDetailsModel : NSObject
@property (nonatomic, copy) NSString *Code;
@property (nonatomic, strong) NSMutableArray *Data;
@property (nonatomic, copy) NSString *Message;
@property (nonatomic, copy) NSString *Time;
@end

@interface loansDetailsDataModel : NSObject
@property (nonatomic, copy) NSString *Number;
@property (nonatomic, copy) NSString *RepayMonthly;
@end
