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
#import "centerTextCell.h"
#import "XgContentTableViewCell.h"
#import "yuegongView.h"
#import "loansDetailsController.h"

@interface loansViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UIButton *jsBtn;
    UILabel *jsjg;
    UILabel *kded;
    UILabel *bz;
    daikuan *shangdai;
    zige *zigeView;
//    yuegongCellOne *yuegong;
    NSDictionary *ygDic;
    yuegongView *yuegong;
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

@property (nonatomic, assign) int dklx;
@property (nonatomic, assign) int dklb;
@property (nonatomic, assign) int hkfs;

@property (nonatomic, assign) double dkjeNum;
@property (nonatomic, assign) int dkqxNum;
@property (nonatomic, assign) double dklvNum;
@property (nonatomic, assign) double dkbsNum;
@property (nonatomic, assign) double lvNum;
@property (nonatomic, assign) double slvNum;


@property (nonatomic, assign) double sdjeNum;
@property (nonatomic, assign) double sdlvNum;
@property (nonatomic, assign) double sdbsNum;



@end

@implementation loansViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *array = @[@"资格",@"额度",@"月供"];
    _dklb = 2;
    _hkfs = 1;
    ygDic = [NSDictionary dictionary];
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
    
    
    
//    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(screenW*2, 0, screenW, screenH-104) style:UITableViewStylePlain];
//    [_baseScroll addSubview:_myTableView];
//    _myTableView.delegate = self;
//    _myTableView.dataSource = self;
    
    [self createSecond];
    [self createThird];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self tabbarHidden];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self tabbarShow];
}

/*
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    yuegong = [[NSBundle mainBundle] loadNibNamed:@"yuegongCellOne" owner:self options:nil][0];
    XgContentTableViewCell *textCell = [[NSBundle mainBundle] loadNibNamed:@"XgContentTableViewCell" owner:self options:nil][0];
    centerTextCell *titleCell = [[NSBundle mainBundle] loadNibNamed:@"centerTextCell" owner:self options:nil][0];
    if (indexPath.row > 0) {
        if (ygDic != nil) {
            if (indexPath.row == 1) {
                titleCell.title.text = @"月供结息";
                tableView.rowHeight = 50;
                return titleCell;
            } else if (indexPath.row == 2) {
                textCell.titleLabel.text = @"还款总额";
                textCell.answer.text = @"";
                tableView.rowHeight = 50;
                return textCell;
            } else if (indexPath.row == 3) {
                textCell.titleLabel.text = @"贷款月数";
                textCell.answer.text = @"";
                tableView.rowHeight = 50;
                return textCell;
            } else if (indexPath.row == 4) {
                textCell.titleLabel.text = @"支付利息";
                textCell.answer.text = @"";
                tableView.rowHeight = 50;
                return textCell;
            } else if (indexPath.row == 5) {
                textCell.titleLabel.text = @"每月还款";
                textCell.answer.text = @"";
                tableView.rowHeight = 50;
                return textCell;
            } else if (indexPath.row == 6) {
                titleCell.title.text = @"以上结果仅供参考";
                tableView.rowHeight = 50;
                return titleCell;
            }
        } else {
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            tableView.rowHeight = 5;
            return cell;
        }
    }

    if (indexPath.row == 0) {
        tableView.rowHeight = 450;
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
                yuegong.dkjeLabel.text = @"贷款金额";
                yuegong.dklvLabel.text = @"贷款利率";
                if (index == 0) {
                    _dklb = 2;
                } else {
                    _dklb = 1;
                }
            } else {
                _dklb = 3;
                yuegong.zuheViewOne.hidden = NO;
                yuegong.zuheViewTwo.hidden = NO;
                yuegong.oneHeight.constant = 40;
                yuegong.viewoneTop.constant = 20;
                yuegong.viewtwoTop.constant = 20;
                yuegong.dkjeLabel.text = @"公积金贷款金额";
                yuegong.dklvLabel.text = @"公积金贷款利率";
                tableView.rowHeight =450;
            }
        }];
        
        [yuegong.dkjeTF addTarget:self action:@selector(yuegongTFChange:) forControlEvents:UIControlEventEditingChanged];
        [yuegong.dkqxTF addTarget:self action:@selector(yuegongTFChange:) forControlEvents:UIControlEventEditingChanged];
        [yuegong.lvTfOne addTarget:self action:@selector(yuegongTFChange:) forControlEvents:UIControlEventEditingChanged];
        [yuegong.LvYearTF addTarget:self action:@selector(yuegongTFChange:) forControlEvents:UIControlEventEditingChanged];
        
        [yuegong.onegjjtf addTarget:self action:@selector(yuegongTFChange:) forControlEvents:UIControlEventEditingChanged];
        [yuegong.sylvTF addTarget:self action:@selector(yuegongTFChange:) forControlEvents:UIControlEventEditingChanged];
        [yuegong.sylvBeishu addTarget:self action:@selector(yuegongTFChange:) forControlEvents:UIControlEventEditingChanged];
        
        DVSwitch *typeTwo = [[DVSwitch alloc] initWithStringsArray:@[@"等额本息",@"等额本金"]];
        [yuegong.hkfsView addSubview:typeTwo];
        typeTwo.frame = CGRectMake(0, 0, yuegong.hkfsView.width-20, yuegong.hkfsView.height);
        [typeTwo setPressedHandler:^(NSUInteger index) {
            NSLog(@"switch is %lu",(unsigned long)index);
            if (index == 0) {
                _hkfs = 1;
            } else {
                _hkfs = 2;
            }
        }];
        [yuegong.jsBtn addTarget:self action:@selector(ygJsAction:) forControlEvents:UIControlEventTouchUpInside];
        return yuegong;
    }
    
    
    return nil;
}
*/
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


- (void)createThird {
    yuegong = [[NSBundle mainBundle] loadNibNamed:@"yuegongView" owner:self options:nil][0];
    yuegong.frame = CGRectMake(screenW*2, 0, screenW, screenH-64);
    [_baseScroll addSubview:yuegong];
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
            yuegong.dkjeLabel.text = @"贷款金额";
            yuegong.dklvLabel.text = @"贷款利率";
            if (index == 0) {
                _dklb = 2;
            } else {
                _dklb = 1;
            }
        } else {
            _dklb = 3;
            yuegong.zuheViewOne.hidden = NO;
            yuegong.zuheViewTwo.hidden = NO;
            yuegong.oneHeight.constant = 40;
            yuegong.viewoneTop.constant = 20;
            yuegong.viewtwoTop.constant = 20;
            yuegong.dkjeLabel.text = @"公积金贷款金额";
            yuegong.dklvLabel.text = @"公积金贷款利率";
        }
    }];
    
    [yuegong.dkjeTF addTarget:self action:@selector(yuegongTFChange:) forControlEvents:UIControlEventEditingChanged];
    [yuegong.dkqxTF addTarget:self action:@selector(yuegongTFChange:) forControlEvents:UIControlEventEditingChanged];
    [yuegong.lvTfOne addTarget:self action:@selector(yuegongTFChange:) forControlEvents:UIControlEventEditingChanged];
    [yuegong.LvYearTF addTarget:self action:@selector(yuegongTFChange:) forControlEvents:UIControlEventEditingChanged];
    
    [yuegong.onegjjtf addTarget:self action:@selector(yuegongTFChange:) forControlEvents:UIControlEventEditingChanged];
    [yuegong.sylvTF addTarget:self action:@selector(yuegongTFChange:) forControlEvents:UIControlEventEditingChanged];
    [yuegong.sylvBeishu addTarget:self action:@selector(yuegongTFChange:) forControlEvents:UIControlEventEditingChanged];
    
    DVSwitch *typeTwo = [[DVSwitch alloc] initWithStringsArray:@[@"等额本息",@"等额本金"]];
    [yuegong.hkfsView addSubview:typeTwo];
    typeTwo.frame = CGRectMake(0, 0, yuegong.hkfsView.width-20, yuegong.hkfsView.height);
    [typeTwo setPressedHandler:^(NSUInteger index) {
        NSLog(@"switch is %lu",(unsigned long)index);
        if (index == 0) {
            _hkfs = 1;
        } else {
            _hkfs = 2;
        }
    }];
    [yuegong.jsBtn addTarget:self action:@selector(ygJsAction:) forControlEvents:UIControlEventTouchUpInside];
    
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

//

- (void)yuegongTFChange:(UITextField *)sender {
    if (sender.tag == 10) {
        _dkjeNum = [sender.text doubleValue];
    } else if (sender.tag == 11) {
        _dkqxNum = [sender.text intValue];
    } else if (sender.tag == 12) {
        _dklvNum = [sender.text doubleValue];
        yuegong.lvResult.text = [NSString stringWithFormat:@"= %.2f%%",_dklvNum*_dkbsNum];
        _lvNum = _dklvNum*_dkbsNum;
    } else if (sender.tag == 13) {
        _dkbsNum = [sender.text doubleValue];
        yuegong.lvResult.text = [NSString stringWithFormat:@"= %.2f%%",_dklvNum*_dkbsNum];
        _lvNum = _dklvNum*_dkbsNum;
    } else if (sender.tag == 14) {
        _sdjeNum = [sender.text doubleValue];
    } else if (sender.tag == 15) {
        _sdlvNum = [sender.text doubleValue];
        yuegong.sdlvResult.text = [NSString stringWithFormat:@"= %.2f%%",_sdlvNum*_sdbsNum];
        _slvNum = _sdlvNum*_sdbsNum;
    } else if (sender.tag == 16) {
        _sdbsNum = [sender.text doubleValue];
        yuegong.sdlvResult.text = [NSString stringWithFormat:@"= %.2f%%",_sdlvNum*_sdbsNum];
        _slvNum = _sdlvNum*_sdbsNum;
    }
}

- (void)ygJsAction:(UIButton *)sender {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(_dklb) forKey:@"LoansType"];
    [params setObject:@(_hkfs) forKey:@"RepayType"];
    if (_dklb != 3) {
        [params setObject:@(_dkjeNum) forKey:@"LoansAmount"];
        [params setObject:@(_lvNum) forKey:@"RateMultiple"];
    }
    [params setObject:@(_dkqxNum) forKey:@"LoansYear"];
    if (_dklb == 2) {
        [params setObject:@(_dklvNum) forKey:@"BankLoansRate"];
    } else if (_dklb == 1) {
        [params setObject:@(_dklvNum) forKey:@"FunLoansRate"];
    }
    
    
    if (_dklb == 3) {
        [params setObject:@(_dkjeNum) forKey:@"FundAmount"];
        [params setObject:@(_sdjeNum) forKey:@"BusinessAmount"];
        [params setObject:@(_lvNum) forKey:@"FunLoansRate"];
        [params setObject:@(_slvNum) forKey:@"BankLoansRate"];
    }
    
    NSString *URL = [NSString stringWithFormat:@"%@/Trade/LoansMonthly/CalLoansMonthly",BaseUrl];
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        ygDic = dic;
        if ([dic intValueForKey:@"Code"] == 0) {
            yuegong.bottomView.hidden = NO;
            NSString *hkzeStr = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"Data"] objectForKey:@"TotalRepay"]];
            yuegong.hkze.attributedText = [commonSet AttributeNameFont:16.0 Color:[UIColor navbackgroundColor] Space:0 qingxie:0 text:hkzeStr Range:NSMakeRange(0, hkzeStr.length)];
            yuegong.hkze.text = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"Data"] objectForKey:@"TotalRepay"]];
            yuegong.dkys.text = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"Data"] objectForKey:@"Number"]];
            yuegong.zflx.text = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"Data"] objectForKey:@"TotalInterest"]];
            yuegong.myhk.text = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"Data"] objectForKey:@"RepayMonthly"]];
            [yuegong.moreBtn addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)moreAction:(UIButton *)sender {
    loansDetailsController *details = [[loansDetailsController alloc] init];
    details.monthId = [NSString stringWithFormat:@"%@",[[ygDic objectForKey:@"Data"] objectForKey:@"Id"]];
    [self.navigationController pushViewController:details animated:YES];
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
