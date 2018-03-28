//
//  houseSourceModel.h
//  CZToken
//
//  Created by jlc on 2018/3/28.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface houseSourceModel : NSObject
@property (nonatomic, copy) NSString *Code;
@property (nonatomic, strong) NSDictionary *Data;
@property (nonatomic, copy) NSString *Message;
@property (nonatomic, copy) NSString *Time;
@end

@interface houseDataModel : NSObject
@property (nonatomic, copy) NSString *IsBroker;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, copy) NSString *total;
@end

@interface sourceDataModel : NSObject
@property (nonatomic, copy) NSString *AuthStatus;
@property (nonatomic, copy) NSString *BuildingNo;
@property (nonatomic, copy) NSString *BusinessArea;
@property (nonatomic, copy) NSString *CityArea;
@property (nonatomic, copy) NSString *CommunityName;
@property (nonatomic, copy) NSString *Decoration;
@property (nonatomic, copy) NSString *Feature;
@property (nonatomic, copy) NSString *FloorArea;
@property (nonatomic, copy) NSString *HowmanyHalls;
@property (nonatomic, copy) NSString *HowmanyRooms;
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *IsCollect;
@property (nonatomic, copy) NSString *PictureUrl;
@property (nonatomic, copy) NSString *Price;
@property (nonatomic, copy) NSString *PropertyRight;
@property (nonatomic, copy) NSString *RoomNo;
@property (nonatomic, copy) NSString *SaleOrRental;
@property (nonatomic, copy) NSString *UnitPrice;
@end
