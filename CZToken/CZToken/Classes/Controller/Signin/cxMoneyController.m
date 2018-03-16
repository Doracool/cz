//
//  cxMoneyController.m
//  CZToken
//
//  Created by jlc on 2018/2/28.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "cxMoneyController.h"
#import "zsViewController.h"
@interface cxMoneyController ()
{
    NSDictionary *dataDic;
}
@end

@implementation cxMoneyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *URL = [NSString stringWithFormat:@"%@/Register/GetPayData",BaseUrl];
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *params = @{@"Token":TOKNE,@"Source":@"ios"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        dataDic = [NSDictionary dictionary];
        dataDic = dic;
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
    zsViewController *zs = [[zsViewController alloc] init];
    [self.navigationController pushViewController:zs animated:YES];
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
