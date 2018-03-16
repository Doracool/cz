//
//  houseImgController.m
//  CZToken
//
//  Created by jlc on 2018/3/6.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "houseImgController.h"
#import "houseSuccController.h"
@interface houseImgController ()<TZImagePickerControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>{
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
    NSString *imagePath;
}
@property (nonatomic, strong) UIImagePickerController *imagePicker;

@end

@implementation houseImgController

- (void)viewDidLoad {
    [super viewDidLoad];
    _beforeBtn.layer.borderWidth = 1.0f;
    _beforeBtn.layer.borderColor = [UIColor colorWithHexString:@"c9c9c9"].CGColor;
    
    UIButton *hxBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, _hxView.height-20, _hxView.height-20)];
    [hxBtn setBackgroundColor:[UIColor redColor]];
    [hxBtn addTarget:self action:@selector(uploadImage:) forControlEvents:UIControlEventTouchUpInside];
    [hxBtn addTarget:self action:@selector(pushImagePickerController) forControlEvents:UIControlEventTouchUpInside];
    [_hxView addSubview:hxBtn];
    // Do any additional setup after loading the view from its nib.
}

- (void)uploadImage:(UIButton *)sender {
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self tabbarShow];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self tabbarHidden];
}
- (IBAction)beforeAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)nextAction:(UIButton *)sender {
    houseSuccController *succ = [[houseSuccController alloc] init];
    [self.navigationController pushViewController:succ animated:YES];
}


#pragma mark --UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) { // take photo / 去拍照
        [self takePhoto];
    } else if (buttonIndex == 1) {
        [self pushImagePickerController];
    }
}

- (void)pushImagePickerController {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:2 delegate:self];
    
    
#pragma mark - 四类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    
    if (9 > 2) {
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

-(void)addPictures:(UIButton *)sender
{
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"去相册选择", nil];
    [sheet showInView:self.view];
    NSLog(@"addPictures");
}

#pragma mark -- UIImagePickerController
- (UIImagePickerController *)imagePicker {
    if (_imagePicker == nil) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
        //改变相册选择页的导航栏
        _imagePicker.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePicker.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class],nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class],nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePicker;
}

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无相机权限 做一个友好的提示
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
        // 拍照之前还需要检查相册权限
    } else if ([TZImageManager authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        alert.tag = 1;
        [alert show];
    } else { // 调用相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePicker.sourceType = sourceType;
            if(iOS8Later) {
                _imagePicker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [self presentViewController:_imagePicker animated:YES completion:nil];
        } else {
            NSLog(@"模拟器中无法打开照相机,请在真机中使用");
        }
    }
}




- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    
    if (_selectedPhotos.count > 0) {
        UIImage *avatar = photos[0];
        UIImage *waterAva = [self returnphoto:avatar];
//        _upImageView.image = waterAva;
        [aliyunOssUpImage asyncUploadImage:waterAva complete:^(NSArray<NSString *> *names, UploadImageState state) {
            NSLog(@"%@",names);
            imagePath = [NSString stringWithFormat:@"http://chengzhi-oss.oss-cn-shanghai.aliyuncs.com/%@",names[0]];
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
    // 1.打印图片名字
    [self printAssetsName:assets];
}

- (UIImage *)returnphoto:(UIImage *)photos {
    UIImage *logo = [UIImage imageNamed:@"chengzhi-watermark"];
    UIImage *img = photos;
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
    return myImg;
}

#pragma mark - Private

/// 打印图片名字
- (void)printAssetsName:(NSArray *)assets {
    NSString *fileName;
    for (id asset in assets) {
        if ([asset isKindOfClass:[PHAsset class]]) {
            PHAsset *phAsset = (PHAsset *)asset;
            fileName = [phAsset valueForKey:@"filename"];
        } else if ([asset isKindOfClass:[ALAsset class]]) {
            ALAsset *alAsset = (ALAsset *)asset;
            fileName = alAsset.defaultRepresentation.filename;;
        }
        //NSLog(@"图片名字:%@",fileName);
    }
}

-(void)submitToUploadPictures
{
    // _photosArray
    if (_selectedPhotos.count > 0)
    {
        [SVProgressHUD showWithStatus:@"正在上传..."];
        //        [self upLoadImage:_selectedPhotos];
    }
    
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
