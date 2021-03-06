//
//  HomeViewController.m
//  CZToken
//
//  Created by jlc on 2018/2/26.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeIconCell.h"
#import "TitleIconCell.h"
#import "NewsViewCell.h"
#import "iconCell.h"

#import "XgViewController.h"
#import "loansViewController.h"
#import "foreSigninController.h"
#import "UpInfoController.h"
#import "loginController.h"
#import "homeTradeController.h"
#import "cxMoneyController.h"
#import "newListModel.h"
#import "newsDetailsModel.h"
#import "calculateController.h"
@interface HomeViewController ()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    UIImageView *barImageView;
    UIButton *addressBtn;
}
@property (nonatomic, strong) BMKLocationService *locService;
@property (nonatomic, strong) BMKGeoCodeSearch *geocodesearch;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSMutableArray *newsArray;
@property (strong, nonatomic) NSMutableArray *newsDetailsArr;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    addressBtn = [[UIButton alloc] initWithFrame:CGRectMake(-20, 0, 80, 40)];
    [addressBtn addTarget:self action:@selector(changeAddress:) forControlEvents:UIControlEventTouchUpInside];
    addressBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [addressBtn setImage:[UIImage imageNamed:@"dw"] forState:UIControlStateNormal];
//    addressBtn.size = addressBtn.currentBackgroundImage.size;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addressBtn];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    barImageView = self.navigationController.navigationBar.subviews.firstObject;
    barImageView.alpha = 0;
    [self rightNavBarItemWithImage:@"tz" AndSel:@selector(addressClick)];
    UITextField *search = [[UITextField alloc] initWithFrame:CGRectMake(50, 10, screenW-120, 30)];
    self.navigationItem.titleView = search;
    search.placeholder = @"哈哈哈";
    search.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
    search.layer.cornerRadius = 4.0f;
    search.layer.masksToBounds = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(iconClick:) name:@"icon" object:nil];
    
    // dingwei
    self.locService = [[BMKLocationService alloc] init];
    [_locService startUserLocationService];
    self.locService.delegate = self;
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    _geocodesearch.delegate = self;
    self.newsArray = [NSMutableArray arrayWithCapacity:0];
    self.newsDetailsArr = [NSMutableArray arrayWithCapacity:0];
    [self requestNewList];
    // Do any additional setup after loading the view from its nib.
}

- (void)changeAddress:(UIButton *)sender {
    
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    //地理反编码
    BMKReverseGeoCodeOption *geoOption = [[BMKReverseGeoCodeOption alloc] init];
    geoOption.reverseGeoPoint = userLocation.location.coordinate;
    BOOL flag = [_geocodesearch reverseGeoCode:geoOption];
    if (flag) {
        NSLog(@"成功");
        [_locService stopUserLocationService];
    }else{
        NSLog(@"失败");
    }
    NSLog(@"didUpdateUserLocation 维度 %f,经度 %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            if (placemark != nil) {
                NSString *city = placemark.locality;
                // 获取当前的城市
                [addressBtn setTitle:city forState:UIControlStateNormal];
            }
        }
    }];
}

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    //addressDetail:     层次化地址信息
    //address:    地址名称
    //businessCircle:  商圈名称
    // location:  地址坐标
    //  poiList:   地址周边POI信息，成员类型为BMKPoiInfo
    NSLog(@"address%@-----%@",result.addressDetail,result.address);
//    [self.navigationItem.leftBarButtonItem setTitle:result.address];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeIconCell *homeCell = [[NSBundle mainBundle] loadNibNamed:@"HomeIconCell" owner:self options:nil][0];
    homeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    TitleIconCell *titleCell = [[NSBundle mainBundle] loadNibNamed:@"TitleIconCell" owner:self options:nil][0];
    titleCell.selectionStyle = UITableViewCellSelectionStyleNone;
    NewsViewCell *newCell = [[NSBundle mainBundle] loadNibNamed:@"NewsViewCell" owner:self options:nil][0];
    newCell.selectionStyle = UITableViewCellSelectionStyleNone;
    iconCell *iconCell = [[NSBundle mainBundle] loadNibNamed:@"iconCell" owner:self options:nil][0];
    newsDetailsDataModel *model = [[newsDetailsDataModel alloc] init];
    iconCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        tableView.rowHeight = 280;
        homeCell.iconImg.layer.cornerRadius = screenW/10;
        homeCell.scoreView.layer.cornerRadius = 10.0f;
        homeCell.scoreView.layer.masksToBounds = YES;
        homeCell.scoreView.layer.shadowOpacity = 0.8;
        homeCell.scoreView.layer.shadowOffset = CGSizeMake(-3, -3);
        homeCell.scoreView.layer.shadowRadius = 10.0f;
        homeCell.iconImg.layer.masksToBounds = YES;
        return homeCell;
    } else if (indexPath.row == 1 || indexPath.row == 5) {
        tableView.rowHeight = 50;
        if (indexPath.row == 5) {
            [titleCell.titleName setTitle:@"应用中心" forState:UIControlStateNormal];
            [titleCell.titleName setImage:[UIImage imageNamed:@"yyzx"] forState:UIControlStateNormal];
        }
        NSMutableAttributedString * attributeStr = [[NSMutableAttributedString alloc] initWithString:titleCell.titleName.titleLabel.text];
        [attributeStr addAttribute:NSObliquenessAttributeName value:@(0.3) range:NSMakeRange(0, 4)];
        titleCell.titleName.titleLabel.attributedText = attributeStr;
        return titleCell;
    } else if (indexPath.row == 2) {
        if (_newsDetailsArr.count > 0) {
            model = [newsDetailsDataModel mj_objectWithKeyValues:_newsDetailsArr[0]];
        }
        [newCell.myNewsImg sd_setImageWithURL:[NSURL URLWithString:model.CoverImage]];
        newCell.myType.text = @"置业安家";
        newCell.myDetails.text = model.Abstracts;
        newCell.titleLabel.text = model.Title;
        newCell.time.text = model.IssueTime;
        tableView.rowHeight = 90;
        return newCell;
    } else if (indexPath.row == 3) {
        newCell.myNewsImg.image = [UIImage imageNamed:@"04"];
        newCell.myType.text = @"新房首发";
        tableView.rowHeight = 90;
        return newCell;
    } else if (indexPath.row == 4) {
        newCell.myNewsImg.image = [UIImage imageNamed:@"05"];
        newCell.myType.text = @"精品租房";
        tableView.rowHeight = 90;
        return newCell;
    } else if (indexPath.row == 6) {
        tableView.rowHeight = screenW/2;
        return iconCell;
    }
    
    return homeCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    barImageView.alpha = 1;
    if (indexPath.row == 2) {
        newsDetailsDataModel *model = [newsDetailsDataModel mj_objectWithKeyValues:_newsDetailsArr[0]];
        [self reauestInfomation:model.Information];
    }
}

- (void)requestNewList {
    NSString *URL = [NSString stringWithFormat:@"%@/News/Information/Category",BaseUrl];
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        if ([dic intValueForKey:@"Code"] == 0) {
            newListModel *model = [newListModel mj_objectWithKeyValues:dic];
            _newsArray = model.Data;
            newListDataModel *newModel = [newListDataModel mj_objectWithKeyValues:_newsArray[2]];
            [self requestCategory:newModel.Id];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)requestCategory:(NSString *)categoryId {
    NSString *URL = [NSString stringWithFormat:@"%@/News/Information/PostResult/DataForList",BaseUrl];
    NSDictionary *params = @{@"CategoryId":categoryId,@"Keyword":@"",@"Page":@(0),@"PageSize":@(10),@"Token":TOKEN,@"Source":@"ios"};
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        newsDetailsModel *model = [newsDetailsModel mj_objectWithKeyValues:dic];
        _newsDetailsArr = model.Data;
        [_myTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)reauestInfomation:(NSString *)NewId {
    NSString *URL = [NSString stringWithFormat:@"%@/News/Information/Info",BaseUrl];
    NSDictionary *params = @{@"Id":NewId,@"Token":TOKEN,@"Source":@"ios"};
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        if ([dic intValueForKey:@"Code"] == 0) {
            loadWebView *webView = [[loadWebView alloc] init];
            webView.HTMLSTR = [[dic objectForKey:@"Data"] objectForKey:@"Content"];
            [self.navigationController pushViewController:webView animated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)iconClick:(NSNotification *)notification {
    barImageView.alpha = 1;
    NSInteger tag = [notification.userInfo[@"tag"] intValue];
    NSLog(@"%ld",(long)tag);
    if (tag == 2) {
        XgViewController *xg = [[XgViewController alloc] init];
        [self.navigationController pushViewController:xg animated:YES];
    } else if (tag == 3) {
        loansViewController *loans = [[loansViewController alloc] init];
        [self.navigationController pushViewController:loans animated:YES];
    } else if (tag == 1) {
        cxMoneyController *cx =[[cxMoneyController alloc] init];
        
        
        foreSigninController *signin = [[foreSigninController alloc] init];
        [self.navigationController pushViewController:signin animated:YES];
    } else if (tag == 4) {
        calculateController *calculate = [[calculateController alloc] init];
        [self.navigationController pushViewController:calculate animated:YES];
    } else if (tag == 5) {
//        homeTradeController *trade = [[homeTradeController alloc] init];
//        [self.navigationController pushViewController:trade animated:YES];
        
        
        
    } else {
//        ZHPickView *pickView = [[ZHPickView alloc] init];
////        [pickView setDataViewWithItem:@[@"item1",@"item2",@"item3"] title:@"DataTitle"];
//        [pickView setDateViewWithTitle:@"Date"];
//        [pickView showPickView:self];
//        pickView.block = ^(NSString *selectedStr)
//        {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You have chooseed:" message:selectedStr delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//        };
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat min = 0;
    CGFloat max = 64;
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = (offset - min) / (max - min);
    barImageView.alpha = alpha;
}


- (void)addressClick {
    
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
