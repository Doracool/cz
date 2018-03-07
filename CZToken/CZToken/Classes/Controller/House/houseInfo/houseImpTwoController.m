//
//  houseImpTwoController.m
//  CZToken
//
//  Created by jlc on 2018/3/6.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "houseImpTwoController.h"

@interface houseImpTwoController ()

@end

@implementation houseImpTwoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBaseView];
    // Do any additional setup after loading the view from its nib.
}

- (void)setBaseView {
    NSArray *tips = @[@"复式",@"带天井",@"带露台"];
    TTChooseBtnView *view = [[TTChooseBtnView alloc] initWithFrame:CGRectMake(12, 0, screenW-24, 30) andTags:tips andTitleColor:[UIColor lineColor] andFonts:13];
    [_tsView addSubview:view];
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
