//
//  writeLogController.m
//  CZToken
//
//  Created by jlc on 2018/3/2.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "writeLogController.h"

@interface writeLogController ()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *typeText;
@property (strong, nonatomic) IBOutlet UITextView *content;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@end

@implementation writeLogController

- (void)viewDidLoad {
    [super viewDidLoad];
    _typeText.delegate = self;
    _content.layer.cornerRadius = 5.0f;
    _content.layer.borderWidth = 1.0f;
    _content.layer.borderColor = [UIColor lineColor].CGColor;
    _content.layer.masksToBounds = YES;
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
    [_typeText resignFirstResponder];
    ZHPickView *pickView = [[ZHPickView alloc] init];
    [pickView setDataViewWithItem:@[@"去电",@"来电",@"看房",@"勘察",@"来访",@"拜访",@"派单",@"短信",@"邮件",@"信函",@"申请",@"修改",@"保留",@"其他",@"转房客",@"未接通",@"带看",@"激活"] title:@"跟进方式"];
    [pickView showPickView:self];
    pickView.block = ^(NSString *selectedStr)
    {
        _typeText.text = selectedStr;
    };
}

- (IBAction)saveLogAction:(UIButton *)sender {
    
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
