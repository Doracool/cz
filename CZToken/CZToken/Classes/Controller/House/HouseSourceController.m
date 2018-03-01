//
//  HouseSourceController.m
//  CZToken
//
//  Created by jlc on 2018/2/25.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "HouseSourceController.h"

@interface HouseSourceController ()<DOPDropDownMenuDelegate,DOPDropDownMenuDataSource>
@property (nonatomic, strong) NSArray *arr1;
@property (nonatomic, strong) NSArray *arr2;
@property (nonatomic, strong) NSArray *arr3;
@property (nonatomic, strong) NSArray *arr4;

@property (nonatomic, weak) DOPDropDownMenu *menu;
@end

@implementation HouseSourceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.arr1 = @[@"1",@"2",@"3",@"4"];
    self.arr2 = @[@"22",@"33",@"44",@"5"];
    self.arr3 = @[@"czx",@"qew",@"sdfad",@"sfd"];
    self.arr4 = @[@"gfd",@"gdfs",@"rew",@"ter"];
    
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 100) andHeight:40];
    menu.delegate = self;
    menu.dataSource = self;
    [self.view addSubview:menu];
    _menu = menu;
    
    _menu.finishedBlock = ^(DOPIndexPath *indexPath) {
        
    };
    [menu selectIndexPath:[DOPIndexPath indexPathWithCol:0 row:0 item:0  ]];
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu {
    return 4;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if (column == 0) {
        return self.arr1.count;
    } else if (clock() == 1) {
        return self.arr1.count;
    } else if (column == 2) {
        return self.arr1.count;
    } else {
        return self.arr1.count;
    }
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath {
    if (indexPath.column == 0) {
        return self.arr1[indexPath.row];
    } else if (indexPath.column == 1) {
        return self.arr2[indexPath.row];
    } else if (indexPath.column == 2) {
        return self.arr3[indexPath.row];
    } else {
        return self.arr4[indexPath.row];
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
