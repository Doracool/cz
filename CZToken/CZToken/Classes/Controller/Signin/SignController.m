//
//  SignController.m
//  CZToken
//
//  Created by jlc on 2018/2/28.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "SignController.h"
#import "jjrViewController.h"
@interface SignController ()
@property (strong, nonatomic) IBOutlet UIButton *typeOne;
@property (strong, nonatomic) IBOutlet UIButton *typeTwo;
@property (strong, nonatomic) IBOutlet UIButton *typeThree;

@end

@implementation SignController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)changeType:(UIButton *)sender {
    jjrViewController *jjr = [[jjrViewController alloc] init];
    [self.navigationController pushViewController:jjr animated:YES];
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
