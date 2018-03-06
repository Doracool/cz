//
//  XgViewController.m
//  CZToken
//
//  Created by jlc on 2018/2/26.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "XgViewController.h"
#import "XgShareViewController.h"
@interface XgViewController ()

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@property (strong, nonatomic) IBOutlet TTChooseBtnView *tipsView;
@end

@implementation XgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tabbarHidden];
    NSArray *tips = @[@"上海单身",@"上海家庭一方上海户口",@"上海家庭双方上海户口",@"外地人",@"在读博士或以上高学历",@"父母外地未成年子女",@"驻沪军官",@"港澳同胞",@"台湾同胞",@"外籍人士"];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    [arr addObjectsFromArray:tips];
    TTChooseBtnView *view = [[TTChooseBtnView alloc] initWithFrame:CGRectMake(12, 10, screenW-24, 50) andTags:tips andTitleColor:[UIColor lineColor] andFonts:13];
    _viewHeight.constant = view.frame.size.height + 10;
    [_tipsView addSubview:view];
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

- (IBAction)calculateAction:(UIButton *)sender {
    XgShareViewController *share = [[XgShareViewController alloc] init];
    [self.navigationController pushViewController:share animated:YES];
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
