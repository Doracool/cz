//
//  OwnerInfoCell.h
//  CZToken
//
//  Created by jlc on 2018/3/2.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OwnerInfoCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *phoneNum;
@property (strong, nonatomic) IBOutlet UIButton *callbtn;
@end
