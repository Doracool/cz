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
    NSInteger count;
}
@property (nonatomic, strong) UIView *tagsView;
@property (nonatomic, strong) UIColor *titlesColor;
@property (nonatomic, strong) NSMutableArray *chooseTagsArr;
@property (strong, nonatomic) void (^handlerBlock)(NSUInteger index);
@end

@implementation TTChooseBtnView

- (id)initWithFrame:(CGRect)frame andTags:(NSArray *)tags andTitleColor:(UIColor *)color andFonts:(CGFloat)font {
    Left = 0;
    widthSpace = 10;
    Top = 0;
    heightSpace = 25;
    count = tags.count;
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

- (id)initWithFrame:(CGRect)frame andTags:(NSArray *)tags andTitleColor:(UIColor *)color andFonts:(CGFloat)font withFixed:(NSString *)fix {
    Left = 0;
    widthSpace = 10;
    Top = 0;
    heightSpace = 30;
    count = tags.count;
    _chooseTagsArr = [NSMutableArray arrayWithCapacity:0];
    self = [super initWithFrame:frame];
    _tagsView = [[UIView alloc] initWithFrame:frame];
    for (NSInteger i = 0; i < tags.count; i++) {
        NSString *contentText = tags[i];
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
        CGSize size = [contentText boundingRectWithSize:CGSizeMake(frame.size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        if (kScreenWidth - 32 - Left < screenW/5) {
            Left = 0;
            Top = Top + heightSpace + 10;
        }
        UIButton *tags = [[UIButton alloc] initWithFrame:CGRectMake(Left, Top, screenW/5, heightSpace)];
        [self addSubview:tags];
        _titlesColor = color;
        tags.titleLabel.font = [UIFont systemFontOfSize:font];
        [tags setTitle:contentText forState:UIControlStateNormal];
        [tags setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        tags.layer.borderColor = color.CGColor;
        tags.layer.borderWidth = 1.0f;
        tags.layer.cornerRadius = 2.0f;
        tags.layer.masksToBounds = YES;
        tags.tag = i;
        [tags addTarget:self action:@selector(chooseTags:) forControlEvents:UIControlEventTouchUpInside];
        Left = Left + screenW/5 + widthSpace;
    }
    self.height = Top + heightSpace + 10;
    return self;
}


- (id)initWithFrame:(CGRect)frame andTags:(NSArray *)tags andTitleColor:(UIColor *)color andborderColor:(UIColor *)borderColor andFonts:(CGFloat)font {
    Left = 0;
    widthSpace = 10;
    Top = 0;
    heightSpace = 20;
    count = tags.count;
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
        UIButton *tags = [[UIButton alloc] initWithFrame:CGRectMake(Left, Top, size.width +5, heightSpace)];
        [self addSubview:tags];
        _titlesColor = color;
        tags.titleLabel.font = [UIFont systemFontOfSize:font];
        [tags setTitle:contentText forState:UIControlStateNormal];
        [tags setTitleColor:_titlesColor forState:UIControlStateNormal];
        tags.layer.borderColor = borderColor.CGColor;
        tags.layer.borderWidth = 1.0f;
        tags.layer.cornerRadius = 2.0f;
        tags.layer.masksToBounds = YES;
        Left = Left + size.width + 5 + widthSpace;
    }
    self.height = Top + heightSpace + 10;
    return self;
}

- (void)setPressedHandler:(void (^)(NSUInteger))handler {
    self.handlerBlock = handler;
}

+ (void)chooseTags:(UIImage *)image complete:(void(^)(NSArray<NSString *> *names,UploadImage state))complete {
    NSMutableArray *callBackNames = [NSMutableArray array];
    [callBackNames addObject:@"3"];
    complete([NSArray arrayWithArray:callBackNames], UploadImageSucces);
}

- (void)chooseTags:(UIButton *)sender {
    // 单选
    [_chooseTagsArr removeAllObjects];
    for (NSInteger i = 0 ; i < count ; i++) {
        if (sender.tag == i) {
            NSNumber *tagNum = [NSNumber numberWithInteger:i];
            [_chooseTagsArr addObject:tagNum];
            [sender setBackgroundColor:[UIColor redColor]];
            [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.delegate chooseTagsArr:_chooseTagsArr];
            self.handlerBlock(i);
            continue;
        }
        UIButton *other = (UIButton *)self.subviews[i];
        
        [other setBackgroundColor:[UIColor whiteColor]];
        [other setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    
    /*
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
     */
}

@end
