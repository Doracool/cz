//
//  LogListController.m
//  CZToken
//
//  Created by jlc on 2018/3/2.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "LogListController.h"
#import "logListCell.h"
#import "writeLogController.h"
@interface LogListController ()<DOPDropDownMenuDelegate,DOPDropDownMenuDataSource>

@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSArray *arr1;
@property (nonatomic, strong) NSArray *arr2;
@property (nonatomic, strong) NSArray *arr3;

@property (nonatomic, strong) DOPDropDownMenu *menu;

@end

@implementation LogListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arr1 = @[@"22",@"4532",@"753",@"75374"];
    self.arr2 = @[@"22",@"33",@"44",@"5"];
    self.arr3 = @[@"czx",@"qew",@"sdfad",@"sfd"];
    _myTableView.rowHeight = 90;
    // 添加下拉菜单
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:40];
    menu.delegate = self;
    menu.dataSource = self;
//    [self.view addSubview:menu];
    _menu = menu;
    
//    _menu.finishedBlock = ^(DOPIndexPath *indexPath) {
//        
//    };
//    [menu selectIndexPath:[DOPIndexPath indexPathWithCol:0 row:0 item:0]];
    
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

- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 3;
}


- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if (column == 0) {
        return self.arr1.count;
    }else if (column == 1){
        return self.arr2.count;
    }else {
        return self.arr3.count;
    }
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        return self.arr1[indexPath.row];
    } else if (indexPath.column == 1){
        return self.arr2[indexPath.row];
    } else {
        return self.arr3[indexPath.row];
    }
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column {
    return 0;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    logListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"logListCell" owner:self options:nil][0];
    }
    return cell;
}
- (IBAction)writeLogAction:(UIButton *)sender {
    writeLogController *write = [[writeLogController alloc] init];
    [self.navigationController pushViewController:write animated:YES];
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
