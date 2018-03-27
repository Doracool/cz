//
//  cxMoneyController.h
//  CZToken
//
//  Created by jlc on 2018/2/28.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cxMoneyController : BaseViewController

@property (strong, nonatomic) IBOutlet UILabel *text;
@property (strong, nonatomic) IBOutlet UILabel *money;
@property (strong, nonatomic) IBOutlet UILabel *allMoney;
@property (strong, nonatomic) IBOutlet UIButton *question;
@property (strong, nonatomic) IBOutlet UIButton *question2;
@property (strong, nonatomic) IBOutlet UIButton *rule;
@property (strong, nonatomic) IBOutlet UIButton *aliPay;
@property (strong, nonatomic) IBOutlet UIImageView *aliBg;
@property (strong, nonatomic) IBOutlet UIButton *weChatPay;
@property (strong, nonatomic) IBOutlet UIImageView *weChatBg;
@property (strong, nonatomic) IBOutlet UIButton *cxjBtn;
@property (strong, nonatomic) IBOutlet UIButton *csrBtn;
@property (strong, nonatomic) IBOutlet UIButton *yuedu;
@end
