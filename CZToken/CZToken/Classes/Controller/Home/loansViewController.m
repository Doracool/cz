//
//  loansViewController.m
//  CZToken
//
//  Created by jlc on 2018/2/27.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "loansViewController.h"
#import "daikuan.h"
#import "zige.h"

#import "yuegongCellOne.h"
@interface loansViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UIButton *jsBtn;
    UILabel *jsjg;
    UILabel *kded;
    UILabel *bz;
    daikuan *shangdai;
    zige *zigeView;
}
@property (nonatomic, strong) UIScrollView *baseScroll;
@property (nonatomic, strong) UIView *firstView;
@property (nonatomic, strong) UIView *secondView;
@property (nonatomic, strong) UILabel *text1;
@property (nonatomic, strong) UILabel *text2;
@property (nonatomic, strong) UILabel *text3;
@property (nonatomic, strong) UILabel *text4;
@property (nonatomic, strong) UITextField *textField1;
@property (nonatomic, strong) UITextField *textField2;
@property (nonatomic, strong) UITextField *textField3;
@property (nonatomic, strong) UIButton *yesBtn;
@property (nonatomic, strong) UIButton *noBtn;
@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, assign) int IsFirst;
@property (nonatomic, assign) int HouseType;
@property (nonatomic, assign) double ContractPrice;
@property (nonatomic, assign) int yesOrNo;

@end

@implementation loansViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *array = @[@"资格",@"额度",@"月供"];
    ZFJSegmentedControl *zvc = [[ZFJSegmentedControl alloc] initwithTitleArr:array iconArr:nil SCType:SCType_Underline];
    [self.view addSubview:zvc];
    zvc.frame = CGRectMake(0, 64, screenW, 40);
    zvc.backgroundColor = [UIColor lineColor];
    zvc.SCType_Underline_HEI = 2;
    zvc.selectTitleColor = [UIColor blackColor];
    zvc. selectType = ^(NSInteger selectIndex, NSString *selectIndexTitle){
        if (selectIndex == 0) {
            [_baseScroll setContentOffset:CGPointMake(0, 0) animated:NO];
        } else if (selectIndex == 1) {
            [_baseScroll setContentOffset:CGPointMake(screenW, 0) animated:NO];
        } else if (selectIndex == 2) {
            [_baseScroll setContentOffset:CGPointMake(screenW*2, 0) animated:NO];
        }
        
    };
    
    _baseScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 104, screenW, screenH-104)];
    [self.view addSubview:_baseScroll];
    _baseScroll.contentSize = CGSizeMake(screenW*3, 0);
    _baseScroll.pagingEnabled = YES;
    _baseScroll.showsHorizontalScrollIndicator = NO;
    _firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH)];
    [_baseScroll addSubview:_firstView];
    zigeView = [[NSBundle mainBundle] loadNibNamed:@"zige" owner:self options:nil][0];
    zigeView.frame = CGRectMake(0, 0, screenW, screenH-104);
    [_firstView addSubview:zigeView];
    _firstView.backgroundColor = [UIColor redColor];
    
    _secondView = [[UIView alloc] initWithFrame:CGRectMake(screenW, 0, screenW, screenH-104)];
    [_baseScroll addSubview:_secondView];
    
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(screenW*2, 0, screenW, screenH-104) style:UITableViewStylePlain];
    [_baseScroll addSubview:_myTableView];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    
//    _secondView.backgroundColor = [UIColor yellowColor];
    [self createSecond];
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    yuegongCellOne *yuegong = [[NSBundle mainBundle] loadNibNamed:@"yuegongCellOne" owner:self options:nil][0];
    tableView.rowHeight = 400;
    DVSwitch *typeOne = [[DVSwitch alloc] initWithStringsArray:@[@"商业",@"公积金",@"组合"]];
    typeOne.frame = yuegong.dklbView.frame;
    [yuegong.dklbView addSubview:typeOne];
    typeOne.frame = CGRectMake(0, 0, yuegong.dklbView.width-20, yuegong.dklbView.height);
    [typeOne setPressedHandler:^(NSUInteger index) {
        NSLog(@"switch to index: %lu",(unsigned long)index);
        if (index != 2) {
            yuegong.zuheViewOne.hidden = YES;
            yuegong.zuheViewTwo.hidden = YES;
            yuegong.oneHeight.constant = 0;
            yuegong.viewoneTop.constant = 0;
            yuegong.viewtwoTop.constant = 0;
            tableView.rowHeight = 400;
        } else {
            yuegong.zuheViewOne.hidden = NO;
            yuegong.zuheViewTwo.hidden = NO;
            yuegong.oneHeight.constant = 40;
            yuegong.viewoneTop.constant = 20;
            yuegong.viewtwoTop.constant = 20;
            tableView.rowHeight = 550;
        }
    }];
    
    DVSwitch *typeTwo = [[DVSwitch alloc] initWithStringsArray:@[@"等额本息",@"等额本金"]];
    [yuegong.hkfsView addSubview:typeTwo];
    typeTwo.frame = CGRectMake(0, 0, yuegong.hkfsView.width-20, yuegong.hkfsView.height);
    [typeTwo setPressedHandler:^(NSUInteger index) {
        NSLog(@"switch is %lu",(unsigned long)index);
    }];
    return yuegong;
}

- (void)createSecond {
    NSArray *segment = @[@"公积金",@"商贷"];
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:segment];
    segmentControl.frame = CGRectMake(screenW/2 - 80, 50, 160, 30);
    segmentControl.layer.cornerRadius = 15;
    segmentControl.layer.masksToBounds = YES;
    segmentControl.tintColor = [UIColor redColor];
    segmentControl.layer.borderColor = [UIColor redColor].CGColor;
    segmentControl.layer.borderWidth = 1.0f;
    segmentControl.selectedSegmentIndex = 0;
    [_secondView addSubview:segmentControl];
    
    [segmentControl addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0]};
    CGSize size = [@"月缴额" boundingRectWithSize:CGSizeMake(screenW, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    shangdai = [[NSBundle mainBundle] loadNibNamed:@"daikuan" owner:self options:nil][0];
    shangdai.frame = CGRectMake(0, 90, screenW, 500);
    [_secondView addSubview:shangdai];
    shangdai.hidden = YES;
    [shangdai.sbtn addTarget:self action:@selector(stfClick:) forControlEvents:UIControlEventTouchUpInside];
    [shangdai.fbtn addTarget:self action:@selector(stfClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [shangdai.ptBtn addTarget:self action:@selector(fwlxClick:) forControlEvents:UIControlEventTouchUpInside];
    [shangdai.fptBtn addTarget:self action:@selector(fwlxClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [shangdai.htjTF addTarget:self action:@selector(htjTextChange:) forControlEvents:UIControlEventEditingChanged];
    
    [shangdai.ActionBtn addTarget:self action:@selector(sdJsAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _text1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, size.width, 30)];
    _text1.text = @"月缴额";
    _text1.font = [UIFont systemFontOfSize:14.0f];
    [_secondView addSubview:_text1];
    
    _textField1 = [[UITextField alloc] initWithFrame:CGRectMake(size.width + 40 , 100, screenW - 60 - size.width, 30)];
    _textField1.placeholder = @"shufu";
    _textField1.borderStyle = UITextBorderStyleRoundedRect;
    [_secondView addSubview:_textField1];
    
    
    
    _text2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, size.width, 30)];
    _text2.text = @"余额";
    _text2.font = [UIFont systemFontOfSize:14.0f];
    [_secondView addSubview:_text2];
    
    _textField2 = [[UITextField alloc] initWithFrame:CGRectMake(size.width + 40, 150, screenW - 60 - size.width, 30)];
    _textField2.placeholder = @"shufwx";
    _textField2.borderStyle = UITextBorderStyleRoundedRect;
    [_secondView addSubview:_textField2];
    
    _text3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, size.width*2, 30)];
    _text3.text = @"可贷期限";
    _text3.font = [UIFont systemFontOfSize:14.0f];
    [_secondView addSubview:_text3];
    
    _textField3 = [[UITextField alloc] initWithFrame:CGRectMake(size.width + 40, 200, screenW - 60 - size.width, 30)];
    _textField3.placeholder = @"";
    _textField3.borderStyle = UITextBorderStyleRoundedRect;
    [_secondView addSubview:_textField3];
    
    _text4 = [[UILabel alloc] initWithFrame:CGRectMake(20, 250, size.width*3, 30)];
    _text4.text = @"是否有补充公积金";
    _text4.font = [UIFont systemFontOfSize:14.0f];
    [_secondView addSubview:_text4];
    
    _yesBtn = [[UIButton alloc] initWithFrame:CGRectMake(size.width*3 + 50, 250, 40, 40)];
    [_secondView addSubview:_yesBtn];
    [_yesBtn setTitle:@" 是" forState:UIControlStateNormal];
    [_yesBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    _yesBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [_yesBtn setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
    [_yesBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
    _yesBtn.tag = 1;
    
    _noBtn = [[UIButton alloc] initWithFrame:CGRectMake(size.width*3 + 100, 250, 40, 40)];
    [_secondView addSubview:_noBtn];
    [_noBtn setTitle:@" 否" forState:UIControlStateNormal];
    [_noBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    _noBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [_noBtn setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
    [_noBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
    [_yesBtn addTarget:self action:@selector(chooseClick:) forControlEvents:UIControlEventTouchUpInside];
    [_noBtn addTarget:self action:@selector(chooseClick:) forControlEvents:UIControlEventTouchUpInside];
    _noBtn.tag = 2;
    
    jsBtn = [[UIButton alloc] init];
    [_secondView addSubview:jsBtn];
    [jsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(20);
        make.top.equalTo(_text4.mas_bottom).offset(20);
        make.trailing.offset(-20);
        make.height.offset(40);
    }];
    jsBtn.backgroundColor = [UIColor navbackgroundColor];
    [jsBtn addTarget:self action:@selector(jsAction:) forControlEvents:UIControlEventTouchUpInside];
    
    jsjg = [[UILabel alloc] init];
    [_secondView addSubview:jsjg];
    [jsjg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(100);
        make.top.equalTo(jsBtn.mas_bottom).offset(20);
        make.trailing.offset(-100);
        make.height.offset(30);
    }];
    jsjg.textAlignment = NSTextAlignmentCenter;
    jsjg.text = @"测算结果";
    
    
    kded = [[UILabel alloc] init];
    [_secondView addSubview:kded];
    [kded mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(20);
        make.trailing.offset(-20);
        make.top.equalTo(jsjg.mas_bottom).offset(20);
        make.height.offset(30);
    }];
    kded.textAlignment = NSTextAlignmentCenter;
    kded.textColor = [UIColor redColor];
    kded.text = @"预测结果： 0元";
    
    bz = [[UILabel alloc] init];
    [_secondView addSubview:bz];
    [bz mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(100);
        make.trailing.offset(-100);
        make.top.equalTo(kded.mas_bottom).offset(20);
        make.height.offset(70);
    }];
    bz.textAlignment = NSTextAlignmentCenter;
    bz.numberOfLines = 0;
    bz.text = @"以上结果来自第三方置业担保机构\n结果仅供参考可贷额度以实际为准";
    bz.font = [UIFont systemFontOfSize:11.0f];
}

- (void)stfClick:(UIButton *)sender {
    shangdai.sbtn.selected = NO;
    shangdai.fbtn.selected = NO;
    sender.selected = YES;
    if (sender.tag == 1) {
        _IsFirst = 1;
    } else {
        _IsFirst = 0;
    }
}

- (void)fwlxClick:(UIButton *)sender {
    shangdai.ptBtn.selected = NO;
    shangdai.fptBtn.selected = NO;
    sender.selected = YES;
    if (sender.tag == 1) {
        _HouseType = 1;
    } else {
        _HouseType = 0;
    }
}

- (void)htjTextChange:(UITextField *)sender {
    _ContractPrice = [sender.text doubleValue];
}

- (void)change:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 1) {
        _text1.hidden = YES;
        _text2.hidden = YES;
        _text3.hidden = YES;
        _text4.hidden = YES;
        _textField1.hidden = YES;
        _textField2.hidden = YES;
        _textField3.hidden = YES;
        _yesBtn.hidden = YES;
        _noBtn.hidden = YES;
        jsBtn.hidden = YES;
        jsjg.hidden = YES;
        kded.hidden = YES;
        bz.hidden = YES;
        shangdai.hidden = NO;
    } else {
        _text1.hidden = NO;
        _text2.hidden = NO;
        _text3.hidden = NO;
        _text4.hidden = NO;
        _textField1.hidden = NO;
        _textField2.hidden = NO;
        _textField3.hidden = NO;
        _yesBtn.hidden = NO;
        _noBtn.hidden = NO;
        jsBtn.hidden = NO;
        jsjg.hidden = NO;
        kded.hidden = NO;
        bz.hidden = NO;
        shangdai.hidden = YES;
    }
}

- (void)chooseClick:(UIButton *)sender {
    _yesBtn.selected = NO;
    _noBtn.selected = NO;
    sender.selected = YES;
    if (sender.tag == 1) {
        _yesOrNo = 1;
    } else {
        _yesOrNo = 2;
    }
    
}

- (void)jsAction:(UIButton *)sender {
    NSDictionary *params = @{@"LoansType":@(1),@"MonthlyPayment":@([_textField1.text doubleValue]),@"Balance":@([_textField2.text doubleValue]),@"LoanTerm":@([_textField3.text intValue]),@"IsSupplement":@(_yesOrNo)};
    NSString *URL = [NSString stringWithFormat:@"%@/Trade/LoansLimit/CalLoansLimit",BaseUrl];
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        if ([dic intValueForKey:@"Code"] == 0) {
            kded.text = [NSString stringWithFormat:@"预测结果： %@元",[dic objectForKey:@"Data"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)sdJsAction:(UIButton *)sender {
    NSDictionary *params = @{@"LoansType":@(2),@"IsFirst":@(_IsFirst),@"HouseType":@(_HouseType),@"ContractPrice":@(_ContractPrice)};
    NSString *URL = [NSString stringWithFormat:@"%@/Trade/LoansLimit/CalLoansLimit",BaseUrl];
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        if ([dic intValueForKey:@"Code"] == 0) {
            shangdai.edu.text = [NSString stringWithFormat:@"预测结果： %@元",[dic objectForKey:@"Data"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
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
