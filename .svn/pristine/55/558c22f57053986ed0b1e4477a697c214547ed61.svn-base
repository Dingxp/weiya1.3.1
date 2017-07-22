//
//  ZMWithdrawalsAccountViewController.m
//  WY4iPhone
//
//  Created by ZM21 on 15/9/16.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMWithdrawalsAccountViewController.h"
#import "ZMBindAccountViewController.h"

@interface ZMWithdrawalsAccountViewController (){
    UIView *view;
    UIView *realView;
    ZMZFBAccount *zfbAccount;
    
}

@end

@implementation ZMWithdrawalsAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"工资账户";
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self loadAccountView];
    [self loadNoAccountView];
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
/**
 *  已绑定支付宝显示的View
 */
- (void) loadAccountView{
    // 已绑定支付宝显示的View
    realView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, self.view.width, self.view.height)];
    realView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:realView];
    
    UIView *accountView = [[UIView alloc] initWithFrame:CGRectMake(0, 15, realView.width, 80)];
    accountView.backgroundColor = [UIColor whiteColor];
    [realView addSubview:accountView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, accountView.width, 1)];
    line.backgroundColor  = RGBCOLOR(233, 233, 233);
    [accountView addSubview:line];
    
    UIImageView *imgHead = [[UIImageView alloc] initWithFrame:CGRectMake(20, line.bottom + 15, 50, 50)];
    imgHead.contentMode = UIViewContentModeScaleAspectFill;
    imgHead.layer.masksToBounds = YES;
    imgHead.image = [UIImage imageNamed:@"10order_03"];
    [accountView addSubview:imgHead];
    
    _labelUserName = [[UILabel alloc] initWithFrame:CGRectMake(imgHead.right + 10, imgHead.top + 5, 200, 17)];
    _labelUserName.font = [UIFont systemFontOfSize:15];
    [accountView addSubview:_labelUserName];
    
    _labelAccoutNum = [[UILabel alloc] initWithFrame:CGRectMake(imgHead.right + 10, imgHead.bottom - 20, 200, 17)];
    _labelAccoutNum.font = [UIFont systemFontOfSize:15];
    [accountView addSubview:_labelAccoutNum];
    
    UIButton *btnModifiedAccount = [[UIButton alloc] initWithFrame:CGRectMake(20, accountView.bottom + 36, self.view.width - 20 * 2, 53)];
    [btnModifiedAccount setTitle:@"更改支付宝账户" forState:UIControlStateNormal];
    btnModifiedAccount.titleLabel.font = [UIFont systemFontOfSize:18];
    btnModifiedAccount.layer.cornerRadius = 5;
    btnModifiedAccount.backgroundColor = RGBCOLOR(255, 0, 90);
    [btnModifiedAccount addTarget:self action:@selector(modifyZFBAccount:) forControlEvents:UIControlEventTouchUpInside];
    [realView addSubview:btnModifiedAccount];
    
    realView.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self loadData];
}

/**
 *  未绑定支付宝显示的View
 */
- (void) loadNoAccountView{
    // 未绑定支付宝显示的View
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - self.navigationController.navigationBar.bottom - self.tabBarController.tabBar.height)];
    view.backgroundColor = RGBCOLOR(240, 240, 240);
    [self.view addSubview:view];
    
    CGFloat btnH = 53;
    CGFloat leftSpace = 22;
    CGFloat btnW = (view.width - leftSpace * 2);
    CGFloat btnX = leftSpace;
    CGFloat btnY = (self.view.height - btnH) / 2;
    UIButton *btnBind = [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
    btnBind.layer.cornerRadius = 5;
    btnBind.backgroundColor = RGBCOLOR(255, 0, 90);
    [btnBind setTitle:@"绑定支付宝账户" forState:UIControlStateNormal];
    btnBind.titleLabel.font = [UIFont systemFontOfSize:18];
    [btnBind addTarget:self action:@selector(bindAliPay:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnBind];
    
    UILabel *labelTips = [[UILabel alloc] initWithFrame:CGRectMake(0, btnBind.top - 25 - 15, view.width, 15)];
    labelTips.backgroundColor = RGBCOLOR(240, 240, 240);
    labelTips.textColor = RGBCOLOR(184, 184, 184);
    labelTips.text = @"还没有绑定提现用户";
    labelTips.font = [UIFont systemFontOfSize:15];
    labelTips.textAlignment = NSTextAlignmentCenter;
    [view addSubview:labelTips];
    
    view.hidden = YES;
}

- (void) loadData{
    ZMUser*user=[[ZMUser userInstance] refreshUserInfo];

    [self requestZFBAccountByRegUserId:user.userId];
}

/**
 *  显示支付宝账号信息
 */
- (void) refreshAFBAccountView{
    if (zfbAccount == nil || zfbAccount.zfbAccount == NULL || zfbAccount.zfbAccount.length <= 0) {
        return;
    }
    _labelAccoutNum.text = [NSString stringWithFormat:@"%@", zfbAccount.zfbAccount];
    _labelUserName.text = [NSString stringWithFormat:@"%@", zfbAccount.realName];
}

- (void) bindAliPay:(UIButton *)button{
    ZMBindAccountViewController *bindAccountVC = [[ZMBindAccountViewController alloc] init];
    [self.navigationController pushViewController:bindAccountVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) requestZFBAccountByRegUserId:(NSString *)regUserId{
    NSString *url = @"webusi/cashrecord/cashrecord/findZfbAccount.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:regUserId forKey:@"regUserId"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
//        NSLog(@"支付宝账户信息: %@", responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            zfbAccount = [ZMZFBAccount zfbAccountWithDictionary:responseObject[@"result"]];
            if (zfbAccount == nil || zfbAccount.zfbAccount == NULL || zfbAccount.zfbAccount.length <= 0) {// 未绑定支付宝
                realView.hidden = YES;
                view.hidden = NO;
            } else{
                // 绑定了支付宝
                [self refreshAFBAccountView];
                view.hidden = YES;
                realView.hidden = NO;
            }
        } else { // 默认显示未绑定支付宝
            realView.hidden = YES;
            view.hidden = NO;
        }
    } failure:^(NSError *error) {
//        NSLog(@"error: %@", [error localizedDescription]);
    }];
}

- (void) modifyZFBAccount:(UIButton *) button{
    ZMBindAccountViewController *bindAccountVC = [[ZMBindAccountViewController alloc] init];
    bindAccountVC.zfbAccount = zfbAccount;
    [self.navigationController pushViewController:bindAccountVC animated:YES];
}

@end
