//
//  addHouseDetailsController.m
//  CZToken
//
//  Created by jlc on 2018/3/3.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "addHouseDetailsController.h"

@interface addHouseDetailsController ()
@property (strong, nonatomic) IBOutlet UIView *cqView;
@property (strong, nonatomic) IBOutlet UIView *wyView;
@property (strong, nonatomic) IBOutlet UIView *jzView;
@property (strong, nonatomic) IBOutlet UIView *qzView;

@end

@implementation addHouseDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat myWidth = _cqView.width + 35;
    DVSwitch *typeOne = [[DVSwitch alloc] initWithStringsArray:@[@"不满二",@"二到五",@"满五"]];
    [_cqView addSubview:typeOne];
    typeOne.frame = CGRectMake(0, 0, myWidth, _cqView.height);
    
    DVSwitch *typeTwo = [[DVSwitch alloc] initWithStringsArray:@[@"是",@"否"]];
    [_wyView addSubview:typeTwo];
    typeTwo.frame = CGRectMake(0, 0, myWidth, _cqView.height);
    
    DVSwitch *typeThree = [[DVSwitch alloc] initWithStringsArray:@[@"钥匙房",@"预约"]];
    [_jzView addSubview:typeThree];
    typeThree.frame = CGRectMake(0, 0, myWidth, _cqView.height);
    
    DVSwitch *typeFour = [[DVSwitch alloc] initWithStringsArray:@[@"是",@"否"]];
    [_qzView addSubview:typeFour];
    typeFour.frame = CGRectMake(0, 0, myWidth, _cqView.height);
    
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
