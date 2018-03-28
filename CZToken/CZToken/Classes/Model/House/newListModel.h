//
//  newListModel.h
//  CZToken
//
//  Created by jlc on 2018/3/28.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface newListModel : NSObject
@property (nonatomic, copy) NSString *Code;
@property (nonatomic, strong) NSMutableArray *Data;
@property (nonatomic, copy) NSString *Message;
@property (nonatomic, copy) NSString *Time;
@end

@interface newListDataModel : NSObject
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *Name;
@end
