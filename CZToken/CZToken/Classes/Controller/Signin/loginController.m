//
//  loginController.m
//  CZToken
//
//  Created by 周帅杰 on 2018/2/28.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "loginController.h"

@interface loginController ()

@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;
@end

@implementation loginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)loginAction:(UIButton *)sender {
    NSString *URL = [NSString stringWithFormat:@"%@/Login/Login",BaseUrl];
    NSDictionary *params = @{@"LoginId":_userName.text,@"Password":_password.text,@"Source":@"ios"};
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        [[NSUserDefaults standardUserDefaults] setObject:[[dic objectForKey:@"Data"] objectForKey:@"AccessToken"] forKey:@"token"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
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
