//
//  iconCell.m
//  CZToken
//
//  Created by jlc on 2018/2/26.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "iconCell.h"

@implementation iconCell

- (void)awakeFromNib {
    [super awakeFromNib];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    CGSize size = [_icon.titleLabel.text boundingRectWithSize:CGSizeMake(kScreenWidth, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    CGSize size1 = [_icon9.titleLabel.text boundingRectWithSize:CGSizeMake(kScreenWidth, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    [_icon setImageEdgeInsets:UIEdgeInsetsMake(-size.height, size.width/2, size.height, -size.width/2)];
    [_icon setTitleEdgeInsets:UIEdgeInsetsMake(15, -size.width/3, -15, size.width/3)];
    [_icon1 setImageEdgeInsets:UIEdgeInsetsMake(-size.height, size.width/2, size.height, -size.width/2)];
    [_icon1 setTitleEdgeInsets:UIEdgeInsetsMake(15, -size.width/3-3, -15, size.width/3)];
    [_icon2 setImageEdgeInsets:UIEdgeInsetsMake(-size.height, size.width/2, size.height, -size.width/2)];
    [_icon2 setTitleEdgeInsets:UIEdgeInsetsMake(15, -size.width/3-5, -15, size.width/3)];
    [_icon3 setImageEdgeInsets:UIEdgeInsetsMake(-size.height, size.width/2, size.height, -size.width/2)];
    [_icon3 setTitleEdgeInsets:UIEdgeInsetsMake(15, -size.width/3, -15, size.width/3)];
    [_icon4 setImageEdgeInsets:UIEdgeInsetsMake(-size.height, size.width/2, size.height, -size.width/2)];
    [_icon4 setTitleEdgeInsets:UIEdgeInsetsMake(15, -size.width/3, -15, size.width/3)];
    [_icon5 setImageEdgeInsets:UIEdgeInsetsMake(-size.height, size.width/2, size.height, -size.width/2)];
    [_icon5 setTitleEdgeInsets:UIEdgeInsetsMake(15, -size.width/3-9, -15, size.width/3)];
    [_icon6 setImageEdgeInsets:UIEdgeInsetsMake(-size.height, size.width/2, size.height, -size.width/2)];
    [_icon6 setTitleEdgeInsets:UIEdgeInsetsMake(15, -size.width/3, -15, size.width/3)];
    [_icon7 setImageEdgeInsets:UIEdgeInsetsMake(-size1.height, size1.width/3, size1.height, -size1.width/3)];
    [_icon7 setTitleEdgeInsets:UIEdgeInsetsMake(15, -size1.width/3, -15, size1.width/3)];
    [_icon8 setImageEdgeInsets:UIEdgeInsetsMake(-size1.height, size1.width/3, size1.height, -size1.width/3)];
    [_icon8 setTitleEdgeInsets:UIEdgeInsetsMake(15, -size1.width/3, -15, size1.width/3)];
    [_icon9 setImageEdgeInsets:UIEdgeInsetsMake(-size1.height-5, size1.width/3, size1.height+5, -size1.width/3)];
    [_icon9 setTitleEdgeInsets:UIEdgeInsetsMake(15, -size1.width/3, -15, size1.width/3)];
    // Initialization code
}
- (IBAction)iconClick:(UIButton *)sender {
    NSString *tag = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    NSDictionary *dic = @{@"tag":tag};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"icon" object:nil userInfo:dic];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
