//
//  NewsViewCell.h
//  CZToken
//
//  Created by jlc on 2018/2/26.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *myNewsImg;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *myDetails;
@property (strong, nonatomic) IBOutlet UILabel *myType;
@end
