//
//  imgAudtiController.m
//  CZToken
//
//  Created by jlc on 2018/3/6.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "imgAudtiController.h"
#import "houseTextCell.h"
#import "doublebtnCell.h"
#import "houseImgCell.h"
#import "auditHeadCell.h"
#import "AuditSuccController.h"
@interface imgAudtiController ()

@end

@implementation imgAudtiController

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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    houseImgCell *cell = [[NSBundle mainBundle] loadNibNamed:@"houseImgCell" owner:self options:nil][0];
    doublebtnCell *btnCell = [[NSBundle mainBundle] loadNibNamed:@"doublebtnCell" owner:self options:nil][0];
    if (indexPath.row == 4) {
        tableView.rowHeight = 150;
        btnCell.selectionStyle = UITableViewCellSelectionStyleNone;
        btnCell.leftBtn.layer.borderColor = [UIColor colorWithHexString:@"333333"].CGColor;
        btnCell.leftBtn.layer.borderWidth = 1.0f;
        [btnCell.leftBtn setTitle:@"审核不通过" forState:UIControlStateNormal];
        [btnCell.leftBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [btnCell.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnCell.rightBtn setTitle:@"审核通过" forState:UIControlStateNormal];
        [btnCell.rightBtn addTarget:self action:@selector(pass) forControlEvents:UIControlEventTouchUpInside];
        return btnCell;
    } else if (indexPath.row == 0) {
        auditHeadCell *cell = [[NSBundle mainBundle] loadNibNamed:@"auditHeadCell" owner:self options:nil][0];
        tableView.rowHeight = 150;
        return cell;
    } else {
        tableView.rowHeight =180;
        cell.myText.text = @"户型图";
        return cell;
    }
}

- (void)pass {
    AuditSuccController *succ = [[AuditSuccController alloc] init];
    [self.navigationController pushViewController:succ animated:YES];
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
