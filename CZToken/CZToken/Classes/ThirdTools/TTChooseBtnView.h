//
//  TTChooseBtnView.h
//  MeiToken
//
//  Created by Doracool on 2018/1/26.
//  Copyright © 2018年 Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, UploadImage) {
    UploadImageFaile = 0,
    UploadImageSucces = 1
};
@protocol TTTagsDelegate <NSObject>
@optional
- (void)chooseTagsArr:(NSMutableArray *)chooseArr;
@end

@interface TTChooseBtnView : UIView
@property (assign, nonatomic) id<TTTagsDelegate> delegate;
- (id)initWithFrame:(CGRect)frame andTags:(NSArray *)tags andTitleColor:(UIColor *)color andFonts:(CGFloat)font;

- (id)initWithFrame:(CGRect)frame andTags:(NSArray *)tags andTitleColor:(UIColor *)color andFonts:(CGFloat)font complete:(void(^)(NSArray<NSString *> *title))complete;

- (id)initWithFrame:(CGRect)frame andTags:(NSArray *)tags andTitleColor:(UIColor *)color andFonts:(CGFloat)font withFixed:(NSString *)fix;


- (id)initWithFrame:(CGRect)frame andTags:(NSArray *)tags andTitleColor:(UIColor *)color andborderColor:(UIColor *)borderColor andFonts:(CGFloat)font;

+ (void)chooseTags:(UIImage *)image complete:(void(^)(NSArray<NSString *> *names,UploadImage state))complete;

- (void)setPressedHandler:(void (^)(NSUInteger))handler;

@end
