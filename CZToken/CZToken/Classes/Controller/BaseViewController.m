//
//  BaseViewController.m
//  CZToken
//
//  Created by jlc on 2018/2/26.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self backBarButtonItem:@"返回"];
}

- (void)hideTabBar {
    
    AppDelegate * app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [app.mainTab czTabBarHidden:YES animated:YES];
    
    if (self.tabBarController.tabBar.hidden == YES) {
        return;
    }
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    else
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)showTabBar
{
    AppDelegate * app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [app.mainTab czTabBarHidden:NO animated:YES];
    
    if (self.tabBarController.tabBar.hidden == NO)
    {
        return;
    }
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    else
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = NO;
}

-(void)backBtnAction{
    [self.navigationController  popViewControllerAnimated:YES];
}

-(void)backBarButtonItem:(NSString *)image{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 22, 22)];
    iv.backgroundColor = [UIColor clearColor];
    iv.image = [UIImage imageNamed:image];
    [btn addSubview:iv];
    self.fd_prefersNavigationBarHidden = NO;
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
    
}

/**
 * 自定义navgationBar左边item（默认pop返回）
 * image item的图片
 */
-(void)leftNavBarItemWithImage:(NSString *)image
{
    UIImage *itemImage = [UIImage imageNamed:image];
    UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    itemBtn.bounds = CGRectMake( 0, 0, 30, 30 );
    [itemBtn setImage:itemImage forState:UIControlStateNormal];
    [itemBtn addTarget:self action:@selector(navigationleft) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:itemBtn];
    item1.width = 5;
    
    self.navigationItem.leftBarButtonItem = item1;
    
}

- (void)navigationleft {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/**
 * 自定义navgationBar左边item
 * 纯文字类型
 */
-(void)leftNavBarItemWithTitle:(NSString *)title AndSel:(SEL)selector
{
    /**
     * 1、自定义按钮的方式
     */
    UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    itemBtn.bounds = CGRectMake( 0, 0, 70, 30);
    [itemBtn setTitle:title forState:UIControlStateNormal];
    [itemBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [itemBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    [itemBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [itemBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [itemBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    __unused UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:itemBtn];
    
    /**
     * 2、系统提供的方式
     */
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:selector];
    
    //设置UIBarButtonItem的字体大小（酱厂--左侧按钮标题大小）
    NSMutableDictionary *leftTextAttrs=[NSMutableDictionary dictionary];
    leftTextAttrs[NSFontAttributeName]=[UIFont systemFontOfSize:17];
    leftTextAttrs[NSForegroundColorAttributeName]= [UIColor colorWithHexString:@"ffffff"];
    NSMutableDictionary *leftAttrs=[NSMutableDictionary dictionaryWithDictionary:leftTextAttrs];
    [item2 setTitleTextAttributes:leftAttrs forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = item2;
}

/**
 * 自定义navgationBar左边item
 * image item的普通状态图片
 * selector 动态方法
 */
-(void)leftNavBarItemWithImage:(NSString *)image AndSel:(SEL)selector
{
    UIImage *itemImage = [UIImage imageNamed:image];
    UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    itemBtn.bounds = CGRectMake( 0, 0, itemImage.size.width, itemImage.size.height );
    [itemBtn setImage:itemImage forState:UIControlStateNormal];
    [itemBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:itemBtn];
    
    //    self.navigationController.interactivePopGestureRecognizer.delegate =(id)self;//解决手势失效的问题
    self.navigationItem.leftBarButtonItem = item1;
}
/**
 * 自定义navgationBar左边item
 * norImage item的普通状态图片
 * selImage item的选中状态图片
 * selector 动态方法
 */
-(void)leftNavBarItemWithImage:(NSString *)norImage SelectImage:(NSString *)selImage AndSel:(SEL)selector
{
    UIImage *itemImage = [UIImage imageNamed:norImage];
    UIImage *selectImage = [UIImage imageNamed:selImage];
    UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    itemBtn.bounds = CGRectMake( 0, 0, itemImage.size.width, itemImage.size.height );
    [itemBtn setImage:itemImage forState:UIControlStateNormal];
    [itemBtn setImage:selectImage forState:UIControlStateSelected];
    [itemBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:itemBtn];
    
    self.navigationController.interactivePopGestureRecognizer.delegate =(id)self;//解决手势失效的问题
    self.navigationItem.leftBarButtonItem = item1;
}

-(void)rightNavBarItemWithImages:(NSArray*)imgs andSel:(SEL)selector{
    NSMutableArray *arrays = [NSMutableArray array];
    
    //    NSArray *imgs = @[@"ic_collect",@"ic_share",@"ic_report"];
    
    for (int i=0; i<imgs.count; i++) {
        UIImage *itemImage = [UIImage imageNamed:imgs[i]];
        UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        itemBtn.bounds = CGRectMake( 0, 0, 22, 22 );
        itemBtn.tag = imgs.count - i;
        
        [itemBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
        [itemBtn setImage:itemImage forState:UIControlStateNormal];
        [itemBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:itemBtn];
        item.width = -10;
        [arrays addObject:item];
    }
    self.navigationItem.rightBarButtonItems = arrays;
    
}


/**
 * 自定义navgationBar右边item
 * norImage item的普通状态图片
 * selector 动态方法
 */
-(void)rightNavBarItemWithImage:(NSString *)norImage AndSel:(SEL)selector
{
    UIImage *itemImage = [UIImage imageNamed:norImage];
    UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    itemBtn.bounds = CGRectMake( 0, 0, 30, 30 );
    [itemBtn setImage:itemImage forState:UIControlStateNormal];
    [itemBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:itemBtn];
    
    self.navigationItem.rightBarButtonItem = item1;
}

/**
 * 自定义navgationBar右边item
 * norImage item的普通状态图片
 * selImage item的选中状态图片
 * selector 动态方法
 */
-(void)rightNavBarItemWithImage:(NSString *)norImage HlImage:(NSString *)hlImage AndSel:(SEL)selector
{
    UIImage *itemnorImage = [UIImage imageNamed:norImage];
    UIImage *itemhlImage = [UIImage imageNamed:hlImage];
    UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    itemBtn.bounds = CGRectMake( 0, 0, itemnorImage.size.width, itemnorImage.size.height );
    [itemBtn setImage:itemnorImage forState:UIControlStateNormal];
    [itemBtn setImage:itemhlImage forState:UIControlStateHighlighted];
    [itemBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:itemBtn];
    
    self.navigationItem.rightBarButtonItem = item1;
}


-(void)rightNavBarItemWithTitleFaBu:(NSString*)title AndImage:(NSString*)image AndSel:(SEL)selector{
    UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    itemBtn.bounds = CGRectMake( 0, 0, 50, 30);
    [itemBtn setTitle:title forState:UIControlStateNormal];
    [itemBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [itemBtn setTitleColor:[UIColor titleNavColor] forState:UIControlStateNormal];
    [itemBtn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [itemBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [itemBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:itemBtn];
    self.navigationItem.rightBarButtonItem = item1;
}

/**
 * 自定义右边的NavigationBarItem
 * 文字类型的item
 */
-(void)rightNavBarItemWithTitle:(NSString *)title AndSel:(SEL)selector
{
    /**
     * 1、自定义按钮的方式
     */
    UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    itemBtn.bounds = CGRectMake( 0, 0, 70, 30);
    [itemBtn setTitle:title forState:UIControlStateNormal];
    [itemBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [itemBtn setTitleColor:[UIColor titleNavColor] forState:UIControlStateNormal];
    //    [itemBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [itemBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [itemBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:itemBtn];
    
    /**
     * 2、系统提供的方式
     */
    //    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:selector];
    self.navigationItem.rightBarButtonItem = item1;
}
/**
 * 自定义右边的NavigationBarItem
 * 文字类型的item (分为普通标题和选中的标题)
 */
-(void)rightNavBarItemWithTitle:(NSString *)title AndSelTitle:(NSString *)selTitle AndSel:(SEL)selector
{
    /**
     * 1、自定义按钮的方式
     */
    UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    itemBtn.bounds = CGRectMake( 0, 0, 70, 30);
    [itemBtn setTitle:title forState:UIControlStateNormal];
    [itemBtn setTitle:selTitle forState:UIControlStateSelected];
    [itemBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [itemBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    [itemBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [itemBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [itemBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:itemBtn];
    
    /**
     * 2、系统提供的方式
     */
    //    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:selector];
    self.navigationItem.rightBarButtonItem = item1;
}

/**
 * 显示navigationBar
 */
-(void)navigationBarShow
{
    if (self.navigationController.navigationBarHidden == YES) {
        self.navigationController.navigationBarHidden = NO;
    }
}
/**
 * 隐藏navigationBar
 */
-(void)navigationBarHidden
{
    if (self.navigationController.navigationBarHidden == NO) {
        self.navigationController.navigationBarHidden = YES;
    }
}

/**
 * 显示tabBar
 */
-(void)tabbarShow
{
    
    [self showTabBar];
    //    self.tabBarController.tabBar.hidden = NO;
    
}

/**
 * 隐藏tabBar
 */
-(void)tabbarHidden
{
    [self hideTabBar];
    //    self.tabBarController.tabBar.hidden = YES;
    
}


// 判断电话号码是否正确
- (BOOL)isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

- (BOOL)CheckIsIdentityCard:(NSString *)identityCard
{
    //判断是否为空
    if (identityCard==nil||identityCard.length <= 0) {
        return NO;
    }
    //判断是否是18位，末尾是否是x
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    if(![identityCardPredicate evaluateWithObject:identityCard]){
        return NO;
    }
    //判断生日是否合法
    NSRange range = NSMakeRange(6,8);
    NSString *datestr = [identityCard substringWithRange:range];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat : @"yyyyMMdd"];
    if([formatter dateFromString:datestr]==nil){
        return NO;
    }
    
    //判断校验位
    if(identityCard.length==18)
    {
        NSArray *idCardWi= @[ @"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2" ]; //将前17位加权因子保存在数组里
        NSArray * idCardY=@[ @"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2" ]; //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        int idCardWiSum=0; //用来保存前17位各自乖以加权因子后的总和
        for(int i=0;i<17;i++){
            idCardWiSum+=[[identityCard substringWithRange:NSMakeRange(i,1)] intValue]*[idCardWi[i] intValue];
        }
        
        int idCardMod=idCardWiSum%11;//计算出校验码所在数组的位置
        NSString *idCardLast=[identityCard substringWithRange:NSMakeRange(17,1)];//得到最后一位身份证号码
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2){
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]){
                return YES;
            }else{
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast intValue]==[idCardY[idCardMod] intValue]){
                return YES;
            }else{
                return NO;
            }
        }
    }
    return NO;
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
