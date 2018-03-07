//
//  houseImgController.h
//  CZToken
//
//  Created by jlc on 2018/3/6.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface houseImgController : BaseViewController
@property (strong, nonatomic) IBOutlet UIView *hxView;
@property (strong, nonatomic) IBOutlet UIView *wjView;
@property (strong, nonatomic) IBOutlet UIView *snView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *wjViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *snViewHeight;
@property (strong, nonatomic) IBOutlet UIButton *beforeBtn;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;

@end
