//
//  ComputerController.m
//  CZToken
//
//  Created by jlc on 2018/3/14.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "ComputerController.h"
#import "calculateController.h"
@interface ComputerController ()
@property (strong, nonatomic) IBOutlet UILabel *ads;

@end

@implementation ComputerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)myAction:(UIButton *)sender {
    calculateController *calcu = [[calculateController alloc] init];
    [self.navigationController pushViewController:calcu animated:YES];
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
