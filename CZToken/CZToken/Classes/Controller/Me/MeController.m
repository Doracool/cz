//
//  MeController.m
//  CZToken
//
//  Created by jlc on 2018/3/9.
//  Copyright © 2018年 NYHZ. All rights reserved.
//

#import "MeController.h"
#import "meHeadCell.h"
#import "meScoreCell.h"
#import "meMoreActionCell.h"

@interface MeController ()
{
    UIImageView *barImageView;
}
@end

@implementation MeController

- (void)viewDidLoad {
    [super viewDidLoad];
    barImageView = self.navigationController.navigationBar.subviews.firstObject;
    barImageView.alpha = 0;
    // Do any additional setup after loading the view from its nib.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat min = 0;
    CGFloat max = 64;
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = (offset - min) / (max - min);
    barImageView.alpha = alpha;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    meHeadCell *headCell = [[NSBundle mainBundle] loadNibNamed:@"meHeadCell" owner:self options:nil][0];
    meScoreCell *scoreCell = [[NSBundle mainBundle] loadNibNamed:@"meScoreCell" owner:self options:nil][0];
    meMoreActionCell *moreCell = [[NSBundle mainBundle] loadNibNamed:@"meMoreActionCell" owner:self options:nil][0];
    headCell.selectionStyle = UITableViewCellSelectionStyleNone;
    scoreCell.selectionStyle = UITableViewCellSelectionStyleNone;
    moreCell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.rowHeight = 50;
    if (indexPath.row == 0) {
        tableView.rowHeight = 320;
        NSString *floStr;
        NSString *intStr;
        if ([headCell.moneyLabel.text containsString:@"."]) {
            NSRange range = [headCell.moneyLabel.text rangeOfString:@"."];
            floStr = [headCell.moneyLabel.text substringFromIndex:range.location];
            intStr = [headCell.moneyLabel.text substringToIndex:range.location];
            
            NSMutableAttributedString *indroStr = [[NSMutableAttributedString alloc] initWithString:@"3536.325"];
            [indroStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(0, range.location)];
            [indroStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, headCell.moneyLabel.text.length+1)];
            headCell.moneyLabel.attributedText = indroStr;
//            [headCell.moneyLabel sizeToFit];
        }
        
        
        
        return headCell;
    } else if (indexPath.row == 1) {
        tableView.rowHeight = 60;
        return scoreCell;
    } else if (indexPath.row == 2) {
        moreCell.myTitle.text = @"我要认证";
        return moreCell;
    } else if (indexPath.row == 3) {
        moreCell.myTitle.text = @"完善个人信息";
        return moreCell;
    } else if (indexPath.row == 4) {
        moreCell.myTitle.text = @"推广二维码";
        return moreCell;
    } else if (indexPath.row == 5) {
        moreCell.myTitle.text = @"资产明细";
        return moreCell;
    } else if (indexPath.row == 6) {
        moreCell.myTitle.text = @"诚信足记";
        return moreCell;
    } else if (indexPath.row == 7) {
        moreCell.myTitle.text = @"负面记录";
        return moreCell;
    } else if (indexPath.row == 8) {
        moreCell.myTitle.text = @"";
        return moreCell;
    }
    
    return nil;
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
