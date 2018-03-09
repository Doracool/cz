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
#import "foreSigninController.h"
#import "UpInfoController.h"
@interface HomeViewController ()
{
    UIImageView *barImageView;
}
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    barImageView = self.navigationController.navigationBar.subviews.firstObject;
    barImageView.alpha = 0;
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
    homeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    TitleIconCell *titleCell = [[NSBundle mainBundle] loadNibNamed:@"TitleIconCell" owner:self options:nil][0];
    titleCell.selectionStyle = UITableViewCellSelectionStyleNone;
    NewsViewCell *newCell = [[NSBundle mainBundle] loadNibNamed:@"NewsViewCell" owner:self options:nil][0];
    newCell.selectionStyle = UITableViewCellSelectionStyleNone;
    iconCell *iconCell = [[NSBundle mainBundle] loadNibNamed:@"iconCell" owner:self options:nil][0];
    iconCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        tableView.rowHeight = 280;
        homeCell.iconImg.layer.cornerRadius = screenW/10;
        homeCell.scoreView.layer.cornerRadius = 10.0f;
        homeCell.scoreView.layer.masksToBounds = YES;
        homeCell.scoreView.layer.shadowOpacity = 0.8;
        homeCell.scoreView.layer.shadowOffset = CGSizeMake(-3, -3);
        homeCell.scoreView.layer.shadowRadius = 10.0f;
        homeCell.iconImg.layer.masksToBounds = YES;
        return homeCell;
    } else if (indexPath.row == 1 || indexPath.row == 5) {
        tableView.rowHeight = 50;
        if (indexPath.row == 5) {
            [titleCell.titleName setTitle:@"应用中心" forState:UIControlStateNormal];
            [titleCell.titleName setImage:[UIImage imageNamed:@"yyzx"] forState:UIControlStateNormal];
        }
        NSMutableAttributedString * attributeStr = [[NSMutableAttributedString alloc] initWithString:titleCell.titleName.titleLabel.text];
        [attributeStr addAttribute:NSObliquenessAttributeName value:@(0.3) range:NSMakeRange(0, 4)];
        titleCell.titleName.titleLabel.attributedText = attributeStr;
        return titleCell;
    } else if (indexPath.row == 2) {
        newCell.myNewsImg.image = [UIImage imageNamed:@"03"];
        newCell.myType.text = @"置业安家";
        tableView.rowHeight = 90;
        return newCell;
    } else if (indexPath.row == 3) {
        newCell.myNewsImg.image = [UIImage imageNamed:@"04"];
        newCell.myType.text = @"新房首发";
        tableView.rowHeight = 90;
        return newCell;
    } else if (indexPath.row == 4) {
        newCell.myNewsImg.image = [UIImage imageNamed:@"05"];
        newCell.myType.text = @"精品租房";
        tableView.rowHeight = 90;
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
    } else if (tag == 1) {
        foreSigninController *signin = [[foreSigninController alloc] init];
        [self.navigationController pushViewController:signin animated:YES];
    } else {
        ZHPickView *pickView = [[ZHPickView alloc] init];
//        [pickView setDataViewWithItem:@[@"item1",@"item2",@"item3"] title:@"DataTitle"];
        [pickView setDateViewWithTitle:@"Date"];
        [pickView showPickView:self];
        pickView.block = ^(NSString *selectedStr)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You have chooseed:" message:selectedStr delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        };
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat min = 0;
    CGFloat max = 64;
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = (offset - min) / (max - min);
    barImageView.alpha = alpha;
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
