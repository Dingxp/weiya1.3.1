//
//  ZMUpdateNickNameViewController.m
//  WY4iPhone
//
//  Created by ZM21 on 15/10/6.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMUpdateNickNameViewController.h"

@interface ZMUpdateNickNameViewController (){
    UIButton *btnSave;
    ZMUser*user;
}

@end

@implementation ZMUpdateNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationItem.title = @"修改昵称";
    self.view.backgroundColor = BaseBackViewRGB;
    self.navigationController.navigationBar.translucent = NO;
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    user=[ZMUser userWithDict:userDic];    [self initView];
}

- (void) initView{
    _textFieldNickName = [[UITextField alloc] initWithFrame:CGRectMake(0, 10, self.view.width, 46)];
    _textFieldNickName.placeholder = @"请输入昵称";
    _textFieldNickName.backgroundColor = [UIColor whiteColor];
    _textFieldNickName.text = user.nickName;
    _textFieldNickName.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_textFieldNickName];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    _textFieldNickName.leftView = leftView;
    _textFieldNickName.leftViewMode = UITextFieldViewModeAlways;
    _textFieldNickName.delegate = self;
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, _textFieldNickName.top, self.view.width, 1)];
    line1.backgroundColor = RGBCOLOR(216, 216, 216);
    [self.view addSubview:line1];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, _textFieldNickName.bottom, self.view.width, 1)];
    line2.backgroundColor = RGBCOLOR(216, 216, 216);
    [self.view addSubview:line2];
    
    btnSave = [[UIButton alloc] initWithFrame:CGRectMake(10, _textFieldNickName.bottom + 20, self.view.width - 10*2, 45)];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) btnSaveClicked:(UIButton *)button{
    if ([_textFieldNickName.text isEmpty]) {
        return;
    }
   
    [self requestUpdateUserInfoRegUserId:user.userId birthDay:user.birthDay imgStr:nil nickName:_textFieldNickName.text sex:user.sex];
}

/**
 *  修改用户信息
 *
 *  @param regUserId 会员ID
 *  @param birthDay  生日
 *  @param imgStr    图片流
 *  @param nickName  昵称
 *  @param sex       性别
 */
- (void) requestUpdateUserInfoRegUserId:(NSString *)regUserId birthDay:(NSString *)birthDay imgStr:(NSString *)imgStr nickName:(NSString *)nickName sex:(NSString *)sex{
    NSString *url = @"app/crm/reguser/updateRegUser.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:regUserId forKey:@"id"];
//    [params setValue:birthDay forKey:@"birthDay"];
//    [params setValue:imgStr forKey:@"imgStr"];
    [params setValue:nickName forKey:@"nickName"];
//    [params setValue:sex forKey:@"sex"];
    NSString *cachePath = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath];
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            [ZMUser userInstance].nickName = nickName;
            [SVProgressHUD showSuccessWithStatus:responseObject[@"result"]];
            [dict setObject:nickName forKey:@"nickName"];
            [self writeToCachePath:dict];
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"result"]];
        }
//        NSLog(@"requestUpdateUserInfoRegUserId:%@", responseObject);
    } failure:^(NSError *error) {
//        NSLog(@"error: %@", [error localizedDescription]);
    }];
}
- (void)writeToCachePath:(id)cacheData {
    NSString *path = [HomeDirectory stringByAppendingString:kUserInfoPath];
    [cacheData writeToFile:path atomically:YES];
}
@end
