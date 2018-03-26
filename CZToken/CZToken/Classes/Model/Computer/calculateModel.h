//
//  calculateModel.h
//  CZToken
//
//  Created by jlc on 2018/3/26.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface calculateModel : NSObject
@property (nonatomic, copy) NSString *Code;
@property (nonatomic, strong) NSDictionary *Data;
@property (nonatomic, copy) NSString *Message;
@property (nonatomic, copy) NSString *Time;
@end

@interface calculateDataModel : NSObject
@property (nonatomic, copy) NSString *Area;
@property (nonatomic, copy) NSString *BuyDeedTax;
@property (nonatomic, copy) NSString *BuyMortgageFee;
@property (nonatomic, copy) NSString *BuyRegisterFee;
@property (nonatomic, copy) NSString *BuyStampDuty;
@property (nonatomic, copy) NSString *BuyThePrice;
@property (nonatomic, copy) NSString *BuyTotalTax;
@property (nonatomic, copy) NSString *BuyTransactionFee;
@property (nonatomic, copy) NSString *City;
@property (nonatomic, copy) NSString *DeleteTime;
@property (nonatomic, copy) NSString *Describe;
@property (nonatomic, copy) NSString *HouseFlag;
@property (nonatomic, copy) NSString *HousePrice;
@property (nonatomic, copy) NSString *HouseSize;
@property (nonatomic, copy) NSString *HouseTotalFloor;
@property (nonatomic, copy) NSString *HouseTotalPrice;
@property (nonatomic, copy) NSString *HouseType;
@property (nonatomic, copy) NSString *HouseType2;
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *InsertTime;
@property (nonatomic, copy) NSString *IsFirst;
@property (nonatomic, copy) NSString *IsLoan;
@property (nonatomic, copy) NSString *IsOnly;
@property (nonatomic, copy) NSString *Mark;
@property (nonatomic, copy) NSString *MemberId;
@property (nonatomic, copy) NSString *MemberName;
@property (nonatomic, copy) NSString *PropertyRight;
@property (nonatomic, copy) NSString *Ring;
@property (nonatomic, copy) NSString *SellAddAdditionalTax;
@property (nonatomic, copy) NSString *SellAddTax;
@property (nonatomic, copy) NSString *SellAdditionalTax;
@property (nonatomic, copy) NSString *SellAssessmentFee;
@property (nonatomic, copy) NSString *SellPersonalTax;
@property (nonatomic, copy) NSString *SellStampDuty;
@property (nonatomic, copy) NSString *SellSurveyingFee;
@property (nonatomic, copy) NSString *SellTotalTax;
@property (nonatomic, copy) NSString *SellTransactionFee;
@property (nonatomic, copy) NSString *TradeType;
@property (nonatomic, copy) NSString *UpdateTime;
@property (nonatomic, copy) NSString *Version;
@end
