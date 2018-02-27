//
//  HomeViewController.m
//  CZToken
//
//  Created by jlc on 2018/2/26.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeIconCell.h"
#import "TitleIconCell.h"
#import "NewsViewCell.h"
#import "iconCell.h"

#import "XgViewController.h"
#import "loansViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self navigationBarHidden];
    [self leftNavBarItemWithImage:@"duigou"];
    [self rightNavBarItemWithTitle:@"" AndSel:@selector(addressClick)];
    UITextField *search = [[UITextField alloc] initWithFrame:CGRectMake(50, 10, screenW-120, 30)];
    self.navigationItem.titleView = search;
    search.placeholder = @"哈哈哈";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(iconClick:) name:@"icon" object:nil];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeIconCell *homeCell = [[NSBundle mainBundle] loadNibNamed:@"HomeIconCell" owner:self options:nil][0];
    TitleIconCell *titleCell = [[NSBundle mainBundle] loadNibNamed:@"TitleIconCell" owner:self options:nil][0];
    NewsViewCell *newCell = [[NSBundle mainBundle] loadNibNamed:@"NewsViewCell" owner:self options:nil][0];
    iconCell *iconCell = [[NSBundle mainBundle] loadNibNamed:@"iconCell" owner:self options:nil][0];
    if (indexPath.row == 0) {
        tableView.rowHeight = 250;
        return homeCell;
    } else if (indexPath.row == 1 || indexPath.row == 5) {
        tableView.rowHeight = 50;
        return titleCell;
    } else if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4) {
        tableView.rowHeight = 80;
        return newCell;
    } else if (indexPath.row == 6) {
        tableView.rowHeight = screenW/2;
        return iconCell;
    }
    
    return homeCell;
}

- (void)iconClick:(NSNotification *)notification {
    NSInteger tag = [notification.userInfo[@"tag"] intValue];
    NSLog(@"%ld",(long)tag);
    if (tag == 2) {
        XgViewController *xg = [[XgViewController alloc] init];
        [self.navigationController pushViewController:xg animated:YES];
    } else if (tag == 3) {
        loansViewController *loans = [[loansViewController alloc] init];
        [self.navigationController pushViewController:loans animated:YES];
    }
    
}

- (void)addressClick {
    
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
