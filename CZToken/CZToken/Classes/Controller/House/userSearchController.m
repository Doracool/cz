//
//  userSearchController.m
//  CZToken
//
//  Created by jlc on 2018/3/5.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "userSearchController.h"
#import "searchCell.h"
#import "affirmCell.h"
@interface userSearchController ()

@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@end

@implementation userSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        searchCell *cell = [[NSBundle mainBundle] loadNibNamed:@"searchCell" owner:self options:nil][0];
        NSArray *tips = @[@"已收藏"];
        TTChooseBtnView *view = [[TTChooseBtnView alloc] initWithFrame:CGRectMake(12, 10, screenW-10, 50) andTags:tips andTitleColor:[UIColor lineColor] andFonts:13];
        [cell.btnView addSubview:view];
        cell.contentHeight.constant = view.frame.size.height + 10;
        tableView.rowHeight = view.frame.size.height+60;
        return cell;
        
    } else if (indexPath.row == 1) {
        searchCell *cell = [[NSBundle mainBundle] loadNibNamed:@"searchCell" owner:self options:nil][0];
        NSArray *tips = @[@"一室",@"二室",@"三室",@"四室",@"五室",@"五室以上"];
        TTChooseBtnView *view = [[TTChooseBtnView alloc] initWithFrame:CGRectMake(12, 10, screenW-10, 50) andTags:tips andTitleColor:[UIColor lineColor] andFonts:13];
        [cell.btnView addSubview:view];
        cell.contentHeight.constant = view.frame.size.height + 10;
        tableView.rowHeight = view.frame.size.height+50;
        return cell;
    } else if (indexPath.row == 2) {
        searchCell *cell = [[NSBundle mainBundle] loadNibNamed:@"searchCell" owner:self options:nil][0];
        NSArray *tips = @[@"50平以下",@"50-70平",@"70-90平",@"90-110平",@"110-130平",@"130-150平",@"150平以上"];
        TTChooseBtnView *view = [[TTChooseBtnView alloc] initWithFrame:CGRectMake(12, 10, screenW-10, 50) andTags:tips andTitleColor:[UIColor lineColor] andFonts:13];
        [cell.btnView addSubview:view];
        cell.contentHeight.constant = view.frame.size.height + 10;
        tableView.rowHeight = view.frame.size.height+50;
        return cell;
    } else if (indexPath.row == 3) {
        searchCell *cell = [[NSBundle mainBundle] loadNibNamed:@"searchCell" owner:self options:nil][0];
        NSArray *tips = @[@"满五",@"满二"];
        
        TTChooseBtnView *view = [[TTChooseBtnView alloc] initWithFrame:CGRectMake(12, 10, screenW-10, 50) andTags:tips andTitleColor:[UIColor lineColor] andFonts:13];
        [cell.btnView addSubview:view];
        cell.contentHeight.constant = view.frame.size.height + 10;
        tableView.rowHeight = view.frame.size.height+50;
        return cell;
    } else if (indexPath.row == 4) {
        searchCell *cell = [[NSBundle mainBundle] loadNibNamed:@"searchCell" owner:self options:nil][0];
        NSArray *tips = @[@"地铁房",@"有电梯",@"有钥匙",@"新上"];
        
        TTChooseBtnView *view = [[TTChooseBtnView alloc] initWithFrame:CGRectMake(12, 10, screenW-10, 50) andTags:tips andTitleColor:[UIColor lineColor] andFonts:13];
        [cell.btnView addSubview:view];
        cell.contentHeight.constant = view.frame.size.height + 10;
        tableView.rowHeight = view.frame.size.height+50;
        return cell;
    } else if (indexPath.row == 5) {
        searchCell *cell = [[NSBundle mainBundle] loadNibNamed:@"searchCell" owner:self options:nil][0];
        NSArray *tips = @[@"复式",@"带阁楼",@"带露台",@"带阳光房",@"带花园",@"带天井",@"带地下室"];
        
        TTChooseBtnView *view = [[TTChooseBtnView alloc] initWithFrame:CGRectMake(12, 10, screenW-10, 50) andTags:tips andTitleColor:[UIColor lineColor] andFonts:13];
        [cell.btnView addSubview:view];
        cell.contentHeight.constant = view.frame.size.height + 10;
        tableView.rowHeight = view.frame.size.height+50;
        return cell;
    } else if (indexPath.row == 6) {
        searchCell *cell = [[NSBundle mainBundle] loadNibNamed:@"searchCell" owner:self options:nil][0];
        NSArray *tips = @[@"2年内",@"2-5年内",@"5-10年内",@"10-20年",@"20年以上"];
        
        TTChooseBtnView *view = [[TTChooseBtnView alloc] initWithFrame:CGRectMake(12, 10, screenW-10, 50) andTags:tips andTitleColor:[UIColor lineColor] andFonts:13];
        [cell.btnView addSubview:view];
        cell.contentHeight.constant = view.frame.size.height + 10;
        tableView.rowHeight = view.frame.size.height+50;
        return cell;
    } else if (indexPath.row == 7) {
        searchCell *cell = [[NSBundle mainBundle] loadNibNamed:@"searchCell" owner:self options:nil][0];
        NSArray *tips = @[@"低区",@"中区",@"高区"];
        
        TTChooseBtnView *view = [[TTChooseBtnView alloc] initWithFrame:CGRectMake(12, 10, screenW-10, 50) andTags:tips andTitleColor:[UIColor lineColor] andFonts:13];
        [cell.btnView addSubview:view];
        cell.contentHeight.constant = view.frame.size.height + 10;
        tableView.rowHeight = view.frame.size.height+50;
        return cell;
    } else if (indexPath.row == 8) {
        searchCell *cell = [[NSBundle mainBundle] loadNibNamed:@"searchCell" owner:self options:nil][0];
        NSArray *tips = @[@"住宅",@"别墅",@"其他"];
        
        TTChooseBtnView *view = [[TTChooseBtnView alloc] initWithFrame:CGRectMake(12, 10, screenW-10, 50) andTags:tips andTitleColor:[UIColor lineColor] andFonts:13];
        [cell.btnView addSubview:view];
        cell.contentHeight.constant = view.frame.size.height + 10;
        tableView.rowHeight = view.frame.size.height+50;
        return cell;
    } else if (indexPath.row == 9) {
        searchCell *cell = [[NSBundle mainBundle] loadNibNamed:@"searchCell" owner:self options:nil][0];
        NSArray *tips = @[@"内环内",@"内中环",@"中外环",@"外环外"];
        
        TTChooseBtnView *view = [[TTChooseBtnView alloc] initWithFrame:CGRectMake(12, 10, screenW-10, 50) andTags:tips andTitleColor:[UIColor lineColor] andFonts:13];
        [cell.btnView addSubview:view];
        cell.contentHeight.constant = view.frame.size.height + 10;
        tableView.rowHeight = view.frame.size.height+50;
        return cell;
    } else if (indexPath.row == 10) {
        searchCell *cell = [[NSBundle mainBundle] loadNibNamed:@"searchCell" owner:self options:nil][0];
        NSArray *tips = @[@"精装",@"豪装",@"中装",@"简装",@"毛坯"];
        
        TTChooseBtnView *view = [[TTChooseBtnView alloc] initWithFrame:CGRectMake(12, 10, screenW-10, 50) andTags:tips andTitleColor:[UIColor lineColor] andFonts:13];
        [cell.btnView addSubview:view];
        cell.contentHeight.constant = view.frame.size.height + 10;
        tableView.rowHeight = view.frame.size.height+50;
        return cell;
    } else if (indexPath.row == 11) {
        affirmCell *cell = [[NSBundle mainBundle] loadNibNamed:@"affirmCell" owner:self options:nil][0];
        tableView.rowHeight = 80;
        return cell;
    }
    return nil;
    
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
