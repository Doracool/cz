//
//  baseAuditController.m
//  CZToken
//
//  Created by jlc on 2018/3/6.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "baseAuditController.h"
#import "houseTextCell.h"
#import "doublebtnCell.h"
#import "impAuditController.h"
#import "auditHeadCell.h"
@interface baseAuditController ()

@end

@implementation baseAuditController

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
    houseTextCell *cell = [[NSBundle mainBundle] loadNibNamed:@"houseTextCell" owner:self options:nil][0];
    doublebtnCell *btnCell = [[NSBundle mainBundle] loadNibNamed:@"doublebtnCell" owner:self options:nil][0];
    if (indexPath.row == 4) {
        tableView.rowHeight = 150;
        [btnCell.rightBtn addTarget:self action:@selector(pass) forControlEvents:UIControlEventTouchUpInside];
        return btnCell;
    } else if (indexPath.row == 0) {
        auditHeadCell *cell = [[NSBundle mainBundle] loadNibNamed:@"auditHeadCell" owner:self options:nil][0];
        tableView.rowHeight = 130;
        return cell;
    } else {
        tableView.rowHeight =60;
        cell.myText.text = @"具体物业地址";
        cell.myContent.text = @"哈哈";
        return cell;
    }
}

- (void)pass {
    impAuditController *impAudit = [[impAuditController alloc] init];
    [self.navigationController pushViewController:impAudit animated:YES];
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
