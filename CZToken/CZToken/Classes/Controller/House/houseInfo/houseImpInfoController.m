//
//  houseImpInfoController.m
//  CZToken
//
//  Created by 周帅杰 on 2018/3/5.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "houseImpInfoController.h"
#import "houseImgController.h"
@interface houseImpInfoController ()

@end

@implementation houseImpInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self tabbarShow];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self tabbarHidden];
}
- (IBAction)beforeAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)nextAction:(UIButton *)sender {
    houseImgController *img = [[houseImgController alloc] init];
    [self.navigationController pushViewController:img animated:YES];
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
