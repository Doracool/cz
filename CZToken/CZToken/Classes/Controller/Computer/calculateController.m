//
//  calculateController.m
//  CZToken
//
//  Created by jlc on 2018/3/14.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "calculateController.h"

@interface calculateController ()
@property (nonatomic, assign) int ring;
@property (nonatomic, assign) int tradeType;
@property (nonatomic, assign) int propertyRing;
@property (nonatomic, assign) int isOnly;
@property (nonatomic, assign) int isFirst;
@property (nonatomic, assign) int isLoan;
@property (nonatomic, assign) int HousePrice;
@property (nonatomic, assign) int houseArea;
@end

@implementation calculateController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBaseUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)createBaseUI {
    DVSwitch *typeOne = [[DVSwitch alloc] initWithStringsArray:@[@"一手",@"二手"]];
    typeOne.frame = _jylxView.frame;
    [_jylxView addSubview:typeOne];
    typeOne.frame = CGRectMake(0, 0, _jylxView.width, _jylxView.height);
    [typeOne setPressedHandler:^(NSUInteger index) {
        NSLog(@"switch to index: %lu",(unsigned long)index);
    }];
}

- (IBAction)jisuanAction:(UIButton *)sender {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:TOKEN forKey:@"Token"];
    [params setObject:@"ios" forKey:@"Source"];
    [params setObject:@(1) forKey:@"HouseType2"];
    [params setObject:@(_ring) forKey:@"Ring"];
    [params setObject:@(1) forKey:@"TradeType"];
    [params setObject:@(_isFirst) forKey:@"IsFirst"];
    [params setObject:@(_isLoan) forKey:@"IsLoan"];
    [params setObject:@([_fwmjTf.text doubleValue]) forKey:@"HouseSize"];
    [params setObject:@([_fwzjTf.text doubleValue]) forKey:@"HouseTotalPrice"];
    [params setObject:@([_mjdjTf.text doubleValue]) forKey:@"HousePrice"];
    NSString *URL = [NSString stringWithFormat:@"%@/Trade/Taxation/CalHouseTaxation",BaseUrl];
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (IBAction)selectHuan:(UIButton *)sender {
    _neihuan.selected = NO;
    _neiorwai.selected = NO;
    _waihuan.selected = NO;
    sender.selected = YES;
    _ring = (int)sender.tag;
}
- (IBAction)selectChanquan:(UIButton *)sender {
    _bmln.selected = NO;
    _ezwn.selected = NO;
    _wnys.selected = NO;
    sender.selected = YES;
    _propertyRing = (int)sender.tag;
}
- (IBAction)selectWeiyi:(UIButton *)sender {
    _wy.selected = NO;
    _bwy.selected = NO;
    sender.selected = YES;
    _isOnly = (int)sender.tag;
}
- (IBAction)selectShoutao:(UIButton *)sender {
    _st.selected = NO;
    _bsst.selected = NO;
    sender.selected = YES;
    _isFirst = (int)sender.tag;
}
- (IBAction)selectDaikuan:(UIButton *)sender {
    _dk.selected = NO;
    _bdk.selected = NO;
    sender.selected = YES;
    _isLoan = (int)sender.tag;
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
