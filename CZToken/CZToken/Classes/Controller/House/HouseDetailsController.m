//
//  HouseDetailsController.m
//  CZToken
//
//  Created by 周帅杰 on 2018/3/1.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "HouseDetailsController.h"
#import "lookOwnerController.h"
@interface HouseDetailsController ()

@end

@implementation HouseDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)lookOwner:(UIButton *)sender {
    lookOwnerController *owner = [[lookOwnerController alloc] init];
    [self.navigationController pushViewController:owner animated:YES];
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
