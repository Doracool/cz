//
//  homeTradeController.m
//  CZToken
//
//  Created by 周帅杰 on 2018/3/20.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "homeTradeController.h"
#import "areaModel.h"
#import "jyzxModel.h"
#import "cqUserView.h"
@interface homeTradeController ()<TTTagsDelegate>

@end

@implementation homeTradeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initBaseUI];
}

- (void)initBaseUI {
    DVSwitch *jylx = [[DVSwitch alloc] initWithStringsArray:@[@"等额本息",@"等额本金"]];
    [_view1 addSubview:jylx];
    jylx.frame = CGRectMake(screenW/2 - 20, 10, screenW/2 , 30);
    
    [jylx setPressedHandler:^(NSUInteger index) {
        NSLog(@"switch is %lu",(unsigned long)index);
        if (index == 0) {
            _view4.hidden = YES;
            _view4Height.constant = 0;
        } else {
            _view4.hidden = NO;
            _view4Height.constant = 150;
        }
    }];
    
    NSString *URL = [NSString stringWithFormat:@"%@/Trade/TradeArea/Get?token=%@",BaseUrl,TOKEN];
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        areaModel *model = [areaModel mj_objectWithKeyValues:dic];
        NSMutableArray *areaArr = model.Data;
        NSMutableArray *areas = [NSMutableArray array];
        for (NSInteger i = 0; i < areaArr.count; i++) {
            areaDataModel *model = [areaDataModel mj_objectWithKeyValues:areaArr[i]];
            [areas addObject:model.AreaName];
        }
        TTChooseBtnView *view = [[TTChooseBtnView alloc] initWithFrame:CGRectMake(12, 8, screenW-24, 50) andTags:areas andTitleColor:[UIColor lineColor] andFonts:13];
        [_view2Small addSubview:view];
        _smallHeight.constant = view.height;
        _view2Height.constant = view.height + 40;
        
        [view setPressedHandler:^(NSUInteger index) {
            areaDataModel *model = [areaDataModel mj_objectWithKeyValues:areaArr[index]];
            [self requestArea:model.Id];
        }];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    [_view4addBtn addTarget:self action:@selector(addcqUser) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)addcqUser {
    _view4Height.constant += 50;
    cqUserView *view = [[NSBundle mainBundle] loadNibNamed:@"cqUserView" owner:self options:nil][0];
    NSArray *subviews = _view4.subviews;
    NSInteger count = 0;
    for (NSInteger i = 0; i < subviews.count; i++) {
        if ([subviews[i] isKindOfClass:[cqUserView class]]) {
            count++;
            ((cqUserView *) subviews[i]).height = 35;
        }
    }
    view.frame = CGRectMake(0, count*50 + 40, screenW, 35);
    [_view4 addSubview:view];
    
    
}

- (void)requestArea:(NSString *)areaID {
    NSString *URL = [NSString stringWithFormat:@"%@/Trade/TradeResult/QueryCenterByArea?token=%@&areaId=%@",BaseUrl,TOKEN,areaID];
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        [_view3Samll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        jyzxModel *model = [jyzxModel mj_objectWithKeyValues:dic];
        NSMutableArray *jyzxArr = model.Data;
        NSMutableArray *jyzx = [NSMutableArray array];
        for (NSInteger i = 0; i < jyzxArr.count; i++) {
            jyzxDataModel *zxModel = [jyzxDataModel mj_objectWithKeyValues:jyzxArr[i]];
            [jyzx addObject:zxModel.CenterName];
        }
        TTChooseBtnView *view = [[TTChooseBtnView alloc] initWithFrame:CGRectMake(12, 8, screenW-24, 50) andTags:jyzx andTitleColor:[UIColor lineColor] andFonts:13];
        [_view3Samll addSubview:view];
        _small2Height.constant = view.height;
        _view3Height.constant = view.height + 40;
        
        [view setPressedHandler:^(NSUInteger index) {
            jyzxDataModel *model = [jyzxDataModel mj_objectWithKeyValues:jyzxArr[index]];
            NSLog(@"jyzxCenter %@",model.Id);
        }];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
//    [manager POST:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        NSLog(@"%@",dic);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//    }];
}

- (void)chooseTagsArr:(NSMutableArray *)chooseArr {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self tabbarHidden];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self tabbarShow];
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
