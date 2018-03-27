//
//  loadWebView.h
//  SYZXFamily
//
//  Created by jlc on 2017/4/21.
//  Copyright © 2017年 NYHZ. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class activeCenterDataModel;
//@class volunteerDataModel;

@interface loadWebView : BaseViewController
@property (nonatomic, strong) NSURL *Url;
//@property (nonatomic, strong) activeCenterDataModel *actModel;
//@property (nonatomic, strong) volunteerDataModel *volModel;
@property (nonatomic, copy) NSString *BEGINTIME;
@property (nonatomic, copy) NSString *ENDTIME;
@property (nonatomic, copy) NSString *HTMLSTR;
//+ (void)showWithContro:(UIViewController *)contro withUrl:(NSString *)urlStr WithTitle:(NSString *)title WithID:(NSString *)activeId WithModel:(activeCenterDataModel *)activeModel withvolunteerModel:(volunteerDataModel *)model;
+ (void)showWithContro:(UIViewController *)contro withUrl:(NSString *)urlStr WithTitle:(NSString *)title;
@end
