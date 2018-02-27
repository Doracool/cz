//
//  TTChooseBtnView.h
//  MeiToken
//
//  Created by Doracool on 2018/1/26.
//  Copyright © 2018年 Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TTTagsDelegate <NSObject>
@optional
- (void)chooseTagsArr:(NSMutableArray *)chooseArr;
@end

@interface TTChooseBtnView : UIView
@property (assign, nonatomic) id<TTTagsDelegate> delegate;
- (id)initWithFrame:(CGRect)frame andTags:(NSArray *)tags andTitleColor:(UIColor *)color andFonts:(CGFloat)font;

@end
