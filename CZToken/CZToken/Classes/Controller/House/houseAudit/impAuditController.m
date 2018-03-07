//
//  impAuditController.m
//  CZToken
//
//  Created by jlc on 2018/3/6.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "impAuditController.h"
#import "houseTextCell.h"
#import "doublebtnCell.h"
#import "imgAudtiController.h"
#import "houseAddressCell.h"
#import "auditHeadCell.h"
@interface impAuditController ()

@end

@implementation impAuditController

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
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    houseTextCell *cell = [[NSBundle mainBundle] loadNibNamed:@"houseTextCell" owner:self options:nil][0];
    houseAddressCell *addressCell = [[NSBundle mainBundle] loadNibNamed:@"houseAddressCell" owner:self options:nil][0];
    addressCell.selectionStyle = UITableViewCellSelectionStyleNone;
    doublebtnCell *btnCell = [[NSBundle mainBundle] loadNibNamed:@"doublebtnCell" owner:self options:nil][0];
    btnCell.selectionStyle = UITableViewCellSeparatorStyleNone;
    if (indexPath.row == 2) {
        tableView.rowHeight = 150;
        btnCell.selectionStyle = UITableViewCellSelectionStyleNone;
        btnCell.leftBtn.layer.borderColor = [UIColor colorWithHexString:@"333333"].CGColor;
        btnCell.leftBtn.layer.borderWidth = 1.0f;
        [btnCell.leftBtn setTitle:@"审核不通过" forState:UIControlStateNormal];
        [btnCell.leftBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [btnCell.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnCell.rightBtn setTitle:@"审核通过" forState:UIControlStateNormal];        [btnCell.rightBtn addTarget:self action:@selector(pass) forControlEvents:UIControlEventTouchUpInside];
        return btnCell;
    } else if (indexPath.row == 0) {
        auditHeadCell *cell = [[NSBundle mainBundle] loadNibNamed:@"auditHeadCell" owner:self options:nil][0];
        tableView.rowHeight = 150;
        return cell;
    } else {
        tableView.rowHeight =620;
        return addressCell;
    }
}

- (void)pass {
    imgAudtiController *imgAudit = [[imgAudtiController alloc] init];
    [self.navigationController pushViewController:imgAudit animated:YES];
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
