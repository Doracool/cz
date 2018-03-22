//
//  yuegongView.h
//  CZToken
//
//  Created by jlc on 2018/3/20.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface yuegongView : UIView
@property (strong, nonatomic) IBOutlet UIView *dklbView;
@property (strong, nonatomic) IBOutlet UIView *hkfsView;
@property (strong, nonatomic) IBOutlet UITextField *dkjeTF;
@property (strong, nonatomic) IBOutlet UITextField *dkqxTF;
@property (strong, nonatomic) IBOutlet UITextField *lvTfOne;
@property (strong, nonatomic) IBOutlet UITextField *LvYearTF;
@property (strong, nonatomic) IBOutlet UILabel *syLabel;
@property (strong, nonatomic) IBOutlet UILabel *gjjLabel;
@property (strong, nonatomic) IBOutlet UIButton *jsBtn;
@property (strong, nonatomic) IBOutlet UIView *zuheViewOne;
@property (strong, nonatomic) IBOutlet UIView *zuheViewTwo;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *oneHeight;
@property (strong, nonatomic) IBOutlet UITextField *onegjjtf;
@property (strong, nonatomic) IBOutlet UITextField *sylvTF;
@property (strong, nonatomic) IBOutlet UITextField *sylvBeishu;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewoneTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewtwoTop;
@property (strong, nonatomic) IBOutlet UILabel *dkjeLabel;
@property (strong, nonatomic) IBOutlet UILabel *dklvLabel;
@property (strong, nonatomic) IBOutlet UILabel *lvResult;
@property (strong, nonatomic) IBOutlet UILabel *sdlvResult;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UILabel *hkze;
@property (strong, nonatomic) IBOutlet UILabel *dkys;
@property (strong, nonatomic) IBOutlet UILabel *zflx;
@property (strong, nonatomic) IBOutlet UILabel *myhk;
@property (strong, nonatomic) IBOutlet UIButton *moreBtn;
@end
