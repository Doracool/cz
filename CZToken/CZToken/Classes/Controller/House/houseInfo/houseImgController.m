//
//  houseImgController.m
//  CZToken
//
//  Created by jlc on 2018/3/6.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "houseImgController.h"
#import "houseSuccController.h"
@interface houseImgController ()

@end

@implementation houseImgController

- (void)viewDidLoad {
    [super viewDidLoad];
    _beforeBtn.layer.borderWidth = 1.0f;
    _beforeBtn.layer.borderColor = [UIColor colorWithHexString:@"c9c9c9"].CGColor;
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
    houseSuccController *succ = [[houseSuccController alloc] init];
    [self.navigationController pushViewController:succ animated:YES];
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
