//
//  rzshViewController.m
//  CZToken
//
//  Created by 周帅杰 on 2018/2/28.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "rzshViewController.h"
#import "loginController.h"
@interface rzshViewController ()

@end

@implementation rzshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)Action:(UIButton *)sender {
    loginController *login = [[loginController alloc] init];
    [self.navigationController pushViewController:login animated:YES];
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
