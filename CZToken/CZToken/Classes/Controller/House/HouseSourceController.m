//
//  HouseSourceController.m
//  CZToken
//
//  Created by jlc on 2018/2/25.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "HouseSourceController.h"
#import "houseSourceCell.h"
#import "HouseDetailsController.h"
#import "addHouseInfoController.h"
#import "userSearchController.h"
#import "houseAddressController.h"
#import "baseAuditController.h"
#import "houseAddressController.h"
#import "areaModel.h"
@interface HouseSourceController ()<DOPDropDownMenuDelegate,DOPDropDownMenuDataSource,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *arr1;
@property (nonatomic, strong) NSArray *arr2;
@property (nonatomic, strong) NSArray *arr3;
@property (nonatomic, strong) NSArray *arr4;
@property (nonatomic, strong) UIButton *add;
@property (nonatomic, weak) DOPDropDownMenu *menu;
@property (nonatomic, strong) UITableView *myTableView;
@end

@implementation HouseSourceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.arr1 = @[@"区域",@"全部",@"宝山",@"普陀"];
    self.arr2 = @[@"排序",@"总价降序",@"总价升序",@"单价降序",@"单价升序",@"面积降序",@"面积升序"];
    self.arr3 = @[@"交易",@"全部",@"出租",@"出售"];
    self.arr4 = @[@"类型",@"全部",@"住宅",@"别墅",@"其他"];
    
    UITextField *search = [[UITextField alloc] initWithFrame:CGRectMake(15, 25, screenW-120, 35)];
    [self.view addSubview:search];
    search.placeholder = @"  🔍请输入小区名称";
    search.layer.borderColor = [UIColor lineColor].CGColor;
    search.layer.borderWidth = 1.0f;
    search.layer.cornerRadius = 2.0f;
    search.layer.masksToBounds = YES;
    
    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(screenW-90, 25, 80, 35)];
    [self.view addSubview:searchBtn];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setBackgroundColor:[UIColor navbackgroundColor]];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchBtn.layer.cornerRadius = 5.0f;
    searchBtn.layer.masksToBounds = YES;
    [searchBtn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:40];
    menu.delegate = self;
    menu.dataSource = self;
    menu.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    [self.view addSubview:menu];
    _menu = menu;
    
    _menu.finishedBlock = ^(DOPIndexPath *indexPath) {
        
    };
    [menu selectIndexPath:[DOPIndexPath indexPathWithCol:0 row:0 item:0]];
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, screenW, screenH-104) style:UITableViewStylePlain];
    [self.view addSubview:_myTableView];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.rowHeight = 120;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view.
    self.add = [[UIButton alloc] initWithFrame:CGRectMake(screenW-80, screenH-200, 50, 50)];
    [self.view addSubview:self.add];
    [_add setTitle:@"+" forState:UIControlStateNormal];
    [_add setBackgroundColor:[UIColor redColor]];
    _add.layer.cornerRadius = 25.0f;
    _add.layer.masksToBounds = YES;
    [_add setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_add addTarget:self action:@selector(addHouse) forControlEvents:UIControlEventTouchUpInside];
    
    [self requestArea];
}

- (void)requestArea {
    NSString *URL = [NSString stringWithFormat:@"%@/Trade/TradeArea/Get?token=%@",BaseUrl,TOKEN];
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        areaModel *model = [areaModel mj_objectWithKeyValues:dic];
        NSLog(@"%@",model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self navigationBarHidden];
}

- (void)addHouse {
    houseAddressController *add = [[houseAddressController alloc] init];
    [self.navigationController pushViewController:add animated:YES];
}

- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu {
    return 4;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if (column == 0) {
        return self.arr1.count;
    } else if (column == 1) {
        return self.arr2.count;
    } else if (column == 2) {
        return self.arr3.count;
    } else {
        return self.arr4.count;
    }
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath {
    if (indexPath.column == 0) {
        return self.arr1[indexPath.row];
    } else if (indexPath.column == 1) {
        return self.arr2[indexPath.row];
    } else if (indexPath.column == 2) {
        return self.arr3[indexPath.row];
    } else {
        return self.arr4[indexPath.row];
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
    houseSourceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"houseSourceCell" owner:self options:nil][0];
        cell.iconImg.image = [UIImage imageNamed:@"01"];
        cell.chatBtn.width = 40;
        cell.chatBtn.layer.borderWidth = 1.0f;
        cell.chatBtn.layer.borderColor = [UIColor colorWithHexString:@"D3504F"].CGColor;
        cell.chatBtn.layer.cornerRadius = 4.0f;
        
        
        NSArray *tips = @[@"上海单身",@"上海户口"];
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
        [arr addObjectsFromArray:tips];
        TTChooseBtnView *view = [[TTChooseBtnView alloc] initWithFrame:CGRectMake(0, 0, screenW-24, 40) andTags:tips andTitleColor:[UIColor colorWithHexString:@"666666"] andborderColor:[UIColor colorWithHexString:@"333333"] andFonts:13.f];
        [cell.typeView addSubview:view];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HouseDetailsController *details = [[HouseDetailsController alloc] init];
    
    houseAddressController *address = [[houseAddressController alloc] init];
    baseAuditController *audit = [[baseAuditController alloc] init];
    [self.navigationController pushViewController:details animated:YES];
}

- (void)searchAction:(UIButton *)sender {
    userSearchController *search = [[userSearchController alloc] init];
    [self.navigationController pushViewController:search animated:YES];
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
