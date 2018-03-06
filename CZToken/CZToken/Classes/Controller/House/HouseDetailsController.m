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

#import "foreSigninController.h"
#import "houseAddressController.h"
@interface HouseDetailsController ()

@end

@implementation HouseDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"房源";
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
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        houseDetaiseCellOne *cell = [[NSBundle mainBundle] loadNibNamed:@"houseDetaiseCellOne" owner:self options:nil][0];
        LPCarouselView *header = [LPCarouselView carouselViewWithFrame:CGRectMake(0, 0, screenW, 200) placeholderImage:[UIImage imageNamed:@""] images:^NSArray *{
            return @[@"123",@"321"];
        } titles:^NSArray *{
            return nil;
        } selectedBlock:^(NSInteger index) {
            
        }];
        [cell.headerView addSubview:header];
        tableView.rowHeight = 290;
        return cell;
    } else if (indexPath.row == 1) {
        houseDetailsCellTwo *cell = [[NSBundle mainBundle] loadNibNamed:@"houseDetailsCellTwo" owner:self options:nil][0];
        tableView.rowHeight = 300;
        return cell;
    } else if (indexPath.row == 2) {
//        houseInfoMoreCell *cell = [[NSBundle mainBundle] loadNibNamed:@"houseInfoMoreCell" owner:self options:nil][0];
        
        
//        houseDetailsTextCell *cell = [[NSBundle mainBundle] loadNibNamed:@"houseDetailsTextCell" owner:self options:nil][0];
//        tableView.rowHeight = 330;
//        return cell;
        houseSignCell *cell = [[NSBundle mainBundle] loadNibNamed:@"houseSignCell" owner:self options:nil][0];
        [cell.signInBtn addTarget:self action:@selector(signInAction) forControlEvents:UIControlEventTouchUpInside];
        tableView.rowHeight = 100;
        return cell;
    } else {
        houseDetailsInfoCell *cell = [[NSBundle mainBundle] loadNibNamed:@"houseDetailsInfoCell" owner:self options:nil][0];
        tableView.rowHeight = 90;
        return cell;
    }
    return nil;
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
