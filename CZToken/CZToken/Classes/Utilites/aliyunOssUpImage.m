//
//  aliyunOssUpImage.m
//  CZToken
//
//  Created by jlc on 2018/3/10.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "aliyunOssUpImage.h"

@implementation aliyunOssUpImage
// 需要的信息
//static NSString *const AccessKey = @"";
//static NSString *const SecretKey = @"";
static NSString *const BucketName = @"chengzhi-oss";
static NSString *const AliyunHost = @"http://oss-cn-shanghai.aliyuncs.com";
static NSString *KTempFolder  = @"Member/IdentityImage";

+ (void)asyncUploadImage:(UIImage *)image complete:(void (^)(NSArray<NSString *> *, UploadImageState))complete {
    [self uploadImages:@[image] isAsync:YES complete:complete];
}

+ (void)syncUploadImage:(UIImage *)image complete:(void (^)(NSArray<NSString *> *, UploadImageState))complete {
    [self uploadImages:@[image] isAsync:NO complete:complete];
}

+ (void)asyncUploadImages:(NSArray<UIImage *> *)images complete:(void (^)(NSArray<NSString *> *, UploadImageState))complete {
    [self uploadImages:images isAsync:YES complete:complete];
}

+ (void)syncUploadImages:(NSArray<UIImage *> *)images complete:(void (^)(NSArray<NSString *> *, UploadImageState))complete {
    [self uploadImages:images isAsync:NO complete:complete];
}

+ (void)uploadImages:(NSArray<UIImage *> *)images isAsync:(BOOL)isAsync complete:(void(^)(NSArray<NSString *> *names, UploadImageState state))complete {
    id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKey secretKey:SecretKey];
    
    OSSClient *client = [[OSSClient alloc] initWithEndpoint:AliyunHost credentialProvider:credential];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = images.count;
    
    NSMutableArray *callBackNames = [NSMutableArray array];
    int i = 0;
    for (UIImage *image in images) {
        if (image) {
            NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
                //任务执行
                OSSPutObjectRequest *put = [OSSPutObjectRequest new];
                put.bucketName = BucketName;
                
                // 文件路径名称
                
                NSString* date;
                NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
                [formatter setDateFormat:@"mmssSSS"];
                date = [formatter stringFromDate:[NSDate date]];
                
                NSString *imageName = [KTempFolder stringByAppendingPathComponent:[[NSUUID UUID].UUIDString stringByAppendingString:[NSString stringWithFormat:@"_IMG%@",date]]];
                imageName = [imageName stringByAppendingString:@".jpg"];
                put.objectKey = imageName;
                put.contentType = @"image/jpeg";
                
                [callBackNames addObject:imageName];
                
                // 上传
                NSData *data = UIImageJPEGRepresentation(image, 0.3);
                put.uploadingData = data;
                
                // 阻塞直到上传完成
                OSSTask *putTask = [client putObject:put];
                [putTask waitUntilFinished];
                if (!putTask.error
                    ) {
                    NSLog(@"upload object success!");
                } else {
                    NSLog(@"upload object failed , error: %@",putTask.error);
                }
                if (isAsync) {
                    if (image == images.lastObject) {
                        NSLog(@"upload object finished!");
                        if (complete) {
                            complete([NSArray arrayWithArray:callBackNames], UploadImageSuccess);
                        }
                    }
                }
            }];
            if (queue.operations.count != 0) {
                [operation addDependency:queue.operations.lastObject];
            }
            [queue addOperation:operation];
        }
        i++;
    }
    if (!isAsync) {
        [queue waitUntilAllOperationsAreFinished];
        NSLog(@"haha");
        if (complete) {
            complete([NSArray arrayWithArray:callBackNames], UploadImageSuccess);
        }
    }
}

/**
 *  返回当前时间
 *
 *  @return 
 */
- (NSString *)getTimeNow
{
    NSString* date;
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYYMMddhhmmssSSS"];
    date = [formatter stringFromDate:[NSDate date]];
    //取出个随机数
    int last = arc4random() % 10000;
    NSString *timeNow = [[NSString alloc] initWithFormat:@"%@-%i", date,last];
    NSLog(@"%@", timeNow);
    return timeNow;
}

@end
