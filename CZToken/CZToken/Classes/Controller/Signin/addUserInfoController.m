//
//  addUserInfoController.m
//  CZToken
//
//  Created by jlc on 2018/3/8.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "addUserInfoController.h"
#import "textCell.h"
#import "houseSignCell.h"
@interface addUserInfoController ()

@end

@implementation addUserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    textCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"textCell" owner:self options:nil][0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.rowHeight = 50;
    if (indexPath.row == 0) {
        cell.text.text = @"姓名";
    } else if (indexPath.row == 1) {
        cell.text.text = @"出生日期";
    } else if (indexPath.row == 2) {
        cell.text.text = @"星座";
    } else if (indexPath.row == 3) {
        cell.text.text = @"属相";
    } else if (indexPath.row == 4) {
        cell.text.text = @"性别";
    } else if (indexPath.row == 5) {
        cell.text.text = @"手机号码";
    } else if (indexPath.row == 6) {
        cell.text.text = @"邮箱";
    } else if (indexPath.row == 7) {
        cell.text.text = @"最高学历";
    } else if (indexPath.row == 8) {
        cell.text.text = @"在职单位";
    } else if (indexPath.row == 9) {
        cell.text.text = @"本人持证照";
    } else if (indexPath.row == 10) {
        cell.text.text = @"行业";
    } else if (indexPath.row == 11) {
        houseSignCell *cell = [[NSBundle mainBundle] loadNibNamed:@"houseSignCell" owner:self options:nil][0];
        tableView.rowHeight = 150;
        return cell;
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
