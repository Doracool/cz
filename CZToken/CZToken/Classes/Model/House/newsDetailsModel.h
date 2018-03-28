//
//  newsDetailsModel.h
//  CZToken
//
//  Created by jlc on 2018/3/28.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface newsDetailsModel : NSObject
@property (nonatomic, copy) NSString *Code;
@property (nonatomic, strong) NSMutableArray *Data;
@property (nonatomic, copy) NSString *Message;
@property (nonatomic, copy) NSString *Time;

@end

@interface newsDetailsDataModel : NSObject
@property (nonatomic, copy) NSString *Abstracts;
@property (nonatomic, copy) NSString *CoverImage;
@property (nonatomic, copy) NSString *Information;
@property (nonatomic, copy) NSString *IssueTime;
@property (nonatomic, copy) NSString *Title;
@end
