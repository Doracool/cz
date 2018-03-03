//
//  lookOwnerController.m
//  CZToken
//
//  Created by jlc on 2018/3/2.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "lookOwnerController.h"
#import "OwnerInfoCell.h"
#import "writeLogController.h"
#import "LogListController.h"
@interface lookOwnerController ()
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation lookOwnerController

- (void)viewDidLoad {
    [super viewDidLoad];
    _myTableView.rowHeight = 150;
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    OwnerInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"OwnerInfoCell" owner:self options:nil][0];
    }
    return cell;
}

- (IBAction)writeContent:(UIButton *)sender {
    
    LogListController *log = [[LogListController alloc] init];

//    writeLogController *log = [[writeLogController alloc] init];
    [self.navigationController pushViewController:log animated:YES];
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
