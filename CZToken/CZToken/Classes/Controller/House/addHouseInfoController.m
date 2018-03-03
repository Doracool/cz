//
//  addHouseInfoController.m
//  CZToken
//
//  Created by jlc on 2018/3/3.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "addHouseInfoController.h"
#import "addHouseDetailsController.h"
@interface addHouseInfoController ()

@end

@implementation addHouseInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DVSwitch *typeOne = [[DVSwitch alloc] initWithStringsArray:@[@"住宅",@"商铺",@"办公楼"]];
    [_wylxView addSubview:typeOne];
    typeOne.frame = CGRectMake(0, 0, _wylxView.width+30, _wylxView.height);
    
    DVSwitch *typeTwo = [[DVSwitch alloc] initWithStringsArray:@[@"租",@"售"]];
    typeTwo.frame = CGRectMake(0, 0, _jylxView.width+30, _jylxView.height);
    [_jylxView addSubview:typeTwo];
    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)addDetails:(UIButton *)sender {
    addHouseDetailsController *detais = [[addHouseDetailsController alloc] init];
    [self.navigationController pushViewController:detais animated:YES];
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
