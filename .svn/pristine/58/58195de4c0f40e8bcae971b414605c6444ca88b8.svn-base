//
//  ForgotPasswordViewController2.m
//  WY4iPhone
//
//  Created by 旭朋  丁 on 15/9/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ForgotPasswordViewController2.h"
#import "ZMUser.h"
#import "BaseRequest.h"

@interface ForgotPasswordViewController2 (){
    UITextField *passwordTextField;
    UITextField *ConfirmPassword;
    UIButton *confirmButton;

}

@end

@implementation ForgotPasswordViewController2

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
    passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 10, APP_SCREEN_WIDTH, 45)];
    passwordTextField.placeholder = @"请输入旧密码";
    passwordTextField.backgroundColor = [UIColor whiteColor];
    passwordTextField.font = [UIFont systemFontOfSize:15];
    passwordTextField.returnKeyType = UIReturnKeyDone;
    passwordTextField.secureTextEntry = YES;
    passwordTextField.delegate = self;
    UIImageView *confirmImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, passwordTextField.height)];
    confirmImage.image = [UIImage imageNamed:@"mine_password"];
    confirmImage.contentMode = UIViewContentModeCenter;
    passwordTextField.leftView = confirmImage;
    passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:passwordTextField];
    
    CALayer *bottomLayer = [[CALayer alloc]init];
    bottomLayer.frame = CGRectMake(15, passwordTextField.height - 1, APP_SCREEN_WIDTH - 30, 1);
    bottomLayer.backgroundColor = RGBCOLOR(216, 216, 216).CGColor;
    [passwordTextField.layer addSublayer:bottomLayer];
    
    ConfirmPassword = [[UITextField alloc]initWithFrame:CGRectMake(0, passwordTextField.bottom, APP_SCREEN_WIDTH, 45)];
    ConfirmPassword.placeholder = @"请输入超过6位数字或字母的新密码";
    ConfirmPassword.backgroundColor = [UIColor whiteColor];
    ConfirmPassword.font = [UIFont systemFontOfSize:15];
    ConfirmPassword.returnKeyType = UIReturnKeyDone;
    ConfirmPassword.secureTextEntry = YES;
    ConfirmPassword.delegate = self;
    UIImageView *passwordFieldImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, ConfirmPassword.height)];
    passwordFieldImage.image = [UIImage imageNamed:@"mine_password"];
    passwordFieldImage.contentMode = UIViewContentModeCenter;
    ConfirmPassword.leftView = passwordFieldImage;
    ConfirmPassword.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:ConfirmPassword];
    
    confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(10, ConfirmPassword.bottom + 25, APP_SCREEN_WIDTH - 20, 45)];
    confirmButton.backgroundColor = BaseTintRGB;
    confirmButton.layer.cornerRadius = 5;
    confirmButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [self.view addSubview:confirmButton];
    [confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)confirmButtonClick
{
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
  ZMUser*user=[ZMUser userWithDict:userDic];
    confirmButton.userInteractionEnabled=NO;
    if ([passwordTextField.text isPassword] && [ConfirmPassword.text isPassword]) {
        [self requestModifiedPasswordByRegUserId:user.userId password:passwordTextField.text newPassword:ConfirmPassword.text];
        confirmButton.userInteractionEnabled=YES;
    }else{
        [SVProgressHUD showErrorWithStatus:@"密码格式不正确!"];
        confirmButton.userInteractionEnabled=YES;

    }
    

}

/**
 *  修改密码
 *
 *  @param regUserId   会员ID
 *  @param password    原密码
 *  @param newPassword 新密码
 */
- (void) requestModifiedPasswordByRegUserId:(NSString *)regUserId password:(NSString *)password newPassword:(NSString *)newPassword{
    NSString *url = @"app/crm/reguser/editPassword.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:regUserId forKey:@"regUserId"];
    [params setValue:password forKey:@"password"];
    [params setValue:newPassword forKey:@"newPassword"];
    NSString *cachePath = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath];

    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            [SVProgressHUD showSuccessWithStatus:responseObject[@"result"]];
            [userDic setObject:newPassword forKey:@"password"];
            [self writeToCachePath:userDic];
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"result"]];
        }
    } failure:^(NSError *error) {
//        NSLog(@"error:%@", [error localizedDescription]);
    }];
}
//数据写入缓存
- (void)writeToCachePath:(id)cacheData {
    NSString *path = [HomeDirectory stringByAppendingString:kUserInfoPath];
    [cacheData writeToFile:path atomically:YES];
}

@end
