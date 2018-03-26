//
//  calculateController.m
//  CZToken
//
//  Created by jlc on 2018/3/14.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "calculateController.h"
#import "calculateModel.h"
@interface calculateController ()
@property (nonatomic, assign) int ring;
@property (nonatomic, assign) int tradeType;
@property (nonatomic, assign) int propertyRing;
@property (nonatomic, assign) int isOnly;
@property (nonatomic, assign) int isFirst;
@property (nonatomic, assign) int isLoan;
@property (nonatomic, assign) NSDecimalNumber *HousePrice;
@property (nonatomic, assign) int houseArea;
@property (nonatomic, assign) int PropertyRight;
@property (nonatomic, assign) int IsOnly;
@property (nonatomic, assign) NSDecimalNumber *BuyThePrice;

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
        if (index == 0) {
            _ershouView.hidden = YES;
            _ershouHeight.constant = 0;
            _tradeType = 1;
        } else {
            _ershouView.hidden = NO;
            _ershouHeight.constant = 145;
            _tradeType = 2;
        }
    }];
}

- (IBAction)jisuanAction:(UIButton *)sender {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:TOKEN forKey:@"Token"];
    [params setObject:@"ios" forKey:@"Source"];
    [params setObject:@(1) forKey:@"HouseType2"];
    [params setObject:@(_ring) forKey:@"Ring"];
    [params setObject:@(_tradeType) forKey:@"TradeType"];
    [params setObject:@(_isFirst) forKey:@"IsFirst"];
    [params setObject:@(_isLoan) forKey:@"IsLoan"];
    [params setObject:@([_fwmjTf.text doubleValue]) forKey:@"HouseSize"];
    [params setObject:@([_fwzjTf.text doubleValue]) forKey:@"HouseTotalPrice"];
    [params setObject:[NSDecimalNumber decimalNumberWithString:_mjdjTf.text] forKey:@"HousePrice"];
    if (_tradeType == 2) {
        [params setObject:@(_propertyRing) forKey:@"PropertyRight"];
        [params setObject:@(_isOnly) forKey:@"IsOnly"];
        [params setObject:[NSDecimalNumber decimalNumberWithString:_ssjgTf.text] forKey:@"BuyThePrice"];
    }
    NSString *URL = [NSString stringWithFormat:@"%@/Trade/Taxation/CalHouseTaxation",BaseUrl];
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        calculateDataModel *model = [calculateDataModel mj_objectWithKeyValues:[dic objectForKey:@"Data"]];
        NSLog(@"%@",model);
        if ([dic intValueForKey:@"Code"] == 0) {
            [self setResultInfo:model];
        }
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

- (void)setResultInfo:(calculateDataModel *)model {
    _maiqs.text = model.BuyDeedTax;//买房契税
    _maiths.text = model.BuyStampDuty;//买方印花税
    _maijysxf.text = model.BuyTransactionFee;//买方交易手续费
    _maidjs.text = model.BuyRegisterFee;//买方抵押登记费
    _maiptf.text = model.SellSurveyingFee;// 买方配图费
//    _maiczyhs.text = model.;//买方产证印花税
    _maidydjf.text = model.BuyMortgageFee;//买方抵押登记费
    _maiallmoney.text = model.BuyTotalTax;//买方税金总额
    
    _selljysxf.text = model.SellTransactionFee;// 卖方交易手续费
    _sellhtyhs.text = model.SellStampDuty;// 卖方合同印花税
    _sellzzsfj.text = model.SellAddAdditionalTax;// 卖方增值附加税
//    _sellfcs.text = model.;// 卖方房产税
    _selltdzzs.text = model.SellAddTax;// 卖方土地增值税
    _sellgrsds.text = model.SellPersonalTax;// 卖方个人所得税
    _sellallMoney.text = model.SellTotalTax;// 卖方税金总额
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
