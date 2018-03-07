//
//  houseAddressController.m
//  CZToken
//
//  Created by jlc on 2018/3/5.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "houseAddressController.h"
#import "sourceAddressCell.h"
#import "UserlinkCell.h"
#import "addLinkCell.h"
#import "houseImpInfoController.h"
#import "houseImpTwoController.h"
@interface houseAddressController ()
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, assign) NSInteger rows;
@end

@implementation houseAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    _rows = 3;
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
    return _rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        sourceAddressCell *cell = [[NSBundle mainBundle] loadNibNamed:@"sourceAddressCell" owner:self options:nil][0];
        tableView.rowHeight = 400;
        return cell;
    } else if (indexPath.row == _rows-1) {
        addLinkCell *cell = [[NSBundle mainBundle] loadNibNamed:@"addLinkCell" owner:self options:nil][0];
        cell.addBtn.layer.borderWidth = 1.0f;
        cell.addBtn.layer.borderColor = [UIColor colorWithHexString:@"444444"].CGColor;
        [cell.addBtn addTarget:self action:@selector(addLinkAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.nextBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
        tableView.rowHeight = 150;
        return cell;
    } else {
        UserlinkCell *cell = [[NSBundle mainBundle] loadNibNamed:@"UserlinkCell" owner:self options:nil][0];
        tableView.rowHeight = 120;
        return cell;
    }
    
    return nil;
}

- (void)addLinkAction {
    _rows++;
    [_myTableView reloadData];
}

- (void)nextAction {
    houseImpInfoController *impInfo = [[houseImpInfoController alloc] init];
    houseImpTwoController *impTwo = [[houseImpTwoController alloc] init];
    [self.navigationController pushViewController:impInfo animated:YES];
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