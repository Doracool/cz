//
//  refundMoneyController.m
//  CZToken
//
//  Created by jlc on 2018/3/6.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "refundMoneyController.h"

@interface refundMoneyController ()

@property (strong, nonatomic) IBOutlet UIImageView *houseImg;
@property (strong, nonatomic) IBOutlet UILabel *addressOne;
@property (strong, nonatomic) IBOutlet UILabel *addressTwo;
@property (strong, nonatomic) IBOutlet UILabel *addressThree;
@property (strong, nonatomic) IBOutlet UILabel *houseCode;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *mianji;
@property (strong, nonatomic) IBOutlet UILabel *type;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UITextField *resonText;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UITextView *content;
@end

@implementation refundMoneyController

- (void)viewDidLoad {
    [super viewDidLoad];
    _houseImg.image = [UIImage imageNamed:@"01"];
    _content.layer.cornerRadius = 5.0f;
    _content.layer.borderColor = [UIColor lineColor].CGColor;
    _content.layer.borderWidth = 1.0f;
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

- (void)textViewDidChange:(UITextView *)textView {
    if (_content.text.length == 0) {
        [_contentLabel setHidden:NO];
    } else {
        [_contentLabel setHidden:YES];
    }
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [_resonText resignFirstResponder];
    ZHPickView *pickView = [[ZHPickView alloc] init];
    [pickView setDataViewWithItem:@[@"业主联系方式不正确",@"没人接电话",@"看房",@"勘察",@"来访",@"拜访",@"派单",@"短信",@"邮件",@"信函",@"申请",@"修改",@"保留",@"其他",@"转房客",@"未接通",@"带看",@"激活"] title:@"跟进方式"];
    [pickView showPickView:self];
    pickView.block = ^(NSString *selectedStr)
    {
        _resonText.text = selectedStr;
    };
}

- (IBAction)saveAction:(UIButton *)sender {
    
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
