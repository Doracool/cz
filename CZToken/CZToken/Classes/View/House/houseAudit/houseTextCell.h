//
//  houseTextCell.h
//  CZToken
//
//  Created by jlc on 2018/3/6.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface houseTextCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *myText;
@property (strong, nonatomic) IBOutlet UILabel *myContent;
@property (weak, nonatomic) IBOutlet UILabel *line;
@end
