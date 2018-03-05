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
@interface HouseDetailsController ()

@end

@implementation HouseDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        houseDetaiseCellOne *cell = [[NSBundle mainBundle] loadNibNamed:@"houseDetaiseCellOne" owner:self options:nil][0];
        LPCarouselView *header = [LPCarouselView carouselViewWithFrame:CGRectMake(0, 0, screenW, 150) placeholderImage:[UIImage imageNamed:@""] images:^NSArray *{
            return @[@"123",@"321"];
        } titles:^NSArray *{
            return nil;
        } selectedBlock:^(NSInteger index) {
            
        }];
        [cell.headerView addSubview:header];
        tableView.rowHeight = 240;
        return cell;
    } else if (indexPath.row == 1) {
        houseDetailsCellTwo *cell = [[NSBundle mainBundle] loadNibNamed:@"houseDetailsCellTwo" owner:self options:nil][0];
        tableView.rowHeight = 300;
        return cell;
    } else if (indexPath.row == 2) {
        houseDetailsTextCell *cell = [[NSBundle mainBundle] loadNibNamed:@"houseDetailsTextCell" owner:self options:nil][0];
        tableView.rowHeight = 100;
        return cell;
//        houseSignCell *cell = [[NSBundle mainBundle] loadNibNamed:@"houseSignCell" owner:self options:nil][0];
//        tableView.rowHeight = 100;
//        return cell;
    } else {
        houseDetailsInfoCell *cell = [[NSBundle mainBundle] loadNibNamed:@"houseDetailsInfoCell" owner:self options:nil][0];
        tableView.rowHeight = 90;
        return cell;
    }
    return nil;
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
