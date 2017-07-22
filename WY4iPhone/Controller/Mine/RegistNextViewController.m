//
//  RegistNextViewController.m
//  WY4iPhone
//
//  Created by 旭朋  丁 on 15/9/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "RegistNextViewController.h"
#import "BaseRequest.h"
#import "ZMUser.h"
#import "SVProgressHUD.h"
#import <SMS_SDK/SMS_SDK.h>

@interface RegistNextViewController (){
    UITextField *codeTextField;
    NSTimer *countDownTimer;
    UILabel *timeFire;
    UIButton *getCheck;
    int secondsCountDown;
    ZMUser*user;
    UITextField *passwordTextField;
    UITextField *shareTextField;
    NSString *url;
    UIButton *confirmButton;
   

}

@end

@implementation RegistNextViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [countDownTimer invalidate];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    secondsCountDown = 60;
    self.navigationItem.title = @"输入密码";
    self.view.backgroundColor = BaseBackViewRGB;
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    user=[ZMUser userWithDict:userDic];

    [self initTextField];
    url = @"app/crm/reguser/regist.do";
    // 获取验证码
    [self getConfirmCode];
    // 启动计时器
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initTextField
{
    codeTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 10, APP_SCREEN_WIDTH, 45)];
    
    codeTextField.placeholder = @"请输入收到的验证码";
    codeTextField.backgroundColor = [UIColor whiteColor];
    codeTextField.font = [UIFont systemFontOfSize:15];
    codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    codeTextField.returnKeyType = UIReturnKeyDone;
    codeTextField.delegate = self;
    UIImageView *textFieldImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, codeTextField.height)];
    textFieldImage.image = [UIImage imageNamed:@"mine_info"];
    textFieldImage.contentMode = UIViewContentModeCenter;
    codeTextField.leftView = textFieldImage;
    codeTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:codeTextField];
    
    getCheck = [[UIButton alloc]initWithFrame:CGRectMake(APP_SCREEN_WIDTH - 97 - 15, (codeTextField.height- 28) / 2, 97, 28)];
    getCheck.layer.borderColor = BaseTintRGB.CGColor;
    getCheck.layer.borderWidth = 1;
    [getCheck setTitleColor:BaseTintRGB forState:UIControlStateNormal];
    [getCheck setTitle:@"获取验证码" forState:UIControlStateNormal];
    getCheck.titleLabel.font = [UIFont systemFontOfSize:15];
    getCheck.layer.cornerRadius = 5;
    [getCheck addTarget:self action:@selector(timeleft) forControlEvents:UIControlEventTouchUpInside];
    [codeTextField addSubview:getCheck];
    
    timeFire = [[UILabel alloc]initWithFrame:getCheck.frame];
    timeFire.text = @"倒计时60秒";
    timeFire.font = [UIFont systemFontOfSize:15];
    timeFire.textAlignment = NSTextAlignmentCenter;
    timeFire.layer.borderWidth = 1;
    timeFire.layer.borderColor = BaseTintRGB.CGColor;
    timeFire.layer.cornerRadius = 5;
    timeFire.textColor = BaseTintRGB;
    timeFire.backgroundColor = [UIColor whiteColor];
    timeFire.hidden = YES;
    [codeTextField addSubview:timeFire];
    
    CALayer *bottomLayer = [[CALayer alloc]init];
    bottomLayer.frame = CGRectMake(15, codeTextField.height - 1, APP_SCREEN_WIDTH - 30, 1);
    bottomLayer.backgroundColor = RGBCOLOR(216, 216, 216).CGColor;
    [codeTextField.layer addSublayer:bottomLayer];
    
    passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, codeTextField.bottom, APP_SCREEN_WIDTH, 45)];
    passwordTextField.placeholder = @"请输入6位以上的密码";
    passwordTextField.font = [UIFont systemFontOfSize:15];
    passwordTextField.backgroundColor = [UIColor whiteColor];
    passwordTextField.returnKeyType = UIReturnKeyDone;
    passwordTextField.secureTextEntry = YES;
    passwordTextField.delegate = self;
    UIImageView *passwordFieldImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, codeTextField.height)];
    passwordFieldImage.image = [UIImage imageNamed:@"mine_password"];
    passwordFieldImage.contentMode = UIViewContentModeCenter;
    passwordTextField.leftView = passwordFieldImage;
    passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:passwordTextField];
    
    shareTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, passwordTextField.bottom + 15, APP_SCREEN_WIDTH, 45)];
    shareTextField.placeholder = @"输入分享码（选填）";
    shareTextField.backgroundColor = [UIColor whiteColor];
    shareTextField.font = [UIFont systemFontOfSize:15];
    shareTextField.returnKeyType = UIReturnKeyDone;
    shareTextField.delegate = self;
    UIImageView *shareFieldImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, codeTextField.height)];
    shareFieldImage.image = [UIImage imageNamed:@"mine_share0"];
    shareFieldImage.contentMode = UIViewContentModeRight;
    [shareTextField addSubview:shareFieldImage];
    shareTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 52, 0)];
    shareTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:shareTextField];
    
    confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(10, shareTextField.bottom + 25, APP_SCREEN_WIDTH - 20, 45)];
    confirmButton.backgroundColor = BaseTintRGB;
    confirmButton.layer.cornerRadius = 5;
    [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    confirmButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:confirmButton];
    [confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, confirmButton.bottom + 15, APP_SCREEN_WIDTH, 13)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:13];
    NSString *postStr = [NSString stringWithFormat:@"注册即接受《微芽使用协议》"];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:postStr];
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:BaseTintRGB
                       range:NSMakeRange(5, 8)];
    titleLabel.attributedText = attrString;
    [self.view addSubview:titleLabel];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL) isRightPassword:(NSString *)password{
    if (![password isPassword]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确密码"];
        return NO;
    }
    return YES;
}

-(void)timeleft
{
    timeFire.hidden = NO;
    getCheck.hidden = YES;
    getCheck.userInteractionEnabled = NO;
    // 启动计时器
    [self startTimer];
    // 获取验证码
    [self getConfirmCode];
}

/**
 *  获取验证码
 */
- (void) getConfirmCode{
    NSString *url1 = @"app/crm/smm/sendVerCode.do";
     NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:_phoneNum forKey:@"telNo"];
    
    [[BaseRequest sharedInstance] request:url1 parameters:params success:^(id responseObject) {
        // [SVProgressHUD dismiss];
       // NSLog(@"====%@",responseObject);
        
        if ([responseObject[@"statu"] isEqualToString:@"true"]) {
            
        }else{
            //NSLog(@"===error:%@", responseObject[@"result"]);
        }
        [self startTimer];
    } failure:^(NSError *error) {
               // NSLog(@"===error:%@", [error localizedDescription]);
    }];

}

- (void) startTimer{
    
    timeFire.hidden = NO;
    getCheck.hidden = YES;
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}

-(void)timeFireMethod
{
    secondsCountDown--;
    timeFire.text = [NSString stringWithFormat:@"倒计时%d秒",secondsCountDown];
    if(secondsCountDown==0){
        [countDownTimer invalidate];
        secondsCountDown = 60;
        timeFire.hidden = YES;
        getCheck.hidden = NO;
        getCheck.userInteractionEnabled = YES;
        timeFire.text = @"倒计时60秒";
    }
}


/**
 *  输入完成，点击确认按钮的响应事件
 */
- (void)confirmButtonClick{
    confirmButton.userInteractionEnabled=NO;
    confirmButton.backgroundColor=[UIColor grayColor];
    timeFire.hidden = YES;
    getCheck.hidden = NO;
    secondsCountDown = 60;
    [countDownTimer invalidate];
    if (!codeTextField.text) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码！"];
        confirmButton.userInteractionEnabled=YES;
        confirmButton.backgroundColor = BaseTintRGB;
        return;
    }
     NSString *url1 = @"app/crm/smm/checkVerCode.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:_phoneNum forKey:@"telNo"];
    [params setValue:codeTextField.text forKey:@"vCode"];
    [[BaseRequest sharedInstance] request:url1 parameters:params success:^(id responseObject) {
              if ([responseObject[@"statu"] isEqualToString:@"true"]) {
            
        }
        else{
            //NSLog(@"===error:%@", responseObject[@"result"]);
            [SVProgressHUD showErrorWithStatus:@"验证码错误"];

        }
        confirmButton.userInteractionEnabled=YES;
        confirmButton.backgroundColor = BaseTintRGB;
        
    } failure:^(NSError *error) {
              NSLog(@"error=====:%@", [error localizedDescription]);
        confirmButton.userInteractionEnabled=YES;
        confirmButton.backgroundColor = BaseTintRGB;
    }];
    

    BaseRequest *baseRequest = [BaseRequest sharedInstance];
    if ([self isRightPassword:passwordTextField.text]) {
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setValue:_phoneNum forKey:@"telNo"];
        [params setValue:passwordTextField.text forKey:@"password"];
        if (shareTextField.text==nil)
        {
            return;
            
        }
        else
        {
           [params setValue:shareTextField.text forKey:@"inviteCode"];
        }
        
        // 发送注册请求
        [baseRequest request:url parameters:params success:^(id responseObject) {
            confirmButton.userInteractionEnabled=YES;
            getCheck.layer.borderColor = BaseTintRGB.CGColor;
            NSLog(@"==---+++%@",responseObject);
            if ([responseObject[@"statu"] isEqualToString:@"true"]) {
            ZMUser*use= [[ZMUser userInstance] initWithDict:responseObject[@"result"]];
                //注册成功上传给友盟
                [MobClick profileSignInWithPUID:use.userId];

               //[self writeToCachePath:responseObject[@"result"]];
                [self requestLogin];
            } else {
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", responseObject[@"result"]]];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", [error localizedDescription]]];
            confirmButton.userInteractionEnabled=YES;
            getCheck.layer.borderColor = BaseTintRGB.CGColor;
        }];
    }
    
}

//数据写入缓存
- (void)writeToCachePath:(id)cacheData {
    NSString *path = [HomeDirectory stringByAppendingString:kUserInfoPath];
    [cacheData writeToFile:path atomically:YES];
}

/**
 *  确认登录按钮
 *
 *  @param sender
 */
- (void) requestLogin{
    NSString *loginUrl = @"app/crm/reguser/login.do";
    
    NSString *userName = _phoneNum;
    NSString *password = passwordTextField.text;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:userName forKey:@"telNo"];
    [dict setValue:password forKey:@"password"];
    
    [[BaseRequest sharedInstance] request:loginUrl parameters:dict success:^(id responseObject) {
        if ([responseObject[@"statu"] isEqualToString:@"true"]) {
            NSMutableDictionary *result = responseObject[@"result"];
            [ZMUser userInstance].isLogin = YES;
            [self writeToCachePath:responseObject[@"result"]];
//            [[ZMUser userInstance] saveUserInfo];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            //登录成功上传给友盟
            [MobClick profileSignInWithPUID:user.userId];
            
        } else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", responseObject[@"result"]]];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", [error localizedDescription]]];
    }];
    
}

@end
