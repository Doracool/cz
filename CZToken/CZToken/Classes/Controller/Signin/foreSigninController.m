//
//  foreSigninController.m
//  CZToken
//
//  Created by jlc on 2018/2/28.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "foreSigninController.h"
#import "UpInfoController.h"
#import "addUserInfoController.h"
@interface foreSigninController ()
@property (strong, nonatomic) IBOutlet UITextField *phone;
@property (strong, nonatomic) IBOutlet UITextField *code;
@property (strong, nonatomic) IBOutlet UIButton *codeBtn;
@property (strong, nonatomic) IBOutlet UILabel *money;
@property (strong, nonatomic) IBOutlet UIImageView *moneyIcon;
@property (strong, nonatomic) IBOutlet UILabel *moenyText;
@property (strong, nonatomic) IBOutlet UIButton *signin;

@end

@implementation foreSigninController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self tabbarHidden];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self tabbarShow];
}

- (void)setBaseView {
    _codeBtn.layer.cornerRadius = 5.0f;
    _codeBtn.layer.masksToBounds = YES;
    _signin.layer.cornerRadius = 5.0f;
    _signin.layer.masksToBounds = YES;
}

- (IBAction)codeAction:(UIButton *)sender {
    
}
- (IBAction)signinAction:(UIButton *)sender {
    addUserInfoController *user = [[addUserInfoController alloc] init];
    
    UpInfoController *upinfo = [[UpInfoController alloc] init];
    [self.navigationController pushViewController:upinfo animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
