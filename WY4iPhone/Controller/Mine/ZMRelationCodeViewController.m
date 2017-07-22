//
//  ZMRelationCodeViewController.m
//  WY4iPhone
//
//  Created by ZM21 on 15/10/6.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMRelationCodeViewController.h"

@interface ZMRelationCodeViewController (){
    UIButton *btnSave;
    NSDictionary *resultRelationshipCode;
    ZMUser*user;
}

@end

@implementation ZMRelationCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationItem.title = @"分享码";
    self.view.backgroundColor = BaseBackViewRGB;
    self.navigationController.navigationBar.translucent = NO;
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    user=[ZMUser userWithDict:userDic];    [self initView];
}

- (void) initView{
    _textFieldCode = [[UITextField alloc] initWithFrame:CGRectMake(0, 10, self.view.width, 46)];
    _textFieldCode.placeholder = @"请输入分享码";
    _textFieldCode.backgroundColor = [UIColor whiteColor];
    _textFieldCode.text = user.sjwsInvitCode;
    _textFieldCode.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_textFieldCode];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    _textFieldCode.leftView = leftView;
    _textFieldCode.leftViewMode = UITextFieldViewModeAlways;
    _textFieldCode.delegate = self;
    
    UILabel *tips = [[UILabel alloc] initWithFrame:CGRectMake(10, _textFieldCode.bottom + 10, self.view.width - 10*2, 16)];
    tips.font = [UIFont systemFontOfSize:14];
    tips.textColor = [UIColor blackColor];
    tips.text = @"分享码一旦填写，不可修改";
    [self.view addSubview:tips];
    
    btnSave = [[UIButton alloc] initWithFrame:CGRectMake(10, tips.bottom + 20, self.view.width - 10*2, 45)];
    btnSave.layer.cornerRadius = 5;
    [btnSave setTitle:@"保存" forState:UIControlStateNormal];
    btnSave.backgroundColor = [UIColor lightGrayColor];
    btnSave.titleLabel.font = [UIFont systemFontOfSize:14];
    [btnSave addTarget:self action:@selector(btnSaveClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnSave.enabled = NO;
    [self.view addSubview:btnSave];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    btnSave.backgroundColor = RGBCOLOR(255, 0, 90);
    btnSave.enabled = YES;
    return YES;
}

- (void) btnSaveClicked:(UIButton *)button{
    if ([_textFieldCode.text isEmpty]) {
        return;
    }
    
    [self requestApplyToWSByRegUserId:user.userId telNo:user.telNo inviteCode:_textFieldCode.text];
    }

/**
 *  添加邀请码,已注册的普通用户,获得了邀请码要申请成为微商
 *
 *  @param regUserId  会员id
 *  @param telNo      手机号，即账号
 *  @param inviteCode 邀请码
 */
- (void) requestApplyToWSByRegUserId:(NSString *)regUserId telNo:(NSString *)telNo inviteCode:(NSString *)inviteCode{
    NSString *url = @"wbusi/wbusiinfo/wbusiinfo/applyToWbusi.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:regUserId forKey:@"regUserId"];
    [params setValue:telNo forKey:@"telNo"];
    [params setValue:inviteCode forKey:@"inviteCode"];
    btnSave.userInteractionEnabled=NO;
    btnSave.backgroundColor = [UIColor lightGrayColor];
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        //NSLog(@"relation ship code:%@", responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            resultRelationshipCode = responseObject[@"result"];
            [SVProgressHUD showSuccessWithStatus:@"保存成功"];
            [self requestUserInfoByUserId:user.userId];
            
        } else {
            [SVProgressHUD showErrorWithStatus:@"保存失败"];
        }
        btnSave.userInteractionEnabled=YES;
        btnSave.backgroundColor = RGBCOLOR(255, 0, 90);
    } failure:^(NSError *error) {
//        NSLog(@"Error: %@", [error localizedDescription]);
        btnSave.userInteractionEnabled=YES;
        btnSave.backgroundColor = RGBCOLOR(255, 0, 90);

    }];
}
// 根据会员ID读取基本信息
- (void) requestUserInfoByUserId:(NSString *)userId{
    NSString *url = @"app/crm/reguser/findRegUserAndWsxxById.do";
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:userId forKey:@"regUserId"];
    NSString *cachePath = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath];
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        //NSLog(@"User info :%@", responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            NSString*passWord=[dict objectForKey:@"password"];
            NSMutableDictionary*dic=responseObject[@"result"];
            NSMutableDictionary*infoDic=[NSMutableDictionary dictionaryWithDictionary:dic];
            [infoDic setObject:passWord forKey:@"password"];
            [self writeToCachePath:infoDic];
            [self.navigationController popToRootViewControllerAnimated:YES];

        }
        //        NSLog(@"user info:%@", responseObject);
    } failure:^(NSError *error) {
        //        NSLog(@"request user info error:%@", [error localizedDescription]);
    }];
}

//数据写入缓存
- (void)writeToCachePath:(id)cacheData {
    NSString *path = [HomeDirectory stringByAppendingString:kUserInfoPath];
    [cacheData writeToFile:path atomically:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
