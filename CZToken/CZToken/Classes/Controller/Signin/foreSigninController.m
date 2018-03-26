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
#import "WXpayData.h"
@interface foreSigninController ()
@property (strong, nonatomic) IBOutlet UILabel *myText;
@property (strong, nonatomic) IBOutlet UITextField *phone;
@property (strong, nonatomic) IBOutlet UITextField *code;
@property (strong, nonatomic) IBOutlet UIButton *codeBtn;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *password2;
@property (strong, nonatomic) IBOutlet UILabel *money;
@property (strong, nonatomic) IBOutlet UIImageView *moneyIcon;
@property (strong, nonatomic) IBOutlet UIButton *moneyIconBtn;
@property (strong, nonatomic) IBOutlet UILabel *moenyText;
@property (strong, nonatomic) IBOutlet UIButton *signin;

@end

@implementation foreSigninController

- (void)viewDidLoad {
    [super viewDidLoad];
    _myText.attributedText = [commonSet AttributeNameFont:20 Color:[UIColor colorWithHexString:@"666666"] Space:5 qingxie:0 text:_myText.text Range:NSMakeRange(0, _myText.text.length)];
    _myText.attributedText = [commonSet AttributeNameFont:14 Color:[UIColor colorWithHexString:@"999999"] Space:0 qingxie:0 text:_myText.text Range:NSMakeRange(1, _myText.text.length-2)];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weixinPayReturn:) name:WXPAY_NOTIFICATION object:nil];
    [_phone addTarget:self action:@selector(textFiledDidChange:) forControlEvents:UIControlEventEditingChanged];
    _codeBtn.layer.cornerRadius = 5.0f;
    _codeBtn.layer.masksToBounds = YES;
    _signin.layer.cornerRadius = 5.0f;
    _signin.layer.masksToBounds = YES;
    _moneyIconBtn.hidden = YES;
    _moenyText.hidden = YES;
    _money.hidden = YES;
    self.title = @"注册";
    // Do any additional setup after loading the view from its nib.
}

- (void)textFiledDidChange:(UITextField *)sender {
    BOOL mobile = [self isValidateMobile:sender.text];
    if (!mobile) {
        _codeBtn.userInteractionEnabled = NO;
        _signin.userInteractionEnabled = NO;
        [_codeBtn setBackgroundColor:[UIColor colorWithRed:288/255 green:67/255 blue:73/255 alpha:0.4]];
        
        [_signin setBackgroundColor:[UIColor colorWithRed:288/255 green:67/255 blue:73/255 alpha:0.4]];
    } else {
        _codeBtn.userInteractionEnabled = YES;
        _signin.userInteractionEnabled = YES;
        [_codeBtn setBackgroundColor:[UIColor colorWithHexString:@"E44349"]];
        [_signin setBackgroundColor:[UIColor colorWithHexString:@"E44349"]];
    }
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
    NSString *URL = [NSString stringWithFormat:@"%@/Passport/Register/VerificationCode",BaseUrl];
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *params = @{@"Phone":_phone.text,@"Source":@"ios"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (IBAction)signinAction:(UIButton *)sender {
    
    
    NSString *URL = [NSString stringWithFormat:@"%@/Passport/Register/SavePhone",BaseUrl];
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (_password.text.length == 0 || _password2.text.length == 0) {
        SHOW_MESSAGE_VIEW(@"提示", @"请填写密码", @"确认", nil);
        return;
    } else if (_password.text != _password2.text) {
        SHOW_MESSAGE_VIEW(@"提示", @"两次密码不一致", @"确认", nil);
        return;
    }
    NSDictionary *params = @{@"Phone":_phone.text,@"Code":_code.text,@"Source":@"ios",@"Password":_password.text,@"Password2":_password2.text};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        NSString *token = [dic objectForKey:@"Data"];
        UpInfoController *upinfo = [[UpInfoController alloc] init];
        upinfo.token = token;
        [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
        [self.navigationController pushViewController:upinfo animated:YES];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
     
//    addUserInfoController *user = [[addUserInfoController alloc] init];
//
    }

- (void)pay {
    NSDictionary *dic;
    WXpayData *req = [[WXpayData alloc] init];
    req.openID = [dic stringForKey:@""];
    req.partnerId = [dic stringForKey:@""];
    req.prepayId = [dic stringForKey:@""];
    req.nonceStr = [dic stringForKey:@""];
    req.timeStamp = [dic intValueForKey:@""];
    req.package = @"Sign=WXPay";
    
    NSString *sign = [dic stringForKey:@""];
    
    req.sign = sign;
    PayReq *payData = [[PayReq alloc] init];
    payData = req;
    if ([WXApi sendReq:payData]) {
        NSLog(@"WeChat Success");
    } else {
        NSLog(@"WeChat Failed");
    }
}

- (void)aliPay {
    NSString *appScheme = @"alisdkdemo";
    [[AlipaySDK defaultService] payOrder:@"" fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
        
        int staute = [resultDic intValueForKey:@"resultStatus"];
        
        NSString *dic = [resultDic objectForKey:@"result"];
        
        switch (staute) {
            case 9000: {
                //支付完成的回调
            }
                break;
            case 8000:
                SHOW_MESSAGE_VIEW(nil, @"正在处理中", @"确定", nil);
                break;
            case 4000:
                SHOW_MESSAGE_VIEW(nil, @"订单支付失败", @"确定", nil);
                break;
            case 6001:
                SHOW_MESSAGE_VIEW(nil, @"用户中途取消", @"确定", nil);
                break;
            case 6002:
                SHOW_MESSAGE_VIEW(nil, @"网络连接出错", @"确定", nil);
                break;
            default:
                break;
        }
        
    }];
    
}

- (void)weixinPayReturn:(NSNotification *)info {
    
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
