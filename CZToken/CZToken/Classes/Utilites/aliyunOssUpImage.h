//
//  aliyunOssUpImage.h
//  CZToken
//
//  Created by jlc on 2018/3/10.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UploadImageState) {
    UploadImageFailed = 0,
    UploadImageSuccess = 1
};

@interface aliyunOssUpImage : NSObject
+ (void)asyncUploadImage:(UIImage *)image complete:(void(^)(NSArray<NSString *> *names,UploadImageState state))complete;

+ (void)syncUploadImage:(UIImage *)image complete:(void(^)(NSArray<NSString *> *names, UploadImageState state))complete;

+ (void)asyncUploadImages:(NSArray<UIImage *> *)images complete:(void(^)(NSArray<NSString *> *names, UploadImageState state))complete;

+ (void)syncUploadImages:(NSArray<UIImage *> *)images complete:(void(^)(NSArray<NSString *> *names, UploadImageState state))complete;

@end
