//
//  writeLogController.m
//  CZToken
//
//  Created by jlc on 2018/3/2.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "writeLogController.h"

@interface writeLogController ()

@property (strong, nonatomic) IBOutlet UITextView *content;
@end

@implementation writeLogController

- (void)viewDidLoad {
    [super viewDidLoad];
    _content.layer.cornerRadius = 5.0f;
    _content.layer.borderWidth = 1.0f;
    _content.layer.borderColor = [UIColor lineColor].CGColor;
    _content.layer.masksToBounds = YES;
    // Do any additional setup after loading the view from its nib.
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
