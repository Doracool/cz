//
//  houseDetaiseCellOne.h
//  CZToken
//
//  Created by jlc on 2018/3/5.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface houseDetaiseCellOne : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIImageView *typeImg;
@property (strong, nonatomic) IBOutlet UILabel *xiaoqu;
@property (strong, nonatomic) IBOutlet UILabel *renzheng;
@property (strong, nonatomic) IBOutlet UIView *typeView;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *liulan;
@property (strong, nonatomic) IBOutlet UIButton *star;
@property (strong, nonatomic) IBOutlet UIButton *follow;
@end
