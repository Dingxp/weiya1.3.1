//
//  ForgotPasswordViewController.m
//  WY4iPhone
//
//  Created by 旭朋  丁 on 15/9/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "ForgotPasswordViewController1.h"
#import <SMS_SDK/SMS_SDK.h>
#import "Baserequest.h"

@interface ForgotPasswordViewController (){
    UITextField *phoneNumber;
    
    UITextField *codeTextField;
    NSTimer *countDownTimer;
    UILabel *timeFire;
    UIButton *getCheck;
    int secondsCountDown;

}

@end

@implementation ForgotPasswordViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    secondsCountDown = 60;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationItem.title = @"重置密码";
    self.view.backgroundColor = BaseBackViewRGB;
    [self _initTextField];
}

- (void)_initTextField{
    phoneNumber = [[UITextField alloc]initWithFrame:CGRectMake(0, 10, APP_SCREEN_WIDTH, 45)];
    phoneNumber.placeholder = @"请输入电话号码";
    phoneNumber.font = [UIFont systemFontOfSize:15];
    phoneNumber.backgroundColor = [UIColor whiteColor];
    phoneNumber.keyboardType = UIKeyboardTypeNumberPad;
    phoneNumber.returnKeyType = UIReturnKeyDone;
    phoneNumber.delegate = self;
    
    UIImageView *textFieldImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, phoneNumber.height)];
    textFieldImage.image = [UIImage imageNamed:@"mine_phone"];
    textFieldImage.contentMode = UIViewContentModeCenter;
    [phoneNumber addSubview:textFieldImage];
    phoneNumber.leftView = textFieldImage;
    phoneNumber.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:phoneNumber];
    
    CALayer *bottomLayer = [[CALayer alloc]init];
    bottomLayer.frame = CGRectMake(15, phoneNumber.height - 1, APP_SCREEN_WIDTH - 30, 1);
    bottomLayer.backgroundColor = RGBCOLOR(216, 216, 216).CGColor;
    [phoneNumber.layer addSublayer:bottomLayer];
    
    codeTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, phoneNumber.bottom, APP_SCREEN_WIDTH, 45)];
    codeTextField.placeholder = @"请输入收到的验证码";
    codeTextField.backgroundColor = [UIColor whiteColor];
    codeTextField.font = [UIFont systemFontOfSize:15];
    codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    codeTextField.returnKeyType = UIReturnKeyDone;
    codeTextField.delegate = self;
    UIImageView *codeImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, codeTextField.height)];
    codeImage.image = [UIImage imageNamed:@"mine_info"];
    codeImage.contentMode = UIViewContentModeCenter;
    codeTextField.leftView = codeImage;
    codeTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:codeTextField];
    
    getCheck = [[UIButton alloc]initWithFrame:CGRectMake(APP_SCREEN_WIDTH - 97 - 15, (codeTextField.height- 28) / 2, 97, 28)];
    getCheck.layer.borderColor = BaseTintRGB.CGColor;
    getCheck.layer.borderWidth = 1;
    [getCheck setTitleColor:BaseTintRGB forState:UIControlStateNormal];
    getCheck.titleLabel.font = [UIFont systemFontOfSize:15];
    [getCheck setTitle:@"获取验证码" forState:UIControlStateNormal];
    getCheck.layer.cornerRadius = 5;
    [getCheck addTarget:self action:@selector(timeleft) forControlEvents:UIControlEventTouchUpInside];
    [codeTextField addSubview:getCheck];
    
    timeFire = [[UILabel alloc]initWithFrame:getCheck.frame];
    timeFire.text = @"倒计时60秒";
    timeFire.textAlignment = NSTextAlignmentCenter;
    timeFire.font = [UIFont systemFontOfSize:15];
    timeFire.layer.borderWidth = 1;
    timeFire.layer.borderColor = BaseTintRGB.CGColor;
    timeFire.layer.cornerRadius = 5;
    timeFire.textColor = BaseTintRGB;
    timeFire.backgroundColor = [UIColor whiteColor];
    timeFire.hidden = YES;
    [codeTextField addSubview:timeFire];
    
    UIButton *confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(10, codeTextField.bottom + 25, APP_SCREEN_WIDTH - 20, 45)];
    confirmButton.backgroundColor = BaseTintRGB;
    confirmButton.layer.cornerRadius = 5;
    confirmButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [confirmButton setTitle:@"下一步" forState:UIControlStateNormal];
    [self.view addSubview:confirmButton];
    [confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)timeleft
{
    timeFire.hidden = NO;
    getCheck.userInteractionEnabled = NO;
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    [self getConfirmCode];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)confirmButtonClick
{
    timeFire.hidden = YES;
    getCheck.hidden = NO;
    secondsCountDown = 60;
    [countDownTimer invalidate];
    if (!codeTextField.text) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码！"];
        return;
    }
   
    NSString *url1 = @"app/crm/smm/checkVerCode.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:phoneNumber.text forKey:@"telNo"];
    [params setValue:codeTextField.text forKey:@"vCode"];
    [[BaseRequest sharedInstance] request:url1 parameters:params success:^(id responseObject) {
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"])
        {
                        ForgotPasswordViewController1 *viewController = [[ForgotPasswordViewController1 alloc]init];
                        viewController.phoneNum = phoneNumber.text;
                        [self.navigationController pushViewController:viewController animated:YES];

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
            
        }
    } failure:^(NSError *error) {
        //        NSLog(@"error:%@", [error localizedDescription]);
    }];

}

@end
