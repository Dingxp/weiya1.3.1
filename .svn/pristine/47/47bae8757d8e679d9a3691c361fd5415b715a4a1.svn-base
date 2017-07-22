//
//  ForgotPasswordViewController1.m
//  WY4iPhone
//
//  Created by 旭朋  丁 on 15/9/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ForgotPasswordViewController1.h"
#import "ForgotPasswordViewController2.h"
#import "BaseRequest.h"
#import "ZMUser.h"
#define kLoginUrl       @"app/crm/reguser/login.do"

@interface ForgotPasswordViewController1 (){
    UITextField *passwordTextField;
    UIButton *confirmButton;
}

@end

@implementation ForgotPasswordViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationItem.title = @"设置密码";
    self.view.backgroundColor = BaseBackViewRGB;
    [self _initTextField];
}

- (void)_initTextField
{
    passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.bottom + 15, APP_SCREEN_WIDTH, 45)];
    passwordTextField.placeholder = @"请输入超过6位数字或字母的新密码";
    passwordTextField.backgroundColor = [UIColor whiteColor];
    passwordTextField.returnKeyType = UIReturnKeyDone;
    passwordTextField.font = [UIFont systemFontOfSize:15];
    passwordTextField.secureTextEntry = YES;
    passwordTextField.delegate = self;
    UIImageView *passwordFieldImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, passwordTextField.height)];
    passwordFieldImage.image = [UIImage imageNamed:@"mine_password"];
    passwordFieldImage.contentMode = UIViewContentModeCenter;
    passwordTextField.leftView = passwordFieldImage;
    passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:passwordTextField];
    
    confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(10, passwordTextField.bottom + 25, APP_SCREEN_WIDTH - 20, 45)];
    confirmButton.backgroundColor = BaseTintRGB;
    confirmButton.layer.cornerRadius = 5;
    [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    confirmButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:confirmButton];
    [confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)confirmButtonClick
{
    confirmButton.userInteractionEnabled=NO;
    
    if ([passwordTextField.text isPassword]) {
        [self requestResetPasswordByPhoneNum:_phoneNum password:passwordTextField.text];
        confirmButton.userInteractionEnabled=YES;
    }else{
        [SVProgressHUD showErrorWithStatus:@"密码格式不正确！"];
        confirmButton.userInteractionEnabled=YES;
    }
}

/**
 *  忘记密码，填写手机号，获取验证码之后重置密码
 *
 *  @param phoneNum 手机号
 *  @param password 新的密码
 */
- (void) requestResetPasswordByPhoneNum:(NSString *)phoneNum password:(NSString *)password{
    NSString *url = @"app/crm/reguser/resetPassword.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:phoneNum forKey:@"telNo"];
    [params setValue:password forKey:@"password"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        NSLog(@"===%@",responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"]) {
            [SVProgressHUD showSuccessWithStatus:responseObject[@"result"]];
            
            [self firmButtonClickTell:phoneNum password:password];
        } else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"result"]];
        }
    } failure:^(NSError *error) {
//        NSLog(@"error: %@", [error localizedDescription]);
    }];
}
- (void)firmButtonClickTell:(NSString*)tell password:(NSString*)password
{  NSMutableDictionary*dict=[NSMutableDictionary new];
    [dict setValue:tell forKey:@"telNo"];
    [dict setValue:password forKey:@"password"];
      [[BaseRequest sharedInstance] request:kLoginUrl parameters:dict success:^(id responseObject) {
       // NSLog(@"会员信息%@",responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            if (responseObject[@"result"]==nil)
            {
                return ;
            }
            [ZMUser userInstance].isLogin=YES;
            NSMutableDictionary*dic=responseObject[@"result"];
            NSMutableDictionary*infoDic=[NSMutableDictionary dictionaryWithDictionary:dic];
            [infoDic setObject:password forKey:@"password"];
            [self writeToCachePath:infoDic];
           
        [self.navigationController popToRootViewControllerAnimated:YES];
            
        } else {
        [SVProgressHUD showErrorWithStatus:responseObject[@"result"]];
            
        }
    } failure:^(NSError *error) {
        //[SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", [error localizedDescription]]];
    }];
    
    
}
- (void)writeToCachePath:(id)cacheData {
    NSString *path = [HomeDirectory stringByAppendingString:kUserInfoPath];
    [cacheData writeToFile:path atomically:YES];
}
@end
