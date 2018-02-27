//
//  TTChooseBtnView.m
//  MeiToken
//
//  Created by Doracool on 2018/1/26.
//  Copyright © 2018年 Feng. All rights reserved.
//

#import "TTChooseBtnView.h"

@interface TTChooseBtnView ()
{
    CGFloat Left;
    CGFloat widthSpace;
    CGFloat Top;
    CGFloat heightSpace;
}
@property (nonatomic, strong) UIView *tagsView;
@property (nonatomic, strong) UIColor *titlesColor;
@property (nonatomic, strong) NSMutableArray *chooseTagsArr;
@end

@implementation TTChooseBtnView

- (id)initWithFrame:(CGRect)frame andTags:(NSArray *)tags andTitleColor:(UIColor *)color andFonts:(CGFloat)font {
    Left = 0;
    widthSpace = 10;
    Top = 0;
    heightSpace = 25;
    _chooseTagsArr = [NSMutableArray arrayWithCapacity:0];
    self = [super initWithFrame:frame];
    _tagsView = [[UIView alloc] initWithFrame:frame];
    for (NSInteger i = 0; i < tags.count; i++) {
        NSString *contentText = tags[i];
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
        CGSize size = [contentText boundingRectWithSize:CGSizeMake(frame.size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        if (kScreenWidth - 32 - Left < size.width) {
            Left = 0;
            Top = Top + heightSpace + 10;
        }
        UIButton *tags = [[UIButton alloc] initWithFrame:CGRectMake(Left, Top, size.width + 15, heightSpace)];
        [self addSubview:tags];
        _titlesColor = color;
        tags.titleLabel.font = [UIFont systemFontOfSize:font];
        [tags setTitle:contentText forState:UIControlStateNormal];
        [tags setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        tags.layer.borderColor = color.CGColor;
        tags.layer.borderWidth = 1.0f;
        tags.layer.cornerRadius = 8.0f;
        tags.layer.masksToBounds = YES;
        tags.tag = i;
        [tags addTarget:self action:@selector(chooseTags:) forControlEvents:UIControlEventTouchUpInside];
        Left = Left + size.width + 15 + widthSpace;
    }
    self.height = Top + heightSpace + 10;
    return self;
}

- (void)chooseTags:(UIButton *)sender {
    if (![_chooseTagsArr containsObject:[NSString stringWithFormat:@"%ld",sender.tag]]) {
        [sender setBackgroundColor:[UIColor redColor]];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_chooseTagsArr addObject:[NSString stringWithFormat:@"%ld",sender.tag]];
    } else {
        [_chooseTagsArr removeObject:[NSString stringWithFormat:@"%ld",sender.tag]];
        [sender setBackgroundColor:[UIColor whiteColor]];
        [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [self.delegate chooseTagsArr:_chooseTagsArr];
}

@end