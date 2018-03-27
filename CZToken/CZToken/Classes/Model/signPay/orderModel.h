//
//  orderModel.h
//  CZToken
//
//  Created by jlc on 2018/3/27.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface orderModel : NSObject
@property (nonatomic, copy) NSString *Code;
@property (nonatomic, strong) NSDictionary *Data;
@property (nonatomic, copy) NSString *Message;
@property (nonatomic, copy) NSString *Time;
@end

@interface orderDateModel : NSObject
@property (nonatomic, copy) NSString *Amount;
@property (nonatomic, copy) NSString *SN;
@end
