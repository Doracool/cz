//
//  houseDetailsInfoCell.h
//  CZToken
//
//  Created by jlc on 2018/3/5.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface houseDetailsInfoCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *iconImg;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *company;
@property (strong, nonatomic) IBOutlet UILabel *sxd;
@property (strong, nonatomic) IBOutlet UILabel *cxz;
@property (strong, nonatomic) IBOutlet UILabel *zyz;
@property (strong, nonatomic) IBOutlet UIButton *lxtBtn;
@property (strong, nonatomic) IBOutlet UIButton *dhtBtn;
@end
