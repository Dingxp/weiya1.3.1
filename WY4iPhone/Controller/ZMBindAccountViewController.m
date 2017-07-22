//
//  ZMBindAccountViewController.m
//  WY4iPhone
//
//  Created by ZM21 on 15/9/17.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMBindAccountViewController.h"

@interface ZMBindAccountViewController (){
    UIButton *btnAuthor;
    NSInteger timeCount;
    /**
     *  支付宝帐号
     */
    UITextField *textFieldUserName;
    /**
     *  用户真实姓名
     */
    UITextField *textFieldName;
    /**
     *  验证码
     */
    UITextField *textFieldPWD;
    ZMUser*user;
}

@end

@implementation ZMBindAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"绑定支付宝";
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
    timeCount = 60;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.view.width, 55)];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = RGBCOLOR(177, 177, 177);
    label.text = @"请输入正确的支付宝账户，以供提现";
    label.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, label.bottom, self.view.width, 145)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.width, 1)];
    line.backgroundColor = RGBCOLOR(231, 231, 231);
    [view addSubview:line];
    
    UILabel *lbUserName = [[UILabel alloc] initWithFrame:CGRectMake(10, line.bottom + 15, 45, 15)];
    lbUserName.font = [UIFont systemFontOfSize:14];
    lbUserName.textColor = RGBCOLOR(184, 184, 184);
    lbUserName.text = @"账户";
    [view addSubview:lbUserName];
    
    textFieldUserName = [[UITextField alloc] initWithFrame:CGRectMake(lbUserName.right + 10, lbUserName.top, view.width - 10 * 3 - lbUserName.width, lbUserName.height + 2)];
    textFieldUserName.placeholder = @"请输入支付宝用户";
    textFieldUserName.font = [UIFont systemFontOfSize:15];
    [view addSubview:textFieldUserName];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, textFieldUserName.bottom + 15, view.width, 1)];
    line2.backgroundColor = RGBCOLOR(231, 231, 231);
    [view addSubview:line2];
    
    UILabel *lbName = [[UILabel alloc] initWithFrame:CGRectMake(10, line2.bottom + 15, 45, 15)];
    lbName.textColor = RGBCOLOR(184, 184, 184);
    lbName.text = @"姓名";
    lbName.font = [UIFont systemFontOfSize:14];
    [view addSubview:lbName];
    
    textFieldName = [[UITextField alloc] initWithFrame:CGRectMake(lbName.right + 10, lbName.top, textFieldUserName.width, textFieldUserName.height)];
    textFieldName.placeholder = @"请输入用户姓名";
    textFieldName.font = [UIFont systemFontOfSize:15];
    [view addSubview:textFieldName];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, textFieldName.bottom + 15, view.width, 1)];
    line3.backgroundColor = RGBCOLOR(231, 231, 231);
    [view addSubview:line3];
    
    CGFloat btnW = 97;
    CGFloat btnH = 30;
    UILabel *lbPassword = [[UILabel alloc] initWithFrame:CGRectMake(10, line3.bottom + 15, 45, 15)];
    lbPassword.textColor = RGBCOLOR(184, 184, 184);
    lbPassword.text = @"验证码";
    lbPassword.font = [UIFont systemFontOfSize:14];
    [view addSubview:lbPassword];
    
    textFieldPWD = [[UITextField alloc] initWithFrame:CGRectMake(lbPassword.right + 10, lbPassword.top, view.width - lbPassword.width - btnW - 10 * 3, textFieldUserName.height)];
    textFieldPWD.placeholder = @"输入验证码";
    textFieldPWD.font = [UIFont systemFontOfSize:15];
    [view addSubview:textFieldPWD];
    
    btnAuthor = [[UIButton alloc] initWithFrame:CGRectMake(view.width - 10 - btnW, (45 - btnH) / 2 + line3.bottom, btnW, btnH)];
    [btnAuthor setTitle:@"获取验证码" forState:UIControlStateNormal];
    btnAuthor.titleLabel.font = [UIFont systemFontOfSize:14];
    btnAuthor.layer.cornerRadius = 3;
    btnAuthor.layer.borderWidth = 1;
    btnAuthor.layer.borderColor = RGBCOLOR(255, 157, 186).CGColor;
    [btnAuthor setTitleColor:RGBCOLOR(255, 157, 186) forState:UIControlStateNormal];
    [btnAuthor addTarget:self action:@selector(startTimer) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnAuthor];
    
    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(0, textFieldPWD.bottom + 15, view.width, 1)];
    line4.backgroundColor = RGBCOLOR(231, 231, 231);
    [view addSubview:line4];
    
    UIButton *btnSave = [[UIButton alloc] initWithFrame:CGRectMake(20, view.bottom + 36, self.view.width - 20 * 2, 53)];
    [btnSave setTitle:@"保存" forState:UIControlStateNormal];
    btnSave.titleLabel.font = [UIFont systemFontOfSize:18];
    btnSave.layer.cornerRadius = 5;
    btnSave.backgroundColor = RGBCOLOR(255, 0, 90);
    [btnSave addTarget:self action:@selector(btnSave:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSave];
    
    self.view.userInteractionEnabled  = YES;
    UITapGestureRecognizer *viewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyboard:)];
    [self.view addGestureRecognizer:viewTap];
}

- (void) loadData{
    textFieldName.text = _zfbAccount.realName;
    textFieldUserName.text = _zfbAccount.zfbAccount;
}

/**
 *  点击空白区域隐藏键盘
 *
 *  @param tap <#tap description#>
 */
- (void) hiddenKeyboard:(UITapGestureRecognizer *)tap{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) startTimer{
    [self getConfirmCodeByPhoneNum:user.telNo];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
    btnAuthor.enabled = NO;
}

- (void) timerMethod{
    [btnAuthor setTitle:[NSString stringWithFormat:@"%ld", (long)timeCount--] forState:UIControlStateNormal];
    if (timeCount == 0) {
        timeCount = 60;
        [btnAuthor setTitle:@"获取验证码" forState:UIControlStateNormal];
        btnAuthor.enabled = YES;
        [_timer invalidate];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [_timer invalidate];
}

/**
 *  获取验证码
 */
- (void) getConfirmCodeByPhoneNum:(NSString *)phoneNum{
    NSString *url = @"app/crm/smm/sendVerCode.do";
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:phoneNum forKey:@"telNo"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        // [SVProgressHUD dismiss];
        NSLog(@"====%@",responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
        }
    } failure:^(NSError *error) {
        //        NSLog(@"error:%@", [error localizedDescription]);
    }];

    
}

- (void) btnSave:(UIButton *)button{
    timeCount = 60;
    [_timer invalidate];
    [btnAuthor setTitle:@"获取验证码" forState:UIControlStateNormal];
    btnAuthor.enabled = YES;
    if ([textFieldPWD.text isEmpty]) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码！"];
        return;
    }
    NSString *url1 = @"app/crm/smm/checkVerCode.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:user.telNo forKey:@"telNo"];
    [params setValue:textFieldPWD.text forKey:@"vCode"];
    [[BaseRequest sharedInstance] request:url1 parameters:params success:^(id responseObject) {
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            [self requestBindingZFBByRegUserId:user.userId realName:textFieldName.text zfbAccount:textFieldUserName.text];
        }
        else{
            //NSLog(@"===error:%@", responseObject[@"result"]);
            [SVProgressHUD showErrorWithStatus:@"验证码错误"];
            
        }
        
    } failure:^(NSError *error) {
        // NSLog(@"error:%@", [error localizedDescription]);
    }];

}

/**
 *  绑定支付宝
 *
 *  @param regUserId  会员ID
 *  @param realName   真实姓名
 *  @param zfbAccount 支付宝账号
 */
- (void) requestBindingZFBByRegUserId:(NSString *)regUserId realName:(NSString *)realName zfbAccount:(NSString *)zfbAccount{
    NSString *url = @"webusi/cashrecord/cashrecord/bindingZfb.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:regUserId forKey:@"regUserId"];
    [params setValue:realName forKey:@"realName"];
    [params setValue:zfbAccount forKey:@"zfbAccount"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            [self.navigationController popViewControllerAnimated:YES];
            [SVProgressHUD showSuccessWithStatus:responseObject[@"result"]];
        } else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"result"]];
        }
    } failure:^(NSError *error) {
//        NSLog(@"error:%@", [error localizedDescription]);
    }];
    
}

@end
