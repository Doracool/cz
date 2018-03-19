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
@property (nonatomic, assign) int MyHouseQty;
@end

@implementation XgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tabbarHidden];
    _tips = @[@"上海单身",@"外地人",@"驻沪军官",@"港澳同胞",@"台湾同胞",@"外籍人士"];
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

- (void)chooseTagsArr:(NSMutableArray *)chooseArr {
    _hujiType = [chooseArr[0] intValue] + 1;
    NSLog(@"%d",_hujiType);
    [_myTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_hujiType == 1) {
        return 3;
    } else if (_hujiType == 2) {
        return 3;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [[UITableViewCell alloc] init];
//    cell.textLabel.text = @"哈哈";
    xgChooseCell *cell = [[NSBundle mainBundle] loadNibNamed:@"xgChooseCell" owner:self options:nil][0];
    xgResultCell *resultCell = [[NSBundle mainBundle] loadNibNamed:@"xgResultCell" owner:self options:nil][0];
    houseSignCell *clickCell = [[NSBundle mainBundle] loadNibNamed:@"houseSignCell" owner:self options:nil][0];
    if (_hujiType == 1) {
        if (indexPath.row == 0) {
            cell.chooseTitel.text = @"婚姻状况";
            [cell.chooseLeft setTitle:@" 已婚" forState:UIControlStateNormal];
            [cell.chooseRight setTitle:@" 未婚" forState:UIControlStateNormal];
            [cell.chooseLeft addTarget:self action:@selector(chooseClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.chooseRight addTarget:self action:@selector(chooseClick:) forControlEvents:UIControlEventTouchUpInside];
        } else if (indexPath.row == 1) {
            cell.chooseTitel.text = @"是否双方全部上海户籍";
            [cell.chooseLeft setTitle:@" 一方" forState:UIControlStateNormal];
            [cell.chooseRight setTitle:@" 双方" forState:UIControlStateNormal];
        } else if (indexPath.row == 2) {
            cell.chooseTitel.text = @"家庭在沪有无住宅";
            [cell.chooseLeft setTitle:@" 有" forState:UIControlStateNormal];
            [cell.chooseRight setTitle:@" 无" forState:UIControlStateNormal];
        } else if (indexPath.row == 3) {
            [clickCell.signInBtn setTitle:@"开始计算" forState:UIControlStateNormal];
            [clickCell.signInBtn addTarget:self action:@selector(startJisuan:) forControlEvents:UIControlEventTouchUpInside];
        }
    } else if (_hujiType == 2) {
        if (indexPath.row == 0) {
            cell.chooseTitel.text = @"婚姻状况";
            [cell.chooseLeft setTitle:@" 已婚" forState:UIControlStateNormal];
            [cell.chooseRight setTitle:@" 未婚" forState:UIControlStateNormal];
        } else if (indexPath.row == 1) {
            cell.chooseTitel.text = @"63个月内满60个月的社保或税单";
            [cell.chooseLeft setTitle:@" 已满" forState:UIControlStateNormal];
            [cell.chooseRight setTitle:@" 未满" forState:UIControlStateNormal];
        } else if (indexPath.row == 2) {
            cell.chooseTitel.text = @"家庭在沪有无住宅";
            [cell.chooseLeft setTitle:@" 有" forState:UIControlStateNormal];
            [cell.chooseRight setTitle:@" 无" forState:UIControlStateNormal];
        } else if (indexPath.row == 3) {
            [clickCell.signInBtn setTitle:@"开始计算" forState:UIControlStateNormal];
            [clickCell.signInBtn addTarget:self action:@selector(startJisuan:) forControlEvents:UIControlEventTouchUpInside];
        }
    } else {
        if (indexPath.row == 0) {
            cell.chooseTitel.text = @"在沪劳动合同已满一年";
            [cell.chooseLeft setTitle:@" 已满" forState:UIControlStateNormal];
            [cell.chooseRight setTitle:@" 未满" forState:UIControlStateNormal];
        } else if (indexPath.row == 1) {
            cell.chooseTitel.text = @"家庭在沪有无住宅";
            [cell.chooseLeft setTitle:@" 有" forState:UIControlStateNormal];
            [cell.chooseRight setTitle:@" 无" forState:UIControlStateNormal];
        } else if (indexPath.row == 2) {
            [clickCell.signInBtn setTitle:@"开始计算" forState:UIControlStateNormal];
            [clickCell.signInBtn addTarget:self action:@selector(startJisuan:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return cell;
}

- (void)chooseClick:(UIButton *)sender {
    _IsMarriage = sender.tag == 1 ? 1 : 0;
}

- (void)shanghaihuji:(UIButton *)sender {
    _IsBothAll = sender.tag == 1 ? 1 : 0;
}

- (void)shebao:(UIButton *)sender {
    _IsTallage = sender.tag == 1 ? 1 : 0;
}

- (void)laodonghetong:(UIButton *)sender {
    _IsPact = sender.tag == 1 ? 1 : 0;
}

- (void)fangchan:(UIButton *)sender {
    
}

- (void)startJisuan:(UIButton *)sender {
    NSDictionary *params = [NSDictionary dictionary];
    if (_hujiType == 1) {
        params = @{@"ComFrom":_tips[_hujiType],@"ComFromType":@(_hujiType),@"IsMarriage":@(_IsMarriage),@"IsBothAll":@(_IsBothAll)};
    } else if (_hujiType == 2) {
        params = @{@"ComFrom":_tips[_hujiType],@"ComFromType":@(_hujiType),@"IsMarriage":@(_IsMarriage),@"IsBothAll":@(_IsBothAll)};
    } else if (_hujiType > 2) {
        
    } else {
        
    }
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
