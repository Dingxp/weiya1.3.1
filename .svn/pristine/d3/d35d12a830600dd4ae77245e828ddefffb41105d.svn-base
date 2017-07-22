//
//  ZMCommissionViewController.m
//  WY4iPhone
//
//  Created by ZM21 on 15/9/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMCommissionViewController.h"
#import "ZMCommissionDetailViewController.h"
#import "BaseRequest.h"
#import "ZMUser.h"

@interface ZMCommissionViewController (){
    UIView *alertView;
    UIView *backView;
    UITextField *textFieldInput;
    NSDictionary *resultUserAndWSxxDic;
    ZMUser*user;
}

@end

@implementation ZMCommissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"佣金";
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
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
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 64, APP_SCREEN_WIDTH, 80)];
    view1.backgroundColor  = [UIColor whiteColor];
    [self.view addSubview:view1];
    UILabel *lbCommissions = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 150, 15)];
    lbCommissions.font = [UIFont systemFontOfSize:15];
    lbCommissions.text = @"佣金金额：";
    lbCommissions.textColor = RGBCOLOR(141, 141, 141);
    [view1 addSubview:lbCommissions];
    _labelCommission = [[UILabel alloc] initWithFrame:CGRectMake(lbCommissions.left, lbCommissions.bottom + 10, lbCommissions.width, 19)];
    _labelCommission.font = [UIFont systemFontOfSize:19];
    _labelCommission.textColor = RGBCOLOR(252, 0, 90);
    NSString *postStr = @"100元";
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:postStr];
    UIFont *boldFont = [UIFont boldSystemFontOfSize:19];
    [attrString addAttribute:NSFontAttributeName value:boldFont range:NSMakeRange(0, postStr.length)];
    _labelCommission.attributedText = attrString;
    [view1 addSubview:_labelCommission];
    CGFloat imgViewW = 24;
    CGFloat imgViewH = 16;
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(view1.width - imgViewW - 10, (view1.height - imgViewH) / 2, 24, 16)];
    _imgView.image = [UIImage imageNamed:@"entrp_14"];
    [view1 addSubview:_imgView];
    
    ////
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, view1.bottom + 10, APP_SCREEN_WIDTH, 80)];
    view2.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClicked:)];
    [view2 addGestureRecognizer:tap];
    view2.backgroundColor  = [UIColor whiteColor];
    [self.view addSubview:view2];
    UILabel *lbWithdrawal = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 150, 15)];
    lbWithdrawal.font = [UIFont systemFontOfSize:15];
    lbWithdrawal.textColor = RGBCOLOR(141, 141, 141);
    lbWithdrawal.text = @"可提现：";
    [view2 addSubview:lbWithdrawal];
    _labelWithdrawals = [[UILabel alloc] initWithFrame:CGRectMake(lbWithdrawal.left, lbWithdrawal.bottom + 10, lbWithdrawal.width, 18)];
    _labelWithdrawals.font = [UIFont systemFontOfSize:18];
    _labelWithdrawals.textColor = RGBCOLOR(252, 0, 90);
    _labelWithdrawals.text = @"100.00";
    [view2 addSubview:_labelWithdrawals];
    UILabel *lbTotalWithdrawal = [[UILabel alloc] initWithFrame:CGRectMake(view2.width - 10 - 100, lbWithdrawal.top, 100, 15)];
    lbTotalWithdrawal.textAlignment = NSTextAlignmentRight;
    lbTotalWithdrawal.font = [UIFont systemFontOfSize:15];
    lbTotalWithdrawal.textColor = RGBCOLOR(141, 141, 141);
    lbTotalWithdrawal.text = @"累计总佣金";
    [view2 addSubview:lbTotalWithdrawal];
    _labelTotalCommission = [[UILabel alloc] initWithFrame:CGRectMake(lbTotalWithdrawal.left, _labelWithdrawals.top, lbTotalWithdrawal.width, 18)];
    _labelTotalCommission.font = [UIFont systemFontOfSize:18];
    _labelTotalCommission.textAlignment = NSTextAlignmentRight;
    _labelTotalCommission.textColor = RGBCOLOR(252, 0, 90);
    _labelTotalCommission.text = @"200.00";
    [view2 addSubview:_labelTotalCommission];
    
    //
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, view2.bottom + 10, APP_SCREEN_WIDTH, 141)];
    view3.backgroundColor  = [UIColor whiteColor];
    [self.view addSubview:view3];
    CGFloat lbFirstCommissionW = (view3.width - 20) / 3;
    UILabel *lbFirstCommission = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, lbFirstCommissionW, 15)];
    lbFirstCommission.font = [UIFont systemFontOfSize:15];
    lbFirstCommission.text = @"一级佣金>";
//    lbFirstCommission.textAlignment = NSTextAlignmentCenter;
    lbFirstCommission.textColor = RGBCOLOR(141, 141, 141);
    [view3 addSubview:lbFirstCommission];
    _labelFirstCommission = [[UILabel alloc] initWithFrame:CGRectMake(lbFirstCommission.left, lbFirstCommission.bottom + 10, lbFirstCommission.width, 15)];
//    _labelFirstCommission.textAlignment = NSTextAlignmentCenter;
    _labelFirstCommission.font = [UIFont systemFontOfSize:15];
    _labelFirstCommission.text = @"100.00";
    [view3 addSubview:_labelFirstCommission];
    UILabel *lbSecondCommission = [[UILabel alloc] initWithFrame:CGRectMake(lbFirstCommissionW, 20, lbFirstCommissionW, 15)];
    lbSecondCommission.font = [UIFont systemFontOfSize:15];
    lbSecondCommission.textAlignment = NSTextAlignmentCenter;
    lbSecondCommission.text = @"二级佣金";
    lbSecondCommission.textColor = RGBCOLOR(141, 141, 141);
    [view3 addSubview:lbSecondCommission];
    _labelSecondCommission = [[UILabel alloc] initWithFrame:CGRectMake(lbSecondCommission.left, _labelFirstCommission.top, lbSecondCommission.width, 15)];
    _labelSecondCommission.textAlignment = NSTextAlignmentCenter;
    _labelSecondCommission.font = [UIFont systemFontOfSize:15];
    _labelSecondCommission.text = @"100.00";
    [view3 addSubview:_labelSecondCommission];
    UILabel *lbMyMercenary = [[UILabel alloc] initWithFrame:CGRectMake(lbFirstCommissionW * 2, 20, lbFirstCommissionW, 15)];
    lbMyMercenary.font = [UIFont systemFontOfSize:15];
    lbMyMercenary.textAlignment = NSTextAlignmentRight;
    lbMyMercenary.text = @"自营佣金";
    lbMyMercenary.textColor = RGBCOLOR(141, 141, 141);
    [view3 addSubview:lbMyMercenary];
    _labelMyMercenary = [[UILabel alloc] initWithFrame:CGRectMake(lbMyMercenary.left, _labelFirstCommission.top, lbMyMercenary.width, 15)];
    _labelMyMercenary.textAlignment = NSTextAlignmentRight;
    _labelMyMercenary.font = [UIFont systemFontOfSize:15];
    _labelMyMercenary.text = @"100.00";
    [view3 addSubview:_labelMyMercenary];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(_labelFirstCommission.left, _labelFirstCommission.bottom + 10, view3.width - 20, 0.5)];
    line.backgroundColor = RGBCOLOR(238, 238, 238);
    [view3 addSubview:line];
    
    UILabel *lbWithdrawalsed = [[UILabel alloc] initWithFrame:CGRectMake(10, line.bottom + 10, lbFirstCommissionW, 15)];
    lbWithdrawalsed.font = [UIFont systemFontOfSize:15];
    lbWithdrawalsed.text = @"已提现";
//    lbWithdrawalsed.textAlignment = NSTextAlignmentCenter;
    lbWithdrawalsed.textColor = RGBCOLOR(141, 141, 141);
    [view3 addSubview:lbWithdrawalsed];
    _labelWithdrawalsed = [[UILabel alloc] initWithFrame:CGRectMake(lbWithdrawalsed.left, lbWithdrawalsed.bottom + 10, lbWithdrawalsed.width, 15)];
//    _labelWithdrawalsed.textAlignment = NSTextAlignmentCenter;
    _labelWithdrawalsed.font = [UIFont systemFontOfSize:15];
    _labelWithdrawalsed.text = @"100.00";
    [view3 addSubview:_labelWithdrawalsed];
    UILabel *lbToBeConfirmed = [[UILabel alloc] initWithFrame:CGRectMake(lbFirstCommissionW, lbWithdrawalsed.top, lbFirstCommissionW, 15)];
    lbToBeConfirmed.font = [UIFont systemFontOfSize:15];
    lbToBeConfirmed.textAlignment = NSTextAlignmentCenter;
    lbToBeConfirmed.text = @"待确认";
    lbToBeConfirmed.textColor = RGBCOLOR(141, 141, 141);
    [view3 addSubview:lbToBeConfirmed];
    _labelToBeConfirmed = [[UILabel alloc] initWithFrame:CGRectMake(lbToBeConfirmed.left, _labelWithdrawalsed.top, lbToBeConfirmed.width, 15)];
    _labelToBeConfirmed.textAlignment = NSTextAlignmentCenter;
    _labelToBeConfirmed.font = [UIFont systemFontOfSize:15];
    _labelToBeConfirmed.text = @"100.00";
    [view3 addSubview:_labelToBeConfirmed];
    UILabel *lbWithdrawaling = [[UILabel alloc] initWithFrame:CGRectMake(lbFirstCommissionW * 2, lbWithdrawalsed.top, lbFirstCommissionW, 15)];
    lbWithdrawaling.font = [UIFont systemFontOfSize:15];
    lbWithdrawaling.textAlignment = NSTextAlignmentRight;
    lbWithdrawaling.text = @"提现中";
    lbWithdrawaling.textColor = RGBCOLOR(141, 141, 141);
    [view3 addSubview:lbWithdrawaling];
    _labelWithdrawaling = [[UILabel alloc] initWithFrame:CGRectMake(lbWithdrawaling.left, _labelWithdrawalsed.top, lbWithdrawaling.width, 15)];
    _labelWithdrawaling.textAlignment = NSTextAlignmentRight;
    _labelWithdrawaling.font = [UIFont systemFontOfSize:15];
    _labelWithdrawaling.text = @"100.00";
    [view3 addSubview:_labelWithdrawaling];
    
    UILabel *labelTip = [[UILabel alloc] initWithFrame:CGRectMake(10, view3.bottom + 10, view3.width, 15)];
    labelTip.font = [UIFont systemFontOfSize:15];
    labelTip.textColor = RGBCOLOR(141, 141, 141);
    labelTip.text = @"*待确认：关系用户未确认收货的商品";
    [self.view addSubview:labelTip];
    
    CGFloat btnH = 52;
    UIButton *btnWithdrawals = [[UIButton alloc] initWithFrame:CGRectMake(20, self.view.height - 20 - btnH, self.view.width - 40, btnH)];
    btnWithdrawals.backgroundColor  = RGBCOLOR(255, 0, 90);
    btnWithdrawals.layer.cornerRadius = 5;
    [btnWithdrawals setTitle:@"我要提现" forState:UIControlStateNormal];
    btnWithdrawals.tag = 30003;
    [btnWithdrawals addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnWithdrawals];
}

- (void) loadData{
    [self requestCommissionByRegUserId:user.userId];
    [self requestRegUserAndWsxxByRegUserId:user.userId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  佣金明细
 *
 *  @param tap <#tap description#>
 */
- (void) viewClicked: (UITapGestureRecognizer *) tap{
    ZMCommissionDetailViewController *commDetailVC = [[ZMCommissionDetailViewController alloc] init];
    [self.navigationController pushViewController:commDetailVC animated:YES];
}

- (UIView *) alertView{
    CGFloat viewH = 240;
    CGFloat viewW = self.view.width - 30 * 2;
    
    backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    backView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAlertView)];
    [backView addGestureRecognizer:tap];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.8;
    [self.view addSubview:backView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(30, (self.view.height - viewH) / 2, viewW, viewH)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10;
    [self.view addSubview:view];
    
    CGFloat labelTitleW = 30;
    CGFloat labelTitleH = 15;
    CGFloat space = 20;
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake((view.width - labelTitleW) / 2, space, labelTitleW, labelTitleH)];
    labelTitle.text = @"提现";
    labelTitle.font = [UIFont systemFontOfSize:15];
    [view addSubview:labelTitle];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, labelTitle.bottom + space, view.width, 1)];
    line1.backgroundColor = RGBCOLOR(241, 241, 241);
    [view addSubview:line1];
    
    UILabel *labelMoney = [[UILabel alloc] initWithFrame:CGRectMake(space, line1.bottom + space, 30, 15)];
    labelMoney.font = [UIFont systemFontOfSize:15];
    labelMoney.text = @"金额";
    [view addSubview:labelMoney];
    
    textFieldInput = [[UITextField alloc] initWithFrame:CGRectMake(labelMoney.right + 5, labelMoney.top, view.width - space * 2 - 5 - labelMoney.width, 15)];
    textFieldInput.placeholder = @"请输入提现金额";
    textFieldInput.font = [UIFont systemFontOfSize:15];
    [view addSubview:textFieldInput];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, textFieldInput.bottom + space, view.width, 1)];
    line2.backgroundColor = RGBCOLOR(241, 241, 241);
    [view addSubview:line2];
    
    UILabel *labelTips = [[UILabel alloc] initWithFrame:CGRectMake(space, line2.bottom + 10, view.width - space * 2, 15)];
    labelTips.font = [UIFont systemFontOfSize:15];
    labelTips.text = @"您的可提现金额为100.00，最小为10.00";
    [view addSubview:labelTips];
    
    UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(space, labelTips.bottom + space, (view.width - space * 2 - 5) / 2, 44)];
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    btnCancel.tag = 30001;
    [btnCancel addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnCancel.backgroundColor = [UIColor whiteColor];
    [btnCancel.layer setBorderWidth:0.5];
    [btnCancel.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [btnCancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnCancel.titleLabel.font = [UIFont systemFontOfSize:18];
    btnCancel.layer.cornerRadius = 5;
    [view addSubview:btnCancel];
    
    UIButton *btnOk = [[UIButton alloc] initWithFrame:CGRectMake(btnCancel.right + 5, btnCancel.top, btnCancel.width, btnCancel.height)];
    [btnOk setTitle:@"确定" forState:UIControlStateNormal];
    btnOk.tag = 30002;
    [btnOk addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnOk.backgroundColor = RGBCOLOR(255, 0, 90);
    btnOk.titleLabel.font = [UIFont systemFontOfSize:18];
    btnOk.layer.cornerRadius = 5;
    [view addSubview:btnOk];
    
    return view;
}

- (void) onBtnClicked:(UIButton *)button{
//    ZMWithdrawalsAccountViewController *withdrawalsAccountVC;
    switch (button.tag) {
        case 30001: // 取消
            [self dismissAlertView];
            break;
        case 30002: // 确定
            [self dismissAlertView];
            break;
        case 30003: // 提现
            break;
            
        default:
            break;
    }
}

- (void) dismissAlertView{
    [alertView removeFromSuperview];
    [backView removeFromSuperview];
}

- (void) refreshViewWithDictionary:(NSDictionary *)resultDict{
    _labelCommission.attributedText = [self parserBoldString:resultDict[@"totalComm"]];
}

- (void) btnWithdrawalsClicked:(UIButton *)button{
    if ([textFieldInput.text isEmpty]) {
        [SVProgressHUD showInfoWithStatus:@"请输入提现金额"];
        return;
    }
    
    if ([resultUserAndWSxxDic[@"zfbAccount"] isEmpty] || resultUserAndWSxxDic[@"zfbAccount"] == NULL) {// 支付宝帐号为空，先绑定支付宝
        ZMBindAccountViewController *bindAccountVC = [[ZMBindAccountViewController alloc] init];
        [self.navigationController pushViewController:bindAccountVC animated:YES];
        return;
    } else {
        ZMWithdrawalsAccountViewController *withdrawalAccountVC = [[ZMWithdrawalsAccountViewController alloc] init];
        [self.navigationController pushViewController:withdrawalAccountVC animated:YES];
    }
    
//    alertView = [self alertView];
    
//    [self requestApplyMoneyByRegUserId:[ZMUser userInstance].userId telNo:[ZMUser userInstance].telNo amount:textFieldInput.text zfbAccount:@"15801965051"];
}

/**
 *  佣金
 *
 *  @param regUserId 会员ID
 */
- (void) requestCommissionByRegUserId:(NSString *)regUserId{
    NSString *url = @"webusi/commission/commission/findCommissionByWsId.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:regUserId forKey:@"regUserId"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
//        NSLog(@"responseObject:%@", responseObject[@"result"]);
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            NSDictionary *resultDict = responseObject[@"result"];
            [self refreshViewWithDictionary:resultDict];
        } else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"result"]];
        }
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
 *  查询会员信息和微商信息
 *
 *  @param regUserId 会员ID
 */
- (void) requestRegUserAndWsxxByRegUserId:(NSString *)regUserId{
    NSString *url = @"app/crm/reguser/findRegUserAndWsxxById.do";
    if (regUserId==nil)
    {
        return;
    }

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:regUserId forKey:@"regUserId"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
//            NSLog(@"serAndWsxx: %@", responseObject);
            resultUserAndWSxxDic = responseObject[@"result"];
        } else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"result"]];
        }
        
    } failure:^(NSError *error) {
//        NSLog(@"error: %@", [error localizedDescription]);
    }];
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
