//
//  WXpayData.h
//  CZToken
//
//  Created by jlc on 2018/3/10.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXpayData : PayReq
///商户API密钥
@property (nonatomic,copy) NSString  *spKey;
//内部支付流水号
@property (nonatomic,copy) NSString  *tradeNo;
@end
