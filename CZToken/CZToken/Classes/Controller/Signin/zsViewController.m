//
//  zsViewController.m
//  CZToken
//
//  Created by jlc on 2018/2/28.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "zsViewController.h"
#import "SignController.h"
@interface zsViewController ()<TZImagePickerControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>{
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
    NSString *imagePath;
}
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *userCode;
@property (strong, nonatomic) IBOutlet UIImageView *touxiang;
@property (strong, nonatomic) IBOutlet UIImageView *codeImg;

@end

@implementation zsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _touxiang.layer.cornerRadius = 22.5f;
    _touxiang.layer.masksToBounds = YES;
    _touxiang.layer.borderColor = [UIColor navbackgroundColor].CGColor;
    _touxiang.layer.borderWidth = 1.0f;
    [self requestInfoPay];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self tabbarHidden];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self tabbarShow];
}

#pragma -mark 上传照片

- (void)pushImagePickerController {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    
    
#pragma mark - 四类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    
    if (9 > 1) {
        // 1.设置目前已经选中的图片数组
        imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    }
    imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
    
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
    // imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
    // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    // imagePickerVc.navigationBar.translucent = NO;
    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.allowPickingGif = NO;
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    
    // imagePickerVc.minImagesCount = 3;
    // imagePickerVc.alwaysEnableDoneBtn = YES;
    
    // imagePickerVc.minPhotoWidthSelectable = 3000;
    // imagePickerVc.minPhotoHeightSelectable = 2000;
    
    /// 5. Single selection mode, valid when maxImagesCount = 1
    /// 5. 单选模式,maxImagesCount为1时才生效
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = NO;
    imagePickerVc.needCircleCrop = NO;
    imagePickerVc.circleCropRadius = 100;
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    [_selectedPhotos removeAllObjects];
    [_selectedAssets removeAllObjects];
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    
    if (_selectedPhotos.count > 0) {
        UIImage *avatar = photos[0];
//        UIImage *waterAva = [self returnphoto:avatar];
        _touxiang.image = [UIImage imageNamed:@""];
        _touxiang.image = avatar;
        [aliyunOssUpImage asyncUploadImage:avatar complete:^(NSArray<NSString *> *names, UploadImageState state) {
            NSLog(@"%@",names);
            imagePath = [NSString stringWithFormat:@"http://chengzhi-oss.oss-cn-shanghai.aliyuncs.com/%@",names[0]];
            [self uploadTouxiang:imagePath];
        }];
        
    }
    
    
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenW, 400)];
    
    if (_selectedPhotos.count > 0) {
        
        // 加水印
        UIImage *logo = [UIImage imageNamed:@"chengzhi-watermark"];
        UIImage *img = photos[0];
        int w = img.size.width;
        int h = img.size.height;
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        
        CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4*w, colorSpace, kCGImageAlphaPremultipliedFirst);
        CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
        CGContextDrawImage(context, CGRectMake(0, 0, w, h), [logo CGImage]);
        CGImageRef imageMasked = CGBitmapContextCreateImage(context);
        CGContextRelease(context);
        CGColorSpaceRelease(colorSpace);
        UIImage *myImg = [UIImage imageWithCGImage:imageMasked];
        imgView.image = myImg;
    }
}

- (void)uploadTouxiang:(NSString *)imgStr {
    NSDictionary *params = @{@"Image":imgStr,@"Token":TOKEN,@"Source":@"ios"};
    NSString *URL = [NSString stringWithFormat:@"%@/Passport/Register/SetHeadImage",BaseUrl];
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        if ([dic intValueForKey:@"Code"] == 0) {
            NSLog(@"%@",[dic objectForKey:@"Data"]);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)requestInfoPay {
    NSString *URL = [NSString stringWithFormat:@"%@/Passport/Register/GetCertificateData",BaseUrl];
    NSDictionary *params = @{@"Token":TOKEN,@"Source":@"ios"};
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        if ([dic intValueForKey:@"Code"] == 0) {
            [_touxiang sd_setImageWithURL:[NSURL URLWithString:[[dic objectForKey:@"Data"] objectForKey:@"HeadImage"]]];
            _name.text = [[dic objectForKey:@"Data"] objectForKey:@"Name"];
            _timeLabel.text = [[dic objectForKey:@"Data"] objectForKey:@"Time"];
            [_codeImg sd_setImageWithURL:[NSURL URLWithString:[[dic objectForKey:@"Data"] objectForKey:@"QRCode"]]];
            _userCode.text = [[dic objectForKey:@"Data"] objectForKey:@"SN"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (IBAction)upLoadImage:(UIButton *)sender {
    [self pushImagePickerController];
}

- (IBAction)SignAction:(UIButton *)sender {
    
    
    
    SignController *sign = [[SignController alloc] init];
    [self.navigationController pushViewController:sign animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
