//
//  XgViewController.m
//  CZToken
//
//  Created by jlc on 2018/2/26.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "XgViewController.h"
#import "XgShareViewController.h"
#import "xgChooseCell.h"
#import "xgResultCell.h"
#import "houseSignCell.h"
#import "textCell.h"

@interface XgViewController ()<TTTagsDelegate>

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@property (strong, nonatomic) IBOutlet TTChooseBtnView *tipsView;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong ,nonatomic) NSArray *tips;
@property (nonatomic, assign) int hujiType;
@property (nonatomic, assign) int IsMarriage;
@property (nonatomic, assign) int IsBothAll;
@property (nonatomic, assign) int IsTallage;
@property (nonatomic, assign) int IsPact;
@property (nonatomic, assign) int fangchan;
@property (nonatomic, assign) int fangchanNum;
@property (nonatomic, assign) int MyHouseQty;
@end

@implementation XgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tabbarHidden];
    _tips = @[@"上海单身",@"外地人",@"驻沪军官",@"港澳同胞",@"台湾同胞",@"外籍人士"];
    _hujiType = 1;
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    [arr addObjectsFromArray:_tips];
    TTChooseBtnView *view = [[TTChooseBtnView alloc] initWithFrame:CGRectMake(12, 10, screenW-24, 50) andTags:_tips andTitleColor:[UIColor lineColor] andFonts:13];
    _IsMarriage = 1;
    _IsBothAll = 1;
    _IsTallage = 1;
    _IsPact = 1;
    _viewHeight.constant = view.frame.size.height + 10;
    view.delegate = self;
    [_tipsView addSubview:view];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self tabbarHidden];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self tabbarShow];
}

- (void)chooseTagsArr:(NSMutableArray *)chooseArr {
    _hujiType = [chooseArr[0] intValue] + 1;
    NSLog(@"%d",_hujiType);
    [_myTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_hujiType == 1) {
        return 6;
    } else if (_hujiType == 2) {
        return 6;
    } else if (_hujiType > 2) {
        return 5;
    } else {
        return 6;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    xgChooseCell *cell = [[NSBundle mainBundle] loadNibNamed:@"xgChooseCell" owner:self options:nil][0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    xgResultCell *resultCell = [[NSBundle mainBundle] loadNibNamed:@"xgResultCell" owner:self options:nil][0];
    resultCell.selectionStyle = UITableViewCellSelectionStyleNone;
    houseSignCell *clickCell = [[NSBundle mainBundle] loadNibNamed:@"houseSignCell" owner:self options:nil][0];
    clickCell.selectionStyle = UITableViewCellSelectionStyleNone;
    textCell *txtCell = [[NSBundle mainBundle] loadNibNamed:@"textCell" owner:self options:nil][0];
    txtCell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.rowHeight = 50;
    if (_hujiType == 1) {
        if (indexPath.row == 0) {
            cell.chooseTitel.text = @"婚姻状况";
            [cell.chooseLeft setTitle:@" 已婚" forState:UIControlStateNormal];
            [cell.chooseRight setTitle:@" 未婚" forState:UIControlStateNormal];
            [cell.chooseLeft addTarget:self action:@selector(chooseClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.chooseRight addTarget:self action:@selector(chooseClick:) forControlEvents:UIControlEventTouchUpInside];
            BOOL Sel = cell.chooseRight.tag == _IsMarriage ? YES : NO;
            cell.chooseRight.selected = Sel;
            cell.chooseLeft.selected = !Sel;
        } else if (indexPath.row == 1) {
            cell.chooseTitel.text = @"是否双方全部上海户籍";
            [cell.chooseLeft setTitle:@" 一方" forState:UIControlStateNormal];
            [cell.chooseRight setTitle:@" 双方" forState:UIControlStateNormal];
            [cell.chooseLeft addTarget:self action:@selector(shanghaihuji:) forControlEvents:UIControlEventTouchUpInside];
            [cell.chooseRight addTarget:self action:@selector(shanghaihuji:) forControlEvents:UIControlEventTouchUpInside];
            BOOL Sel = cell.chooseRight.tag == _IsBothAll ? YES : NO;
            cell.chooseRight.selected = Sel;
            cell.chooseLeft.selected = !Sel;
        } else if (indexPath.row == 2) {
            cell.chooseTitel.text = @"家庭在沪有无住宅";
            [cell.chooseLeft setTitle:@" 有" forState:UIControlStateNormal];
            [cell.chooseRight setTitle:@" 无" forState:UIControlStateNormal];
            [cell.chooseLeft addTarget:self action:@selector(fangchan:) forControlEvents:UIControlEventTouchUpInside];
            [cell.chooseRight addTarget:self action:@selector(fangchan:) forControlEvents:UIControlEventTouchUpInside];
            BOOL Sel = cell.chooseRight.tag == _fangchan/10 ? YES : NO;
            cell.chooseRight.selected = Sel;
            cell.chooseLeft.selected = !Sel;
        } else if (indexPath.row == 3) {
            txtCell.text.text = @"有几套房子";
            [txtCell.content addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
            if (_fangchan == 10) {
                txtCell.text.hidden = NO;
                txtCell.content.hidden = NO;
                txtCell.content.text = @"1";
            } else {
                txtCell.text.hidden = YES;
                txtCell.content.hidden = YES;
            }
            return txtCell;
        } else if (indexPath.row == 4) {
            [clickCell.signInBtn setTitle:@"开始计算" forState:UIControlStateNormal];
            [clickCell.signInBtn addTarget:self action:@selector(startJisuan:) forControlEvents:UIControlEventTouchUpInside];
            tableView.rowHeight = 100;
            return clickCell;
        } else if (indexPath.row == 5) {
            tableView.rowHeight = 120;
            if (_fangchan == 10) {
                resultCell.hidden = NO;
            } else {
                resultCell.hidden = YES;
            }
            return resultCell;
        }
    } else if (_hujiType == 2) {
        if (indexPath.row == 0) {
            cell.chooseTitel.text = @"婚姻状况";
            [cell.chooseLeft setTitle:@" 已婚" forState:UIControlStateNormal];
            [cell.chooseRight setTitle:@" 未婚" forState:UIControlStateNormal];
            [cell.chooseLeft addTarget:self action:@selector(chooseClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.chooseRight addTarget:self action:@selector(chooseClick:) forControlEvents:UIControlEventTouchUpInside];
            BOOL Sel = cell.chooseRight.tag == _IsMarriage ? YES : NO;
            cell.chooseRight.selected = Sel;
            cell.chooseLeft.selected = !Sel;
        } else if (indexPath.row == 1) {
            cell.chooseTitel.text = @"63个月内满60个月的社保或税单";
            [cell.chooseLeft setTitle:@" 已满" forState:UIControlStateNormal];
            [cell.chooseRight setTitle:@" 未满" forState:UIControlStateNormal];
            [cell.chooseLeft addTarget:self action:@selector(shebao:) forControlEvents:UIControlEventTouchUpInside];
            [cell.chooseRight addTarget:self action:@selector(shebao:) forControlEvents:UIControlEventTouchUpInside];
            BOOL Sel = cell.chooseRight.tag == _IsTallage ? YES : NO;
            cell.chooseRight.selected = Sel;
            cell.chooseLeft.selected = !Sel;
        } else if (indexPath.row == 2) {
            cell.chooseTitel.text = @"家庭在沪有无住宅";
            [cell.chooseLeft setTitle:@" 有" forState:UIControlStateNormal];
            [cell.chooseRight setTitle:@" 无" forState:UIControlStateNormal];
            [cell.chooseLeft addTarget:self action:@selector(fangchan:) forControlEvents:UIControlEventTouchUpInside];
            [cell.chooseRight addTarget:self action:@selector(fangchan:) forControlEvents:UIControlEventTouchUpInside];
            BOOL Sel = cell.chooseRight.tag == _fangchan/10 ? YES : NO;
            cell.chooseRight.selected = Sel;
            cell.chooseLeft.selected = !Sel;
        } else if (indexPath.row == 3) {
            txtCell.text.text = @"有几套房子";
            [txtCell.content addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
            if (_fangchan == 10) {
                txtCell.text.hidden = NO;
                txtCell.content.hidden = NO;
                txtCell.content.text = @"1";
            } else {
                txtCell.text.hidden = YES;
                txtCell.content.hidden = YES;
            }
            return txtCell;
        } else if (indexPath.row == 4) {
            [clickCell.signInBtn setTitle:@"开始计算" forState:UIControlStateNormal];
            [clickCell.signInBtn addTarget:self action:@selector(startJisuan:) forControlEvents:UIControlEventTouchUpInside];
            tableView.rowHeight = 100;
            return clickCell;
        } else if (indexPath.row == 5) {
            tableView.rowHeight = 120;
            if (_fangchan == 10) {
                resultCell.hidden = NO;
            } else {
                resultCell.hidden = YES;
            }
            return resultCell;
        }
    } else {
        if (indexPath.row == 0) {
            cell.chooseTitel.text = @"在沪劳动合同已满一年";
            [cell.chooseLeft setTitle:@" 已满" forState:UIControlStateNormal];
            [cell.chooseRight setTitle:@" 未满" forState:UIControlStateNormal];
            [cell.chooseLeft addTarget:self action:@selector(laodonghetong:) forControlEvents:UIControlEventTouchUpInside];
            [cell.chooseRight addTarget:self action:@selector(laodonghetong:) forControlEvents:UIControlEventTouchUpInside];
            BOOL Sel = cell.chooseRight.tag == _IsPact ? YES : NO;
            cell.chooseRight.selected = Sel;
            cell.chooseLeft.selected = !Sel;
        } else if (indexPath.row == 1) {
            cell.chooseTitel.text = @"家庭在沪有无住宅";
            [cell.chooseLeft setTitle:@" 有" forState:UIControlStateNormal];
            [cell.chooseRight setTitle:@" 无" forState:UIControlStateNormal];
            [cell.chooseLeft addTarget:self action:@selector(fangchan:) forControlEvents:UIControlEventTouchUpInside];
            [cell.chooseRight addTarget:self action:@selector(fangchan:) forControlEvents:UIControlEventTouchUpInside];
            BOOL Sel = cell.chooseRight.tag == _fangchan/10 ? YES : NO;
            cell.chooseRight.selected = Sel;
            cell.chooseLeft.selected = !Sel;
        } else if (indexPath.row == 2) {
            txtCell.text.text = @"有几套房子";
            [txtCell.content addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
            if (_fangchan == 10) {
                txtCell.text.hidden = NO;
                txtCell.content.hidden = NO;
                txtCell.content.text = @"1";
            } else {
                txtCell.text.hidden = YES;
                txtCell.content.hidden = YES;
            }
            return txtCell;
        } else if (indexPath.row == 3) {
            [clickCell.signInBtn setTitle:@"开始计算" forState:UIControlStateNormal];
            [clickCell.signInBtn addTarget:self action:@selector(startJisuan:) forControlEvents:UIControlEventTouchUpInside];
            tableView.rowHeight = 100;
            return clickCell;
        } else if (indexPath.row == 4) {
            tableView.rowHeight = 120;
            if (_fangchan == 10) {
                resultCell.hidden = NO;
            } else {
                resultCell.hidden = YES;
            }
            return resultCell;
        }
    }
    return cell;
}

- (void)chooseClick:(UIButton *)sender {
    NSArray *subs = [sender.superview subviews];
    ((UIButton *) subs[2]).selected = NO;
    ((UIButton *) subs[3]).selected = NO;
    sender.selected = YES;
    _IsMarriage = sender.tag == 1 ? 1 : 0;
}

- (void)shanghaihuji:(UIButton *)sender {
    NSArray *subs = [sender.superview subviews];
    ((UIButton *) subs[2]).selected = NO;
    ((UIButton *) subs[3]).selected = NO;
    sender.selected = YES;
    _IsBothAll = sender.tag == 1 ? 1 : 0;
}

- (void)shebao:(UIButton *)sender {
    NSArray *subs = [sender.superview subviews];
    ((UIButton *) subs[2]).selected = NO;
    ((UIButton *) subs[3]).selected = NO;
    sender.selected = YES;
    _IsTallage = sender.tag == 1 ? 1 : 0;
}

- (void)laodonghetong:(UIButton *)sender {
    NSArray *subs = [sender.superview subviews];
    ((UIButton *) subs[2]).selected = NO;
    ((UIButton *) subs[3]).selected = NO;
    sender.selected = YES;
    _IsPact = sender.tag == 1 ? 1 : 0;
}

- (void)fangchan:(UIButton *)sender {
    NSArray *subs = [sender.superview subviews];
    ((UIButton *) subs[2]).selected = NO;
    ((UIButton *) subs[3]).selected = NO;
    sender.selected = YES;
    if (sender.tag == 1) {
        _fangchan = 10;
    } else {
        _fangchan = 5;
    }
    [_myTableView reloadData];
    
}


- (void)textFieldChange:(UITextField *)sender {
    _fangchanNum = [sender.text intValue];
}

- (void)startJisuan:(UIButton *)sender {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (_hujiType == 1) {
        [params setValue:_tips[_hujiType] forKey:@"ComFrom"];
        [params setValue:@(_hujiType) forKey:@"ComFromType"];
        [params setValue:@(_IsMarriage) forKey:@"IsMarriage"];
        [params setValue:@(_IsBothAll) forKey:@"IsBothAll"];
        if (_fangchan == 10) {
            [params setValue:@(_fangchanNum) forKey:@"MyHouseQty"];
        }
    } else if (_hujiType == 2) {
        [params setValue:_tips[_hujiType] forKey:@"ComFrom"];
        [params setValue:@(_hujiType) forKey:@"ComFromType"];
        [params setValue:@(_IsMarriage) forKey:@"IsMarriage"];
        [params setValue:@(_IsTallage) forKey:@"IsBothAll"];
        if (_fangchan == 10) {
            [params setValue:@(_fangchanNum) forKey:@"MyHouseQty"];
        }
    } else if (_hujiType > 2) {
        
    } else {
        
    }
    [params setValue:TOKEN forKey:@"token"];
    NSString *URL = [NSString stringWithFormat:@"%@/Trade/Limitation/Add",BaseUrl];
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (IBAction)calculateAction:(UIButton *)sender {
    XgShareViewController *share = [[XgShareViewController alloc] init];
    [self.navigationController pushViewController:share animated:YES];
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
