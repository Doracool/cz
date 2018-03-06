//
//  houseImgCell.h
//  CZToken
//
//  Created by jlc on 2018/3/6.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface houseImgCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *myText;
@property (strong, nonatomic) IBOutlet UIView *myImgView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imgHeight;
@end
