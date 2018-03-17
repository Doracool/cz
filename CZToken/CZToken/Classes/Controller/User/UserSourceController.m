//
//  UserSourceController.m
//  CZToken
//
//  Created by jlc on 2018/2/25.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "UserSourceController.h"
#import "topSearch.h"
#import "userHouseInfoCell.h"
@interface UserSourceController ()<DOPDropDownMenuDelegate,DOPDropDownMenuDataSource,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *arr1;
@property (nonatomic, strong) NSArray *arr2;
@property (nonatomic, strong) NSArray *arr3;
@property (nonatomic, strong) UIButton *add;
@property (nonatomic, weak) DOPDropDownMenu *menu;
@property (nonatomic, strong) UITableView *myTableView;
@end

@implementation UserSourceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [self initBaseUI];
    // Do any additional setup after loading the view.
}

- (void)initBaseUI {
    UIView *topSearch = [[NSBundle mainBundle] loadNibNamed:@"topSearch" owner:self options:nil][0];
    topSearch.frame = CGRectMake(0, 64, screenW, 50);
    [self.view addSubview:topSearch];
    
    self.arr1 = @[@"交易",@"全部",@"宝山",@"普陀"];
    self.arr2 = @[@"状态",@"总价降序",@"总价升序",@"单价降序",@"单价升序",@"面积降序",@"面积升序"];
    self.arr3 = @[@"筛选",@"全部",@"出租",@"出售"];
    
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 114) andHeight:40];
    menu.delegate = self;
    menu.dataSource = self;
    menu.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    [self.view addSubview:menu];
    _menu = menu;
    
    _menu.finishedBlock = ^(DOPIndexPath *indexPath) {
        
    };
    [menu selectIndexPath:[DOPIndexPath indexPathWithCol:0 row:0 item:0]];
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 154, screenW, screenH-154) style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [self.view addSubview:_myTableView];
}

- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu {
    return 3;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if (column == 0) {
        return self.arr1.count;
    } else if (column == 1) {
        return self.arr2.count;
    } else {
        return self.arr3.count;
    }
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath {
    if (indexPath.column == 0) {
        return self.arr1[indexPath.row];
    } else if (indexPath.column == 1) {
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
    userHouseInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"userHouseInfoCell" owner:self options:nil][0];
    }
    tableView.rowHeight = 100;
    if (indexPath.row%2) {
        cell.sellOrzu.attributedText = [commonSet AttributeNameFont:25 Color:[UIColor whiteColor] Space:0 qingxie:0.1 text:@"买" Range:NSMakeRange(0, 1)];
        cell.sellOrzu.backgroundColor = [UIColor navbackgroundColor];
    } else {
        cell.sellOrzu.attributedText = [commonSet AttributeNameFont:25 Color:[UIColor whiteColor] Space:0 qingxie:0.1 text:@"租" Range:NSMakeRange(0, 1)];
        cell.sellOrzu.backgroundColor = [UIColor orangeColor];
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
