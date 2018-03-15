//
//  searchAddressController.h
//  CZToken
//
//  Created by jlc on 2018/3/15.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol xiaoquNameDelegate <NSObject>
- (void)selectedName:(NSInteger )index;
@end

@interface searchAddressController : BaseViewController
@property (nonatomic, weak) id<xiaoquNameDelegate> addressDelegate;
@end
