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
        _text.text = [NSString stringWithFormat:@"￥%@",[[dataDic objectForKey:@"Data"] objectForKey:@"Amount"]];
        _money.text = [NSString stringWithFormat:@"￥%@",[[dataDic objectForKey:@"Data"] objectForKey:@"Amount"]];
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

- (IBAction)cxxyAction:(id)sender {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    [webView loadHTMLString:[[dataDic objectForKey:@"Data"] objectForKey:@"Agreement"] baseURL:nil];
}

- (IBAction)SignAction:(UIButton *)sender {
    
    NSDictionary *params = @{@"Amount":@(0.01),@"InitialAmount":@(0),@"PayType":@"微信",@"Token":TOKEN,@"Source":@"ios"};
    
    NSString *URL = [NSString stringWithFormat:@"%@/Passport/Register/SetPayOrder",BaseUrl];
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        if ([dic intValueForKey:@"Code"] == 0) {
            orderDateModel *model = [orderDateModel mj_objectWithKeyValues:[dic objectForKey:@"Data"]];
            [self checkOrder:model];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    zsViewController *zs = [[zsViewController alloc] init];
    [self.navigationController pushViewController:zs animated:YES];
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
        [_weChatBg setBackgroundColor:[UIColor lineColor]];
    } else {
        [_weChatBg setBackgroundColor:[UIColor navbackgroundColor]];
        [_aliBg setBackgroundColor:[UIColor lineColor]];
    }
}
- (IBAction)moneyChange:(UIButton *)sender {
    sender.selected = !sender.selected;
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
