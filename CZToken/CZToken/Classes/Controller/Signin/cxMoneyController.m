//
//  cxMoneyController.m
//  CZToken
//
//  Created by jlc on 2018/2/28.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "cxMoneyController.h"
#import "zsViewController.h"
#import "orderModel.h"
#import "loadWebView.h"
@interface cxMoneyController ()
{
    NSDictionary *dataDic;
}
@end

@implementation cxMoneyController

- (void)viewDidLoad {
    [super viewDidLoad];
    _aliBg.layer.cornerRadius = 4.0f;
    _aliBg.layer.masksToBounds = YES;
    
    _weChatBg.layer.cornerRadius = 4.0f;
    _weChatBg.layer.masksToBounds = YES;
    NSString *URL = [NSString stringWithFormat:@"%@/Passport/Register/GetPayData",BaseUrl];
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *params = @{@"Token":TOKEN,@"Source":@"ios"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        dataDic = [NSDictionary dictionary];
        dataDic = dic;
        if ([dic intValueForKey:@"Code"] == 0) {
            _text.text = [NSString stringWithFormat:@"￥%@",[[dataDic objectForKey:@"Data"] objectForKey:@"Amount"]];
            _money.text = [NSString stringWithFormat:@"￥%@",[[dataDic objectForKey:@"Data"] objectForKey:@"InitialAmount"]];
        }
        
        NSLog(@"%@",dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
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
- (IBAction)questionAction:(UIButton *)sender {
    loadWebView *webView = [[loadWebView alloc] init];
    if (sender.tag == 20) {
        webView.HTMLSTR = [[dataDic objectForKey:@"Data"] objectForKey:@"AmountContent"];
    } else {
        webView.HTMLSTR = [[dataDic objectForKey:@"Data"] objectForKey:@"InitialContent"];
    }
    [self.navigationController pushViewController:webView animated:YES];
}

- (IBAction)cxxyAction:(id)sender {
    loadWebView *webView = [[loadWebView alloc] init];
    webView.HTMLSTR = [[dataDic objectForKey:@"Data"] objectForKey:@"Agreement"];
    [self.navigationController pushViewController:webView animated:YES];
}

- (IBAction)SignAction:(UIButton *)sender {
    
    NSDictionary *params = @{@"Amount":@(0.01),@"InitialAmount":@(0),@"PayType":@"支付宝",@"Token":TOKEN,@"Source":@"ios",@"OpenId":[[dataDic objectForKey:@"Data"] objectForKey:@"OpenId"]};
    
    NSString *URL = [NSString stringWithFormat:@"%@/Passport/Register/SetPayOrder",BaseUrl];
    
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        if ([dic intValueForKey:@"Code"] == 0) {
            orderDateModel *model = [orderDateModel mj_objectWithKeyValues:[dic objectForKey:@"Data"]];
//            [self checkOrder:model];
            [[NSUserDefaults standardUserDefaults] setObject:model.SN forKey:@"orderNum"];
            [self payAction:dic];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
//    zsViewController *zs = [[zsViewController alloc] init];
//    [self.navigationController pushViewController:zs animated:YES];
}

- (void)payAction:(NSDictionary *)dic {
    NSString *key = @"111";
    NSString *appScheme = @"alisdkdemo";
    
    NSString *params = [[dic objectForKey:@"Data"] objectForKey:@"Content"];
    __weak __typeof(self) weakSelf = self;
    [[AlipaySDK defaultService] payOrder:params fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
        int  staute = [resultDic intValueForKey:@"resultStatus"];
        NSLog(@"stauts = %d",staute);
        NSString *dic = [resultDic objectForKey:@"result"];
        
        switch (staute) {
            case 9000:{
                NSLog(@"9000 的回调");
                [weakSelf requsetPay:dic andorderNum:@""];
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

#pragma mark 回调事件
-(void)requsetPay:(NSString *)sign andorderNum:(NSString *)ordernum {
    NSString *orderNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"orderNum"];
    NSString *URL = [NSString stringWithFormat:@"%@/Passport/Register/CheckOrder",BaseUrl];
    NSDictionary *params = @{@"SN":orderNum,@"Token":TOKEN,@"Source":@"ios"};
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        if ([dic intValueForKey:@"Code"] == 0) {
            SHOW_MESSAGE_VIEW(nil, @"支付成功", @"确定", nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)checkOrder:(orderDateModel *)model {
    NSString *URL = [NSString stringWithFormat:@"%@/Passport/Register/CheckOrder",BaseUrl];
    NSDictionary *params = @{@"SN":model.SN,@"Token":TOKEN,@"Source":@"ios"};
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (IBAction)PayChange:(UIButton *)sender {
    _aliPay.selected = NO;
    _weChatPay.selected = NO;
    sender.selected = YES;
    if (sender.tag == 12) {
        [_aliBg setBackgroundColor:[UIColor navbackgroundColor]];
        [_weChatBg setBackgroundColor:[UIColor colorWithHexString:@"f5f3f2"]];
    } else {
        [_weChatBg setBackgroundColor:[UIColor navbackgroundColor]];
        [_aliBg setBackgroundColor:[UIColor colorWithHexString:@"f5f3f2"]];
    }
}
- (IBAction)moneyChange:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.tag == 11) {
        if (sender.selected) {
            _allMoney.text = [NSString stringWithFormat:@"%.2f",[[[dataDic objectForKey:@"Data"] objectForKey:@"Amount"] floatValue] + [[[dataDic objectForKey:@"Data"] objectForKey:@"InitialAmount"] floatValue]];
        } else {
            _allMoney.text = [NSString stringWithFormat:@"%.2f",[[[dataDic objectForKey:@"Data"] objectForKey:@"Amount"] floatValue]];
        }
    }
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
