//
//  ZMCommissionViewController2.m
//  WY4iPhone
//
//  Created by ZM21 on 15/10/7.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMCommissionViewController2.h"

@interface ZMCommissionViewController2 (){
    UITextField *textFieldInput;
    NSDictionary *resultUserAndWSxxDic;
    NSDictionary *resultCommissonDict;
    UIImageView *imgRightIndicate;
    NSDictionary *toualArray;
    ZMUser*user;
}

@end

@implementation ZMCommissionViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"佣金";
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    user=[ZMUser userWithDict:userDic];
    [self initView];
    [self loadData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"PageOne"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"PageOne"];
}
- (void) initView{
    //
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 80)];
    view1.backgroundColor  = [UIColor whiteColor];
    [self.view addSubview:view1];
    UILabel *lbCommissions = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 150, 15)];
    lbCommissions.font = [UIFont systemFontOfSize:15];
    lbCommissions.text = @"我的余额：";
    lbCommissions.textColor = RGBCOLOR(141, 141, 141);
    [view1 addSubview:lbCommissions];
    _labelCommission = [[UILabel alloc] initWithFrame:CGRectMake(lbCommissions.left, lbCommissions.bottom + 10, lbCommissions.width, 19)];
    _labelCommission.font = [UIFont systemFontOfSize:19];
    _labelCommission.textColor = RGBCOLOR(252, 0, 90);
    NSString *postStr = @"￥0.00";
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:postStr];
    UIFont *boldFont = [UIFont boldSystemFontOfSize:19];
    [attrString addAttribute:NSFontAttributeName value:boldFont range:NSMakeRange(0, postStr.length)];
    _labelCommission.attributedText = attrString;
    [view1 addSubview:_labelCommission];
    
    // 提现账户View
    UIView *viewAccount = [[UIView alloc] initWithFrame:CGRectMake(view1.width - 68, 0, 68, view1.height)];
    viewAccount.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewAccountClicked:)];
    [viewAccount addGestureRecognizer:tap];
    [view1 addSubview:viewAccount];
    
    CGFloat imgViewW = 24;
    CGFloat imgViewH = 16;
    //支付宝的图标
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake((viewAccount.width - imgViewW) / 2, (viewAccount.height - imgViewH - 27) / 2, 40, 40)];
    _imgView.image = [UIImage imageNamed:@"bank1"];
    [viewAccount addSubview:_imgView];
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, view1.bottom + 10, APP_SCREEN_WIDTH, 80)];
    view2.backgroundColor  = [UIColor whiteColor];
    [self.view addSubview:view2];
    //待发放View
    UIView *viewToBeIssued = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view2.width / 2, view2.height)];
    [view2 addSubview:viewToBeIssued];
    
    CALayer *toBeIssuedLayer = [CALayer layer];
    toBeIssuedLayer.frame = CGRectMake(viewToBeIssued.width - 1, 15, 1, viewToBeIssued.height - 30);
    toBeIssuedLayer.backgroundColor = RGBCOLOR(245, 245, 245).CGColor;
    [viewToBeIssued.layer addSublayer:toBeIssuedLayer];
    
    _labelWithdrawals = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, viewToBeIssued.width, 18)];
    _labelWithdrawals.font = [UIFont systemFontOfSize:18];
    _labelWithdrawals.textColor = [UIColor blackColor];
    _labelWithdrawals.text = @"0";
    _labelWithdrawals.textAlignment = NSTextAlignmentCenter;
    [viewToBeIssued addSubview:_labelWithdrawals];
    
    UILabel *lbWithdrawal = [[UILabel alloc] initWithFrame:CGRectMake(0, _labelWithdrawals.bottom + 10, viewToBeIssued.width, 15)];
    lbWithdrawal.font = [UIFont systemFontOfSize:15];
    lbWithdrawal.textColor = RGBCOLOR(141, 141, 141);
    lbWithdrawal.textAlignment = NSTextAlignmentCenter;
    lbWithdrawal.text = @"待发放";
    [viewToBeIssued addSubview:lbWithdrawal];
    
    // 佣金明细View
    UIView *viewCommDetail = [[UIView alloc] initWithFrame:CGRectMake(viewToBeIssued.right, 0, view2.width / 2, view2.height)];
    viewCommDetail.userInteractionEnabled = YES;
    UITapGestureRecognizer *commDetailTap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClicked:)];
    [viewCommDetail addGestureRecognizer:commDetailTap];
    [view2 addSubview:viewCommDetail];
    
    _labelTotalCommission = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, viewCommDetail.width, 18)];
    _labelTotalCommission.font = [UIFont systemFontOfSize:18];
    _labelTotalCommission.textAlignment = NSTextAlignmentCenter;
    _labelTotalCommission.textColor = [UIColor blackColor];
    _labelTotalCommission.text = @"0";
    [viewCommDetail addSubview:_labelTotalCommission];
    
    UILabel *lbTotalWithdrawal = [[UILabel alloc] initWithFrame:CGRectMake(0, _labelTotalCommission.bottom + 10, viewCommDetail.width, 15)];
    lbTotalWithdrawal.textAlignment = NSTextAlignmentCenter;
    lbTotalWithdrawal.font = [UIFont systemFontOfSize:15];
    lbTotalWithdrawal.textColor = RGBCOLOR(141, 141, 141);
    lbTotalWithdrawal.text = @"佣金明细";
    [viewCommDetail addSubview:lbTotalWithdrawal];
    
    imgRightIndicate = [[UIImageView alloc] initWithFrame:CGRectMake(viewCommDetail.width - 10 - 10, (viewCommDetail.height - 13) / 2, 10, 13)];
    imgRightIndicate.image = [UIImage imageNamed:@"mine_rightGray"];
    [viewCommDetail addSubview:imgRightIndicate];
    
    //////////
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, view2.bottom + 10, APP_SCREEN_WIDTH, 80)];
    view3.backgroundColor  = [UIColor whiteColor];
    [self.view addSubview:view3];
    // 上月入账
    UIView *viewLastMonth = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view2.width / 2, view2.height)];
    [view3 addSubview:viewLastMonth];
    
    CALayer *lastMonthLayer = [CALayer layer];
    lastMonthLayer.frame = CGRectMake(viewToBeIssued.width - 1, 15, 1, viewLastMonth.height - 30);
    lastMonthLayer.backgroundColor = RGBCOLOR(245, 245, 245).CGColor;
    [viewLastMonth.layer addSublayer:lastMonthLayer];
    
    _labelLastMonthCount = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, viewLastMonth.width, 18)];
    _labelLastMonthCount.font = [UIFont systemFontOfSize:18];
    _labelLastMonthCount.textColor = [UIColor blackColor];
    _labelLastMonthCount.text = @"0";
    _labelLastMonthCount.textAlignment = NSTextAlignmentCenter;
    [viewLastMonth addSubview:_labelLastMonthCount];
    
    UILabel *lbLastMonth = [[UILabel alloc] initWithFrame:CGRectMake(0, _labelWithdrawals.bottom + 10, viewLastMonth.width, 15)];
    lbLastMonth.font = [UIFont systemFontOfSize:15];
    lbLastMonth.textColor = RGBCOLOR(141, 141, 141);
    lbLastMonth.textAlignment = NSTextAlignmentCenter;
    lbLastMonth.text = @"上月入账";
    [viewLastMonth addSubview:lbLastMonth];
    
    // 历史入账
    UIView *viewHistory = [[UIView alloc] initWithFrame:CGRectMake(viewLastMonth.right, 0, view3.width / 2, view3.height)];
    [view3 addSubview:viewHistory];
    
    _labelHistoryCount = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, viewHistory.width, 18)];
    _labelHistoryCount.font = [UIFont systemFontOfSize:18];
    _labelHistoryCount.textAlignment = NSTextAlignmentCenter;
    _labelHistoryCount.textColor = [UIColor blackColor];
    _labelHistoryCount.text = @"0";
    [viewHistory addSubview:_labelHistoryCount];
    
    UILabel *lbHistory = [[UILabel alloc] initWithFrame:CGRectMake(0, _labelTotalCommission.bottom + 10, viewHistory.width, 15)];
    lbHistory.textAlignment = NSTextAlignmentCenter;
    lbHistory.font = [UIFont systemFontOfSize:15];
    lbHistory.textColor = RGBCOLOR(141, 141, 141);
    lbHistory.text = @"历史入账";
    //
    [viewHistory addSubview:lbHistory];
    UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(0, view3.bottom + 10, APP_SCREEN_WIDTH, 80)];
    view4.backgroundColor  = [UIColor whiteColor];
    [self.view addSubview:view4];
    // 待确认佣金
    UIView *queryMoney = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view2.width / 2, view2.height)];
    [view4 addSubview:queryMoney];
    
    CALayer *MonthLayer = [CALayer layer];
    MonthLayer.frame = CGRectMake(viewToBeIssued.width - 1, 15, 1, viewLastMonth.height - 30);
    MonthLayer.backgroundColor = RGBCOLOR(245, 245, 245).CGColor;
    [queryMoney.layer addSublayer:MonthLayer];
    
    _queryMoneyLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, viewLastMonth.width, 18)];
    _queryMoneyLab.font = [UIFont systemFontOfSize:18];
    _queryMoneyLab.textColor = [UIColor blackColor];
    _queryMoneyLab.text = @"0";
    _queryMoneyLab.textAlignment = NSTextAlignmentCenter;
    [queryMoney addSubview:_queryMoneyLab];
    
    UILabel *queryLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _labelWithdrawals.bottom + 10, viewLastMonth.width, 15)];
    queryLab.font = [UIFont systemFontOfSize:15];
    queryLab.textColor = RGBCOLOR(141, 141, 141);
    queryLab.textAlignment = NSTextAlignmentCenter;
    queryLab.text = @"待确认佣金";
    [queryMoney addSubview:queryLab];
    // 历史入账
    UIView *teamMoney = [[UIView alloc] initWithFrame:CGRectMake(viewLastMonth.right, 0, view3.width / 2, view3.height)];
    [view4 addSubview:teamMoney];
    
    _teamMoneyLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, viewHistory.width, 18)];
    _teamMoneyLab.font = [UIFont systemFontOfSize:18];
    _teamMoneyLab.textAlignment = NSTextAlignmentCenter;
    _teamMoneyLab.textColor = [UIColor blackColor];
    _teamMoneyLab.text = @"0";
    [teamMoney addSubview:_teamMoneyLab];
    
    UILabel *teamLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _labelTotalCommission.bottom + 10, viewHistory.width, 15)];
    teamLab.textAlignment = NSTextAlignmentCenter;
    teamLab.font = [UIFont systemFontOfSize:15];
    teamLab.textColor = RGBCOLOR(141, 141, 141);
    teamLab.text = @"团队总销售额";
    //
    [teamMoney addSubview:teamLab];
    UILabel *labelViewDescription = [[UILabel alloc] initWithFrame:CGRectMake(0, view4.bottom + 20, self.view.width, 16)];
    labelViewDescription.text = @"  查看说明";
    labelViewDescription.userInteractionEnabled = YES;
    UITapGestureRecognizer *labelViewDesc = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelViewDescriptionClicked:)];
    [labelViewDescription addGestureRecognizer:labelViewDesc];
    labelViewDescription.textColor = [UIColor lightGrayColor];
    labelViewDescription.backgroundColor = [UIColor clearColor];
    labelViewDescription.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:labelViewDescription];
}
// 加载数据
- (void) loadData{
    //查看佣金
    [self requestCommissionByRegUserId:user.userId];
    //查看支付宝是否绑定
    [self requestZFBAccountByRegUserId:user.userId];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewClicked: (UITapGestureRecognizer *) tap{
    ZMCommissionDetailViewController *commDetailVC = [[ZMCommissionDetailViewController alloc] init];
    [self.navigationController pushViewController:commDetailVC animated:YES];
}

/**
 *  工资账户点击事件
 *
 *  @param tap
 */
- (void) viewAccountClicked:(UITapGestureRecognizer *)tap{
    if ([user.userId isEmpty] || user.userId == NULL) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
        return;
    }
    ZMWithdrawalsAccountViewController *withdrawalsAccountVC = [[ZMWithdrawalsAccountViewController alloc] init];
    [self.navigationController pushViewController:withdrawalsAccountVC animated:YES];
}
/**
 *  查看支付宝是否绑定
 *
 *
 */
- (void) requestZFBAccountByRegUserId:(NSString *)regUserId{
    NSString *url = @"wbusi/wbusiinfo/wbusiinfo/findZfbInfo.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:regUserId forKey:@"regUserId"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
               // NSLog(@"支付宝账户信息: %@", responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"])
        {
             _imgView.image=[UIImage imageNamed:@"bank1"];
            
        } else
        {
            _imgView.image=[UIImage imageNamed:@"bank2"];
        }
    } failure:^(NSError *error) {
        //        NSLog(@"error: %@", [error localizedDescription]);
    }];
}

/**
 *  查看佣金说明点击事件，用web进行显示
 *
 *  @param tap 
 */
- (void) labelViewDescriptionClicked:(UITapGestureRecognizer *)tap{
    ZMCommDescriptionViewController *commDescVC = [[ZMCommDescriptionViewController alloc] init];
    commDescVC.urlStr = resultCommissonDict[@"webUrl"];
    [self.navigationController pushViewController:commDescVC animated:YES];
}
- (void) refreshViewWithDictionary:(NSDictionary *)resultDict{
    if (resultDict.count <= 0) {
        return;
    }
    _labelTotalCommission.attributedText = [self parserBoldString:[NSString stringWithFormat:@"￥%.2f", [resultDict[@"totalAmount"] doubleValue]]];
    _labelHistoryCount.text = [NSString stringWithFormat:@"￥%.2f", [resultDict[@"historyAmount"] doubleValue]];
    _labelLastMonthCount.text = [NSString stringWithFormat:@"￥%.2f", [resultDict[@"lastMonthAmount"] doubleValue]];
    _labelCommission.text = [NSString stringWithFormat:@"￥%.2f", [resultDict[@"overAmount"] doubleValue]];
    _labelWithdrawals.text = [NSString stringWithFormat:@"￥%.2f", [resultDict[@"waitAmount"] doubleValue]];
    _queryMoneyLab.text = [NSString stringWithFormat:@"￥%.2f", [resultDict[@"unconfirmedAmount"] doubleValue]];
    _teamMoneyLab.text = [NSString stringWithFormat:@"￥%.2f", [resultDict[@"teamTotalAmount"] doubleValue]];
}

/**
 *  佣金
 *
 *  @param regUserId 会员ID
 */
- (void) requestCommissionByRegUserId:(NSString *)regUserId{
    NSString *url = @"webusi/commission/commission/findCommission.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:regUserId forKey:@"regUserId"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
         //NSLog(@"支付宝账户信息: %@", responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            resultCommissonDict = responseObject[@"result"];
            toualArray=responseObject;
            [self refreshViewWithDictionary:resultCommissonDict];
            

        }
//        NSLog(@"Commission:%@",responseObject);
    } failure:^(NSError *error) {
//        NSLog(@"error:%@", [error localizedDescription]);
    }];
}

/**
 *  给字体加粗
 *
 *  @param str
 */
- (NSMutableAttributedString *) parserBoldString:(NSString *)str{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:str];
    UIFont *boldFont = [UIFont boldSystemFontOfSize:19];
    [attrString addAttribute:NSFontAttributeName value:boldFont range:NSMakeRange(0, str.length)];
    return attrString;
}

/**
 *  申请提现
 *
 *  @param regUserId  会员id
 *  @param telNo      会员账号
 *  @param amount     金额
 *  @param zfbAccount 支付宝账号
 */
- (void) requestApplyMoneyByRegUserId:(NSString *)regUserId telNo:(NSString *)telNo amount:(NSString *)amount zfbAccount:(NSString *)zfbAccount{
    NSString *url = @"webusi/cashrecord/cashrecord/applyMoney.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:regUserId forKey:@"regUserId"];
    [params setValue:telNo forKey:@"telNo"];
    [params setValue:amount forKey:@"amount"];
    [params setValue:zfbAccount forKey:@"zfbAccount"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            [SVProgressHUD showSuccessWithStatus:responseObject[@"result"]];
        } else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"result"]];
        }
    } failure:^(NSError *error) {
//        NSLog(@"error: %@", [error localizedDescription]);
    }];
}

@end
