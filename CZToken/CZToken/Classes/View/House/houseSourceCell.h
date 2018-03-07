//
//  houseSourceCell.h
//  CZToken
//
//  Created by 周帅杰 on 2018/3/1.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface houseSourceCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *iconImg;
@property (strong, nonatomic) IBOutlet UIImageView *typeImg;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *addressDetail;
@property (strong, nonatomic) IBOutlet UILabel *daxiao;
@property (strong, nonatomic) IBOutlet UILabel *mianji;
@property (strong, nonatomic) IBOutlet UIView *typeView;
@property (strong, nonatomic) IBOutlet UIButton *chatBtn;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *jinjia;
@property (strong, nonatomic) IBOutlet UIButton *star;
@end
