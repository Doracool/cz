//
//  loadWebView.m
//  SYZXFamily
//
//  Created by jlc on 2017/4/21.
//  Copyright © 2017年 NYHZ. All rights reserved.
//

#import "loadWebView.h"
#import <WebKit/WebKit.h>

@interface loadWebView ()<WKNavigationDelegate,UIWebViewDelegate,WKScriptMessageHandler>
@property (nonatomic, assign) NSUInteger loadCount;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, copy) NSString *ID;
//@property (nonatomic, strong) activeCenterDataModel *model;
@property (nonatomic, strong) loadWebView *webContro;


@end

@implementation loadWebView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.preferences = [[WKPreferences alloc] init];
    
    config.preferences.minimumFontSize = 10;
    
    config.preferences.javaScriptEnabled = YES;
    
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    
//    WKUserContentController
    
    [[_webView configuration].userContentController addScriptMessageHandler:self name:@"xxx"];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configUI];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self tabbarHidden];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self tabbarShow];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"js 调用了 %@ 方法 传回参数 %@",message.name,message.body);
}


+ (void)showWithContro:(UIViewController *)contro withUrl:(NSString *)urlStr WithTitle:(NSString *)title{
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    loadWebView *webContro = [loadWebView new];
//    if (activeModel) {
//        webContro.actModel = activeModel;
//        [loginHandel saveInfoHandel].BGT = [activeModel.BEGINDATE stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
//        [loginHandel saveInfoHandel].EDT = [activeModel.ENDDATE stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
//    }
//    if (model) {
//        webContro.volModel = model;
//        [loginHandel saveInfoHandel].BGT = [model.BEGINDATE stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
//        [loginHandel saveInfoHandel].EDT = [model.ENDDATE stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
//    }
    
//    webContro.ID = activeId;
    webContro.Url = [NSURL URLWithString:urlStr];
    webContro.title = title;
    if ([title isEqualToString:@"便民服务"]) {
        UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        [rightBtn setTitle:@"我要办事" forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        webContro.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        [rightBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    }
    [contro.navigationController pushViewController:webContro animated:YES];
}

- (void)rightClick {
//    guidanceVC *guidance = [[guidanceVC alloc] init];
//    [self.navigationController pushViewController:guidance animated:YES];
}

- (void)configUI{
    //进度条
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, screenW, 0)];
    progressView.tintColor = [UIColor navbackgroundColor];
    progressView.trackTintColor = [UIColor whiteColor];
    [self.view addSubview:progressView];
    self.progressView = progressView;
    
    WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH+64)];
    wkWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    wkWebView.backgroundColor = [UIColor whiteColor];
    wkWebView.navigationDelegate = self;
    
    [self.view insertSubview:wkWebView belowSubview:progressView];
    
    [wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    [wkWebView loadHTMLString:_HTMLSTR baseURL:nil];
//    NSURLRequest *request = [NSURLRequest requestWithURL:_Url];
//    [wkWebView loadRequest:request];
    
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = [WKUserContentController new];
    configuration.preferences.javaScriptEnabled = YES;
    configuration.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    
    
    
    self.webView = wkWebView;
}

//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
//    if ([webView.URL.absoluteString hasPrefix:@"https://www.baidu.com"]) {
//        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
//        decisionHandler(WKNavigationActionPolicyCancel);
//    }else{
//        decisionHandler(WKNavigationActionPolicyAllow);
//    }
//}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newProgress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newProgress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else{
            self.progressView.hidden = NO;
            [self.progressView setProgress:newProgress animated:YES];
        }
    }
}

//取消监听
- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    
    NSURL *URL = navigationAction.request.URL;
    NSString *ADAPTER = [NSString stringWithFormat:@"%@",URL];
#warning 报名点击无效
    if ([ADAPTER containsString:@"NYHZ_NYSXYX_SJYW10002"]) {
        decisionHandler(WKNavigationActionPolicyCancel);
        [webView evaluateJavaScript:@"bm()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            NSLog(@"%@",result);
        }];
        return;
    }

    if ([ADAPTER containsString:@"NYHZ_NYSXYX_SJYW10006"]) {
//        decisionHandler(WKNavigationActionPolicyCancel);
//        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
//        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//        NSDate *date = [formatter dateFromString:[loginHandel saveInfoHandel].BGT];
//        NSDate *dateEnd = [formatter dateFromString:[loginHandel saveInfoHandel].EDT];
//        NSDate *dateNow = [NSDate date];
//        NSTimeInterval secs = [dateNow timeIntervalSinceDate:date];
//        NSTimeInterval secsEnd = [dateNow timeIntervalSinceDate:dateEnd];
//        if (secs < 0 ) {
//            [MBShow showAlertBoxWithText:@"活动尚未开始" onView:self.view];
//        } else if (secsEnd > 0 ) {
//            [MBShow showAlertBoxWithText:@"活动已经结束" onView:self.view];
//        } else {
//            NSString *URL = [NSString stringWithFormat:@"%@ADAPTER=NYHZ_NYSXYX_SJYW10006&ZUID=%@&SCOCOORDLAT=%@&SCOCOORDLONG=%@&MYCOORDLAT=%f&MYCOORDLONG=%f&PWDINDEX=%@&SIGNATURE=%@&BEGINDATE=%@&ENDDATE=%@",BASEURL,_ID,_actModel.COORDLAT,_actModel.COORDLONG,_latitude,_longitude,[loginHandel saveInfoHandel].PWDINDEX,[loginHandel saveInfoHandel].SIGNATURE,[loginHandel saveInfoHandel].BGT,[loginHandel saveInfoHandel].EDT];
//            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//            [manager POST:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//                publicModel *model = [publicModel mj_objectWithKeyValues:dic];
//                if ([model.STATE isEqualToString:@"00000"]) {
//                    [MBShow showAlertBoxWithText:@"签到成功" onView:self.view];
//                    [webView evaluateJavaScript:@"flushqd()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//                        NSLog(@"%@",result);
//                    }];
//                } else {
//                    [MBShow showAlertBoxWithText:model.MSG onView:self.view];
//                }
//                
//            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                
//            }];
//        }
        
        
        return;
    }
    if ([ADAPTER containsString:@"NYHZ_NYSWJZ_WZJK10030"]) {
//        decisionHandler(WKNavigationActionPolicyCancel);
//        
//        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
//        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//        NSDate *date = [formatter dateFromString:[loginHandel saveInfoHandel].BGT];
//        NSDate *dateEnd = [formatter dateFromString:[loginHandel saveInfoHandel].EDT];
//        NSDate *dateNow = [NSDate date];
//        NSTimeInterval secs = [dateNow timeIntervalSinceDate:date];
//        NSTimeInterval secsEnd = [dateNow timeIntervalSinceDate:dateEnd];
//        if (secs < 0) {
//            [MBShow showAlertBoxWithText:@"活动尚未开始" onView:self.view];
//        } else if (secsEnd > 0 ) {
//            [MBShow showAlertBoxWithText:@"活动已经结束" onView:self.view];
//        } else {
//            NSString *URL = [NSString stringWithFormat:@"%@ADAPTER=NYHZ_NYSWJZ_WZJK10030&ZUID=%@&SCOCOORDLAT=%@&SCOCOORDLONG=%@&MYCOORDLAT=%f&MYCOORDLONG=%f&PWDINDEX=%@&SIGNATURE=%@&BEGINDATE=%@&ENDDATE=%@",BASEURL,_ID,_volModel.COORDLAT,_volModel.COORDLONG,_latitude,_longitude,[loginHandel saveInfoHandel].PWDINDEX,[loginHandel saveInfoHandel].SIGNATURE,[loginHandel saveInfoHandel].BGT,[loginHandel saveInfoHandel].EDT];
//            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//            [manager POST:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//                publicModel *model = [publicModel mj_objectWithKeyValues:dic];
//                if ([model.STATE isEqualToString:@"00000"]) {
//                    [MBShow showAlertBoxWithText:@"签到成功" onView:self.view];
//                    [webView evaluateJavaScript:@"flushqd()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//                        NSLog(@"%@",result);
//                    }];
//                } else {
//                    [MBShow showAlertBoxWithText:model.MSG onView:self.view];
//                }
//            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                
//            }];
//        }
    }else{
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    
}

@end
