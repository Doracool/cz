//
//  SignController.m
//  CZToken
//
//  Created by jlc on 2018/2/28.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "SignController.h"
#import "jjrViewController.h"
#import "rzyzViewController.h"
#import "rzshViewController.h"
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self tabbarHidden];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self tabbarShow];
}

- (IBAction)changeType:(UIButton *)sender {
    if (sender.tag == 0) {
        jjrViewController *jjr = [[jjrViewController alloc] init];
        [self.navigationController pushViewController:jjr animated:YES];
    } else if (sender.tag == 1) {
        rzyzViewController *rzyz = [[rzyzViewController alloc] init];
        [self.navigationController pushViewController:rzyz animated:YES];
    } else if (sender.tag == 2) {
        rzshViewController *rzsh = [[rzshViewController alloc] init];
        [self.navigationController pushViewController:rzsh animated:YES];
    }
    
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
