//
//  HouseDetailsController.m
//  CZToken
//
//  Created by 周帅杰 on 2018/3/1.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "HouseDetailsController.h"
#import "lookOwnerController.h"
#import "houseDetaiseCellOne.h"
#import "houseDetailsCellTwo.h"
#import "houseDetailsTextCell.h"
#import "houseDetailsInfoCell.h"
#import "houseSignCell.h"
#import "houseInfoMoreCell.h"
#import "buyHouseCell.h"
#import "HouseRankCell.h"
#import "foreSigninController.h"
#import "houseAddressController.h"
#import "lookOwnerController.h"
#import "LogListController.h"
@interface HouseDetailsController ()
@property (assign) BOOL selected;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation HouseDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"房源";
    _selected = NO;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        houseDetaiseCellOne *cell = [[NSBundle mainBundle] loadNibNamed:@"houseDetaiseCellOne" owner:self options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        LPCarouselView *header = [LPCarouselView carouselViewWithFrame:CGRectMake(0, 0, screenW, 200) placeholderImage:[UIImage imageNamed:@""] images:^NSArray *{
            return @[@"123",@"321"];
        } titles:^NSArray *{
            return nil;
        } selectedBlock:^(NSInteger index) {
            
        }];
        [cell.headerView addSubview:header];
        cell.xiaoqu.text = @"新会南苑";
        cell.renzheng.text = @" 业主认证 ";
        cell.renzheng.layer.borderColor = [UIColor colorWithHexString:@"333333"].CGColor;
        cell.renzheng.layer.borderWidth = 1.0f;
        cell.renzheng.layer.cornerRadius = 3.0f;
        
        NSArray *tips = @[@"满二年",@"地铁房"];
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
        [arr addObjectsFromArray:tips];
        TTChooseBtnView *view = [[TTChooseBtnView alloc] initWithFrame:CGRectMake(0, 0, screenW-24, 40) andTags:tips andTitleColor:[UIColor colorWithHexString:@"666666"] andborderColor:[UIColor colorWithHexString:@"333333"] andFonts:13.f];
        [cell.typeView addSubview:view];
        
        cell.price.text = @"650万元";
        cell.liulan.text = @"350人看过";
        
        [cell.star addTarget:self action:@selector(starAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.follow addTarget:self action:@selector(followAction) forControlEvents:UIControlEventTouchUpInside];
        tableView.rowHeight = 300;
        return cell;
    } else if (indexPath.row == 1) {
        houseDetailsCellTwo *cell = [[NSBundle mainBundle] loadNibNamed:@"houseDetailsCellTwo" owner:self options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.shoujia.text = @"300W";
        cell.fangxing.text = @"2室2厅1卫";
        cell.mianji.text = @"70㎡";
        cell.danjia.text = @"4888元/㎡";
        cell.louceng.text = @"中层(共六层)";
        cell.leixing.text = @"普通住宅";
        cell.niandai.text = @"2013";
        cell.xiaoqu.text = @"浦东-御桥-龙玉小区";
        cell.chaoxiang.text = @"南北";
        cell.jingzhuangxiu.text = @"精装修";
        cell.fabu.text = @"2018-01-23";
        
        tableView.rowHeight = 280;
        return cell;
    } else if (indexPath.row == 2) {
        // 文字
//        houseDetailsTextCell *cell = [[NSBundle mainBundle] loadNibNamed:@"houseDetailsTextCell" owner:self options:nil][0];
//        tableView.rowHeight = 100;
//        return cell;
        /*
        houseSignCell *cell = [[NSBundle mainBundle] loadNibNamed:@"houseSignCell" owner:self options:nil][0];
        [cell.signInBtn addTarget:self action:@selector(signInAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.signInBtn setBackgroundColor:[UIColor navbackgroundColor]];
        tableView.rowHeight = 100;
         */
        
        // 购买
        
//        buyHouseCell *buyCell = [[NSBundle mainBundle] loadNibNamed:@"buyHouseCell" owner:self options:nil][0];
//
//        tableView.rowHeight = 150;
//        buyCell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return buyCell;
        
        // 更多
        
        houseInfoMoreCell *moreCell = [[NSBundle mainBundle] loadNibNamed:@"houseInfoMoreCell" owner:self options:nil][0];
        moreCell.cqnx.text = @"满五";
        moreCell.lchj.text = @"有电梯 一户";
        moreCell.sfzf.text = @"是";
        moreCell.jfqk.text = @"提前交房";
        moreCell.dcqz.text = @"是";
        moreCell.ts.text = @"复式 带天井";
        moreCell.jzqk.text = @"钥匙房";
        moreCell.dkqk.text = @"约200万元";
        moreCell.hkqc.text = @"是";
        moreCell.cqr.text = @"2个";
        if (_selected) {
            moreCell.viewHeight.constant = 0;
            moreCell.moreView.hidden = YES;
            tableView.rowHeight = 220;
        } else {
            moreCell.viewHeight.constant = 160;
            moreCell.moreView.hidden = NO;
            tableView.rowHeight = 380;
        }
        
        [moreCell.moreBtn addTarget:self action:@selector(openOrClose:) forControlEvents:UIControlEventTouchUpInside];
        [moreCell.seeBtn addTarget:self action:@selector(seeAction:) forControlEvents:UIControlEventTouchUpInside];
        [moreCell.followBtn addTarget:self action:@selector(followHouseAction:) forControlEvents:UIControlEventTouchUpInside];
        moreCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return moreCell;
        
//        return cell;
    } else if (indexPath.row == 3) {
        HouseRankCell *cell = [[NSBundle mainBundle] loadNibNamed:@"HouseRankCell" owner:self options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        tableView.rowHeight = 50;
        return cell;
    } else if (indexPath.row == 5) {
        houseDetailsTextCell *cell = [[NSBundle mainBundle] loadNibNamed:@"houseDetailsTextCell" owner:self options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        tableView.rowHeight = 80;
        return cell;
    } else {
        houseDetailsInfoCell *cell = [[NSBundle mainBundle] loadNibNamed:@"houseDetailsInfoCell" owner:self options:nil][0];
        tableView.rowHeight = 90;
        cell.iconImg.image = [UIImage imageNamed:@"02"];
        cell.name.text = @"杨志峰";
        cell.company.text = @"南山地产";
        cell.sxd.text = @"182";
        cell.cxz.text = @"652";
        cell.zyz.text = @"354";
        cell.lxtBtn.layer.borderWidth = 1.0f;
        cell.lxtBtn.layer.borderColor = [UIColor colorWithHexString:@"666666"].CGColor;
        cell.lxtBtn.layer.cornerRadius = 3.0f;
        [cell.lxtBtn addTarget:self action:@selector(linkAction:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.lxtBtn.hidden = YES;
        
        cell.dhtBtn.layer.borderWidth = 1.0f;
        cell.dhtBtn.layer.borderColor = [UIColor colorWithHexString:@"666666"].CGColor;
        cell.dhtBtn.layer.cornerRadius = 3.0f;
        [cell.dhtBtn addTarget:self action:@selector(callAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.dhtBtn.hidden = YES;
        
        return cell;
    }
    return nil;
}



- (void)starAction {
    
}

- (void)followAction {
    
}

- (void)linkAction:(UIButton *)sender {
    
}

- (void)callAction:(UIButton *)sender {
    
}

- (void)openOrClose:(UIButton *)sender {
    if (_selected) {
        _selected = NO;
    } else {
        _selected = YES;
    }
    [_myTableView reloadData];
}

- (void)seeAction:(UIButton *)sender {
    lookOwnerController *lookOwner = [[lookOwnerController alloc] init];
    [self.navigationController pushViewController:lookOwner animated:YES];
}

- (void)followHouseAction:(UIButton *)sender {
    LogListController *logList = [[LogListController alloc] init];
    [self.navigationController pushViewController:logList animated:YES];
}

- (void)signInAction {
    foreSigninController *signin = [[foreSigninController alloc] init];
    [self.navigationController pushViewController:signin animated:YES];
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
