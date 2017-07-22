//
//  LoginViewController.m
//  WY4iPhone
//
//  Created by 旭朋  丁 on 15/9/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "ForgotPasswordViewController.h"
#import "BaseRequest.h"
#import "ZMUser.h"
#import "ZMBindAccountViewController.h"

#define kLoginUrl       @"app/crm/reguser/login.do"

@interface LoginViewController (){
    UITextField *userNameTextField;
    UITextField *passwordTextField;
    UIButton *confirmButton;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_isThird) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(viewControllerBack)];
    }
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(245, 50, 109);
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"登陆";
    self.view.backgroundColor = BaseBackViewRGB;
    _bindVC=[[ZMBindAccountViewController alloc]init];
    [self _initTextField];
}

- (void)_initTextField{
    userNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 10, APP_SCREEN_WIDTH, 45)];
    userNameTextField.placeholder = @"请输入用户名";
    userNameTextField.backgroundColor = [UIColor whiteColor];
    userNameTextField.returnKeyType = UIReturnKeyDone;
    userNameTextField.font = [UIFont systemFontOfSize:15];
    userNameTextField.delegate = self;
    UIImageView *textFieldImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, userNameTextField.height)];
    textFieldImage.image = [UIImage imageNamed:@"mine_user"];
    textFieldImage.contentMode = UIViewContentModeCenter;
    userNameTextField.leftView = textFieldImage;
    userNameTextField.leftViewMode = UITextFieldViewModeAlways;
    userNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:userNameTextField];
    
    CALayer *bottomLayer = [[CALayer alloc]init];
    bottomLayer.frame = CGRectMake(10, userNameTextField.height - 1, APP_SCREEN_WIDTH - 20, 1);
    bottomLayer.backgroundColor = RGBCOLOR(216, 216, 216).CGColor;
    [userNameTextField.layer addSublayer:bottomLayer];
    
    passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, userNameTextField.bottom, APP_SCREEN_WIDTH, 45)];
    passwordTextField.placeholder = @"请输入密码";
    passwordTextField.backgroundColor = [UIColor whiteColor];
    passwordTextField.returnKeyType = UIReturnKeyDone;
    passwordTextField.font = [UIFont systemFontOfSize:15];
    passwordTextField.secureTextEntry = YES;
    passwordTextField.delegate = self;
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    UIImageView *passwordFieldImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, userNameTextField.height)];
    passwordFieldImage.image = [UIImage imageNamed:@"mine_password"];
    passwordFieldImage.contentMode = UIViewContentModeCenter;
    [passwordTextField addSubview:passwordFieldImage];
    passwordTextField.leftView = passwordFieldImage;
    passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:passwordTextField];
    
   confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(10, passwordTextField.bottom + 25, APP_SCREEN_WIDTH - 20, 45)];
    confirmButton.backgroundColor = BaseTintRGB;
    confirmButton.layer.cornerRadius = 5;
    confirmButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [confirmButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:confirmButton];
    [confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    UILabel *forgotPassword = [[UILabel alloc] initWithFrame:CGRectMake(confirmButton.left , confirmButton.bottom + 23, 80, 15)];
    forgotPassword.backgroundColor = [UIColor clearColor];
    forgotPassword.font = [UIFont systemFontOfSize:15];
    forgotPassword.textColor = [UIColor grayColor];
    forgotPassword.text = @"忘记密码?";
    forgotPassword.userInteractionEnabled = YES;
    forgotPassword.tag = 21;
    [self.view addSubview:forgotPassword];
    
    UILabel *registLabel = [[UILabel alloc] initWithFrame:CGRectMake(confirmButton.right - 80 - 20, confirmButton.bottom + 23, 100, 15)];
    registLabel.backgroundColor = [UIColor clearColor];
    registLabel.textAlignment = NSTextAlignmentRight;
    registLabel.font = [UIFont systemFontOfSize:15];
    registLabel.textColor = BaseTintRGB;
    registLabel.text = @"注册";
    registLabel.userInteractionEnabled = YES;
    registLabel.tag = 22;
    [self.view addSubview:registLabel];
    
    UITapGestureRecognizer *tapForgot = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    [forgotPassword addGestureRecognizer:tapForgot];
    UITapGestureRecognizer *tapRegist = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    [registLabel addGestureRecognizer:tapRegist];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewControllerBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (![userNameTextField.text isUserName]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确用户名"];
    }
    return YES;
}

/**
 *  确认登录按钮
 *
 *  @param sender
 */
- (void)confirmButtonClick:(UIButton *)sender
{
    NSString *userName = userNameTextField.text;
    NSString *password = passwordTextField.text;
    if ([userName isEmpty] || [password isEmpty]) {
        [SVProgressHUD showInfoWithStatus:@"请将用户名和密码输入完整!"];
        return;
    }
    confirmButton.userInteractionEnabled=NO;
    BaseRequest *baseRequest = [BaseRequest sharedInstance];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:userName forKey:@"telNo"];
    [dict setValue:password forKey:@"password"];
    [baseRequest request:kLoginUrl parameters:dict success:^(id responseObject) {
        //NSLog(@"会员信息%@",responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            if (responseObject[@"result"]==nil)
            {
                return ;
            }
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            _bindVC.tellNumber=userNameTextField.text;
            NSMutableDictionary *result = responseObject[@"result"];
         ZMUser*user= [[ZMUser userInstance] initWithDict:result];
            
            [ZMUser userInstance].isLogin = YES;
            [self writeToCachePath:responseObject[@"result"]];
            if (_isThird) {
                [self viewControllerBack];
            }else{
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            
            //登录成功上传给友盟
            [MobClick profileSignInWithPUID:user.userId];
            confirmButton.userInteractionEnabled=YES;
            
        } else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", responseObject[@"result"]]];
            confirmButton.userInteractionEnabled=YES;
        }
    } failure:^(NSError *error) {
       // [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", [error localizedDescription]]];
        [SVProgressHUD showErrorWithStatus:@"登陆失败"];
    }];
    confirmButton.userInteractionEnabled=YES;
    
}

- (void)tapView:(UITapGestureRecognizer *)tap
{
    NSInteger tag = tap.view.tag;
    if (tag == 21) {
        ForgotPasswordViewController *viewController = [[ForgotPasswordViewController alloc]init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    if (tag == 22) {
        RegistViewController *viewController = [[RegistViewController alloc]init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

//数据写入缓存
- (void)writeToCachePath:(id)cacheData {
    NSString *path = [HomeDirectory stringByAppendingString:kUserInfoPath];
    [cacheData writeToFile:path atomically:YES];
}

@end
