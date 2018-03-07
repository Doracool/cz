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

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@end

@implementation baseAuditController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    houseTextCell *cell = [[NSBundle mainBundle] loadNibNamed:@"houseTextCell" owner:self options:nil][0];
    doublebtnCell *btnCell = [[NSBundle mainBundle] loadNibNamed:@"doublebtnCell" owner:self options:nil][0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 8) {
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
        tableView.rowHeight = 130;
        return cell;
    } else if (indexPath.row == 1) {
        tableView.rowHeight =50;
        cell.myText.text = @"具体物业地址";
        cell.myContent.text = @"哈哈";
        return cell;
    } else if (indexPath.row == 2) {
        tableView.rowHeight =50;
        cell.myText.text = @"物业类型";
        cell.myContent.text = @"哈哈";
        return cell;
    } else if (indexPath.row == 3) {
        tableView.rowHeight =50;
        cell.myText.text = @"交易类型";
        cell.myContent.text = @"哈哈";
        return cell;
    } else if (indexPath.row == 4) {
        tableView.rowHeight =50;
        cell.myText.text = @"委托价格";
        cell.myContent.text = @"哈哈";
        return cell;
    } else if (indexPath.row == 5) {
        tableView.rowHeight = 50;
        cell.myText.text = @"联系方式";
        cell.myContent.text = @"126123781029";
        cell.line.backgroundColor = [UIColor clearColor];
        return cell;
    } else {
        tableView.rowHeight = 50;
        cell.myText.text = @"";
        cell.myContent.text = @"437981234012";
        cell.line.backgroundColor = [UIColor clearColor];
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
