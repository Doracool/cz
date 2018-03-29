//
//  loginController.m
//  CZToken
//
//  Created by 周帅杰 on 2018/2/28.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "loginController.h"
#import "foreSigninController.h"
#import "AppDelegate+MainUI.h"
@interface loginController ()

@property (strong, nonatomic) IBOutlet UILabel *myText;
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UIButton *signInBtn;
@property (strong, nonatomic) IBOutlet UIView *verCodeView;
@property (strong, nonatomic) MQVerCodeImageView *verCode;
@property (strong, nonatomic) IBOutlet UIButton *changeVerBtn;
@property (copy, nonatomic) NSString *codeNum;
@property (strong, nonatomic) IBOutlet UITextField *verCodeTF;
@end

@implementation loginController

- (void)viewDidLoad {
    [super viewDidLoad];
    _loginBtn.layer.cornerRadius = 5.0f;
    _loginBtn.layer.masksToBounds = YES;
    _signInBtn.layer.cornerRadius = 5.0f;
    _signInBtn.layer.masksToBounds = YES;
    _signInBtn.layer.borderColor = [UIColor navbackgroundColor].CGColor;
    _signInBtn.layer.borderWidth = 1.0f;
    _changeVerBtn.titleLabel.attributedText = [commonSet AttributeNameFont:12 Color:[UIColor navbackgroundColor] Space:0 qingxie:0 text:@"更换图片" Range:NSMakeRange(0, 4)];
    _myText.attributedText = [commonSet AttributeNameFont:14 Color:[UIColor colorWithHexString:@"999999"] Space:0 qingxie:0 text:_myText.text Range:NSMakeRange(1, _myText.text.length-2)];
    _verCode = [[MQVerCodeImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 35)];
    UIButton *changeVer = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90, 35)];
    _verCode.bolck = ^(NSString *codeStr) {
        _codeNum = [codeStr lowercaseString];
    };
    _verCode.isRotation = YES;
    [_verCode freshVerCode];
    [_verCodeView addSubview:_verCode];
    [_verCodeView addSubview:changeVer];
    [changeVer addTarget:self action:@selector(changeVerClick) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self tabbarHidden];
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [self tabbarShow];
//}

- (void)changeVerClick {
    [_verCode freshVerCode];
}

- (IBAction)loginAction:(UIButton *)sender {
    if (![[_verCodeTF.text lowercaseString] isEqualToString:_codeNum]) {
        SHOW_MESSAGE_VIEW(@"提示", @"验证码错误", @"确定", nil);
        return;
    } else if (_userName.text.length == 0) {
        SHOW_MESSAGE_VIEW(@"提示", @"请输入用户名", @"确定", nil);
        return;
    } else if (_password.text.length == 0) {
        SHOW_MESSAGE_VIEW(@"提示", @"请输入密码", @"确定", nil);
        return;
    }
    
    NSString *URL = [NSString stringWithFormat:@"%@/Passport/Login/Login",BaseUrl];
    NSDictionary *params = @{@"LoginId":_userName.text,@"Password":_password.text,@"Source":@"ios"};
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        if ([dic intValueForKey:@"Code"] == 0) {
            [[NSUserDefaults standardUserDefaults] setObject:[[dic objectForKey:@"Data"] objectForKey:@"AccessToken"] forKey:@"token"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"rootView" object:nil userInfo:nil];
        } else {
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (IBAction)signInAction:(UIButton *)sender {
    foreSigninController *signIn = [[foreSigninController alloc] init];
    [self.navigationController pushViewController:signIn animated:YES];
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
