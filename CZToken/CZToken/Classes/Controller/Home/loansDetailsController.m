//
//  loansDetailsController.m
//  CZToken
//
//  Created by jlc on 2018/3/22.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "loansDetailsController.h"
#import "textCell.h"
#import "loansDetailsModel.h"
@interface loansDetailsController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation loansDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 30)];
    [self.view addSubview:label];
    label.textAlignment = NSTextAlignmentLeft;
    label.text = @"还款记录";
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, screenW, screenH-50) style:UITableViewStylePlain];
    [self.view addSubview:_myTableView];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self requestInfo];
    // Do any additional setup after loading the view.
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}

- (void)requestInfo {
    NSString *URL = [NSString stringWithFormat:@"%@/Trade/LoansMonthly/CalLoansMonthlyById",BaseUrl];
    NSDictionary *params = @{@"loansMonthlyId":_monthId};
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        loansDetailsModel *model = [loansDetailsModel mj_objectWithKeyValues:dic];
        self.dataArray = model.Data;
        [self.myTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    loansDetailsDataModel *model = [loansDetailsDataModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
    textCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"textCell" owner:self options:nil][0];
    }
    cell.backgroundColor =  [UIColor colorWithHexString:@"F5F5F5"];
    cell.userInteractionEnabled = NO;
    cell.text.text = [NSString stringWithFormat:@"第%@个月",model.Number];
    cell.content.text = model.RepayMonthly;
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
