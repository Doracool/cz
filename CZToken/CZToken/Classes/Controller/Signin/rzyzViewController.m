//
//  rzyzViewController.m
//  CZToken
//
//  Created by jlc on 2018/2/28.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "rzyzViewController.h"
#import "textCell.h"
#import "UpImgCell.h"
@interface rzyzViewController ()

@end

@implementation rzyzViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    textCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"textCell" owner:self options:nil][0];
    }
    if (indexPath.row == 0) {
        cell.text.text = @"城区";
        tableView.rowHeight = 50;
    } else if (indexPath.row == 1) {
        cell.text.text = @"商圈";
        tableView.rowHeight = 50;
    } else if (indexPath.row == 2) {
        cell.text.text = @"楼盘字典";
        tableView.rowHeight = 50;
    } else if (indexPath.row == 3) {
        cell.text.text = @"栋座";
        tableView.rowHeight = 50;
    } else if (indexPath.row == 4) {
        cell.text.text = @"单元";
        tableView.rowHeight = 50;
    } else if (indexPath.row == 5) {
        cell.text.text = @"房号";
        tableView.rowHeight = 50;
    } else if (indexPath.row == 6) {
        cell.text.text = @"楼层";
        tableView.rowHeight = 50;
    } else if (indexPath.row == 7) {
        cell.text.text = @"总层";
        tableView.rowHeight = 50;
    }
    if (indexPath.row == 8) {
        UpImgCell *imgCell = [[NSBundle mainBundle] loadNibNamed:@"UpImgCell" owner:self options:nil][0];
        tableView.rowHeight = 350;
        return imgCell;
    }
    return cell;
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
