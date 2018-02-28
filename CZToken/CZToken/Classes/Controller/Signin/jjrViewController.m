//
//  jjrViewController.m
//  CZToken
//
//  Created by jlc on 2018/2/28.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "jjrViewController.h"

@interface jjrViewController ()

@property (strong, nonatomic) IBOutlet UISegmentedControl *mySegment;
@property (strong, nonatomic) IBOutlet UIView *titleView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *titleViewHeight;
@property (strong, nonatomic) IBOutlet UIButton *IdCardBtn;
@property (strong, nonatomic) IBOutlet UIButton *UpAction;
@end

@implementation jjrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBaseInfo];
    // Do any additional setup after loading the view from its nib.
}

- (void)setBaseInfo {
    [_mySegment addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventValueChanged];
}

- (void)changeView:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 1) {
        _titleViewHeight.constant = 0;
        _titleView.hidden = YES;
    } else {
        _titleViewHeight.constant = 90;
        _titleView.hidden = NO;
    }
}
- (IBAction)UpActionClick:(UIButton *)sender {
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
