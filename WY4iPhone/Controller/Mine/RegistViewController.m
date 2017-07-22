//
//  RegistViewController.m
//  WY4iPhone
//
//  Created by 旭朋  丁 on 15/9/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "RegistViewController.h"
#import "RegistNextViewController.h"
#import <SMS_SDK/SMS_SDK.h>
#import "BaseRequest.h"
@interface RegistViewController (){
    UITextField *phoneNumber;
    UIButton *getCodeButton;
}

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationItem.title = @"注册";
    self.view.backgroundColor = BaseBackViewRGB;
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.navigationController.navigationBar.translucent = NO;
    [self _initView];
}

- (void)_initView
{
    phoneNumber = [[UITextField alloc]initWithFrame:CGRectMake(0, 10, APP_SCREEN_WIDTH, 45)];
    phoneNumber.placeholder = @"请输入电话号码";
    phoneNumber.backgroundColor = [UIColor whiteColor];
    phoneNumber.keyboardType = UIKeyboardTypeNumberPad;
    phoneNumber.font = [UIFont systemFontOfSize:15];
    phoneNumber.returnKeyType = UIReturnKeyDone;
    phoneNumber.delegate = self;
    [self.view addSubview:phoneNumber];
    
    UIImageView *textFieldImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, phoneNumber.height)];
    textFieldImage.image = [UIImage imageNamed:@"mine_phone"];
    textFieldImage.contentMode = UIViewContentModeCenter;
    
    phoneNumber.leftView = textFieldImage;
    phoneNumber.leftViewMode = UITextFieldViewModeAlways;
    
    getCodeButton = [[UIButton alloc] initWithFrame:CGRectMake(10, phoneNumber.bottom + 20, APP_SCREEN_WIDTH - 20, 45)];
    getCodeButton.backgroundColor = BaseTintRGB;
    getCodeButton.layer.cornerRadius = 5;
    [getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    getCodeButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:getCodeButton];
    [getCodeButton addTarget:self action:@selector(registButton1) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)registButton1
{
    if ([phoneNumber.text isTelephone]) {
        RegistNextViewController *viewController = [[RegistNextViewController alloc]init];
        viewController.phoneNum = phoneNumber.text;
//        [self getConfirmCode];
        [self.navigationController pushViewController:viewController animated:YES];
    }else{
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
    }
}

/**
 *  获取验证码
 */
- (void) getConfirmCode{

    NSString *url = @"app/crm/smm/sendVerCode.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:phoneNumber.text forKey:@"telNo"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
       // [SVProgressHUD dismiss];
        NSLog(@"====%@",responseObject);
        
       
        if ([responseObject[@"statu"] isEqualToString:@"true"]) {
;
        }
    } failure:^(NSError *error) {
        //        NSLog(@"error:%@", [error localizedDescription]);
    }];

}

@end
