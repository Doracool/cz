//
//  homeTradeController.h
//  CZToken
//
//  Created by 周帅杰 on 2018/3/20.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface homeTradeController : BaseViewController

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view2Height;
@property (weak, nonatomic) IBOutlet UIView *view2Small;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *smallHeight;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view3Samll;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view3Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *small2Height;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view4Height;
@property (strong, nonatomic) IBOutlet UIButton *view4addBtn;
@property (strong, nonatomic) IBOutlet UIButton *view4lessBtn;
@property (weak, nonatomic) IBOutlet UIView *view5;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view5Height;
@property (strong, nonatomic) IBOutlet UIButton *view5addBtn;
@property (strong, nonatomic) IBOutlet UIButton *view5lessbtn;
@property (weak, nonatomic) IBOutlet UIButton *jsBtn;
@property (weak, nonatomic) IBOutlet UIView *view6;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view6Height;
@end
