//
//  ZMUserInfoViewController.m
//  WY4iPhone
//
//  Created by ZM21 on 15/10/6.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMUserInfoViewController.h"
#import "ZMAddressViewController.h"
#import "WYAAddressManageViewController.h"
#import "ApplyShopViewController.h"
@interface ZMUserInfoViewController (){
    UIImageView *imgViewRight2;
    ZMUser *user;
    UIToolbar *toolBar;
    UILabel*requestLab;
    UIImageView *imgViewshopRight1;
    UIView*requestView;
    UILabel*requestLab1;
    UILabel*requestLab2;
    UILabel*requestLab3;
}

@end

@implementation ZMUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationItem.title = @"个人资料";
    self.view.backgroundColor = BaseBackViewRGB;
    NSString *cachePath = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithContentsOfFile:cachePath];
    user = [ZMUser userWithDict:dict];
    self.navigationController.navigationBar.translucent = NO;
    
    [self initView];
    [self loadData];
}

- (void) initView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 10, self.view.width, 250)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UILabel *lbNickName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 56, 44)];
    lbNickName.font = [UIFont systemFontOfSize:15];
    lbNickName.text = @"  昵称";
    [view addSubview:lbNickName];
    
    _labelNickName = [[UILabel alloc] initWithFrame:CGRectMake(lbNickName.right, lbNickName.top, self.view.width - lbNickName.width - 38, lbNickName.height)];
    _labelNickName.font = [UIFont systemFontOfSize:15];
    _labelNickName.textAlignment = NSTextAlignmentRight;
    _labelNickName.tag = 1;
    _labelNickName.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClicked:)];
    [_labelNickName addGestureRecognizer:tap];
    [view addSubview:_labelNickName];
    
    UIImageView *imgViewRight1 = [[UIImageView alloc] initWithFrame:CGRectMake( self.view.width - 28, (lbNickName.height - 13) / 2, 9, 13)];
    imgViewRight1.image = [UIImage imageNamed:@"mine_rightGray"];
    [view addSubview:imgViewRight1];
    
    //    CALayer *layer = [[CALayer alloc] init];
    //    layer.frame = CGRectMake(0, lbNickName.bottom, self.view.width, 1);
    //    layer.backgroundColor = RGBCOLOR(240, 240, 240).CGColor;
    //    [lbNickName.layer addSublayer:layer];
    UIView*line=[[UIView alloc]initWithFrame:CGRectMake(0, lbNickName.bottom  , APP_SCREEN_WIDTH, 1)];
    line.backgroundColor=RGBCOLOR(216, 216, 216);
    [view addSubview:line];
    UILabel *birth = [[UILabel alloc]initWithFrame:CGRectMake(0, lbNickName.bottom+1, 56,44)];
    birth.backgroundColor = [UIColor whiteColor];
    birth.font = [UIFont systemFontOfSize:15];
    // birth.textColor = [UIColor blackColor];
    birth.text = @"   生日";
    [view addSubview:birth];
    
    _tfBirthDay = [[UITextField alloc] initWithFrame:CGRectMake(birth.right, lbNickName.bottom+1, self.view.width - birth.width-27, 44)];
    _tfBirthDay.text = user.birthDay;
    _tfBirthDay.backgroundColor = [UIColor whiteColor];
    _tfBirthDay.tag = 1;
    _tfBirthDay.placeholder = @"请选择生日";
    _tfBirthDay.textAlignment=NSTextAlignmentRight;
    _tfBirthDay.delegate = self;
    [view addSubview:_tfBirthDay];
    //
    UIView*line1=[[UIView alloc]initWithFrame:CGRectMake(0, birth.bottom  , APP_SCREEN_WIDTH, 1)];
    line1.backgroundColor=RGBCOLOR(216, 216, 216);
    [view addSubview:line1];
    
    UILabel *sex = [[UILabel alloc]initWithFrame:CGRectMake(0, birth.bottom+1, 56, 44)];
    sex.backgroundColor = [UIColor whiteColor];
    sex.font = [UIFont systemFontOfSize:14];
    sex.textColor = [UIColor blackColor];
    sex.text = @"   性别";
    
    [view addSubview:sex];
    _sexLab=[[UILabel alloc]initWithFrame:CGRectMake(sex.right, birth.bottom+1, _tfBirthDay.width, sex.height)];
    _sexLab.textAlignment=NSTextAlignmentRight;
    _sexLab.backgroundColor=[UIColor whiteColor];
    _sexLab.userInteractionEnabled = YES;
    
    _sexLab.tag=4;
    [view addSubview:_sexLab];
    UIView*line2=[[UIView alloc]initWithFrame:CGRectMake(0, sex.bottom  , APP_SCREEN_WIDTH, 1)];
    line2.backgroundColor=RGBCOLOR(216, 216, 216);
    [view addSubview:line2];
    UIImageView *imgViewRight4 = [[UIImageView alloc] initWithFrame:CGRectMake( self.view.width - 28, (lbNickName.height - 13) / 2, 9, 13)];
    imgViewRight4.image = [UIImage imageNamed:@"mine_rightGray"];
    [_sexLab addSubview:imgViewRight4];
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClicked:)];
    [_sexLab addGestureRecognizer:tap4];
    
    
    _adressLab=[[UILabel alloc]initWithFrame:CGRectMake(0, line2.bottom, APP_SCREEN_WIDTH, 44)];
    _adressLab.text=@"  收货地址";
    _adressLab.font = [UIFont systemFontOfSize:14];
    _adressLab.userInteractionEnabled = YES;
    _adressLab.tag=3;
    [view addSubview:_adressLab];
    UIImageView *imgViewRight3 = [[UIImageView alloc] initWithFrame:CGRectMake( self.view.width - 28, (lbNickName.height - 13) / 2, 9, 13)];
    imgViewRight3.image = [UIImage imageNamed:@"mine_rightGray"];
    [_adressLab addSubview:imgViewRight3];
    UIView*line3=[[UIView alloc]initWithFrame:CGRectMake(0, _adressLab.bottom+1  , APP_SCREEN_WIDTH, 1)];
    line3.backgroundColor=RGBCOLOR(216, 216, 216);
    [view addSubview:line3];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClicked:)];
    [_adressLab addGestureRecognizer:tap3];
    if ([user.identity intValue]==2&&[user.sjwsInvitCode isEmpty])
    {
        CALayer *layer2 = [[CALayer alloc] init];
        layer2.frame = CGRectMake(0, line3.bottom-1, self.view.width, 1);
        layer2.backgroundColor = RGBCOLOR(240, 240, 240).CGColor;
        [lbNickName.layer addSublayer:layer2];
        view.frame=CGRectMake(0, 0, APP_SCREEN_WIDTH,line3.bottom-1);
    }
    else
    {
        UILabel *lbRelationCode = [[UILabel alloc] initWithFrame:CGRectMake(0, _adressLab.bottom + 1, lbNickName.width+30, lbNickName.height)];
        lbRelationCode.text = @"  上级分享码";
        lbRelationCode.font = [UIFont systemFontOfSize:15];
        [view addSubview:lbRelationCode];
        
        _labelRelationCode = [[UILabel alloc] initWithFrame:CGRectMake(lbRelationCode.right, lbRelationCode.top, _labelNickName.width, lbRelationCode.height)];
        _labelRelationCode.font = [UIFont systemFontOfSize:15];
        _labelRelationCode.text = user.sjwsInvitCode;
        _labelRelationCode.tag = 2;
        _labelRelationCode.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClicked:)];
        [_labelRelationCode addGestureRecognizer:tap2];
        _labelRelationCode.textAlignment = NSTextAlignmentRight;
        
        [view addSubview:_labelRelationCode];
        
        imgViewRight2 = [[UIImageView alloc] initWithFrame:CGRectMake( imgViewRight1.left, imgViewRight1.top + lbNickName.height, imgViewRight1.width, imgViewRight1.height)];
        imgViewRight2.image = [UIImage imageNamed:@"mine_rightGray"];
        [view addSubview:imgViewRight2];
        
        CALayer *layer2 = [[CALayer alloc] init];
        layer2.frame = CGRectMake(0, lbRelationCode.bottom, self.view.width, 1);
        layer2.backgroundColor = RGBCOLOR(240, 240, 240).CGColor;
        [lbNickName.layer addSublayer:layer2];
        view.frame=CGRectMake(0, 0, APP_SCREEN_WIDTH, _labelRelationCode.bottom+1);
        
    }
    UIView*line5=[[UIView alloc]initWithFrame:CGRectMake(0, view.bottom  , APP_SCREEN_WIDTH, 1)];
    line5.backgroundColor=RGBCOLOR(216, 216, 216);
    [self.view addSubview:line5];
    UILabel*shopLab=[[UILabel alloc]initWithFrame:CGRectMake(0, view.bottom+1, APP_SCREEN_WIDTH, 44)];
    shopLab.text=@"  店铺信息";
    shopLab.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:shopLab];
    UIView *shopView = [[UIView alloc] initWithFrame:CGRectMake(0, shopLab.bottom+1, APP_SCREEN_WIDTH, 50)];
    shopView.userInteractionEnabled=YES;
    shopView.tag=5;
    shopView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:shopView];
    UIView*line6=[[UIView alloc]initWithFrame:CGRectMake(0, shopLab.bottom  , APP_SCREEN_WIDTH, 1)];
    line6.backgroundColor=RGBCOLOR(216, 216, 216);
    [self.view addSubview:line6];
    UILabel*stateLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 50)];
    stateLab.text=@"  店铺状态";
    stateLab.font = [UIFont systemFontOfSize:18];
    [shopView addSubview:stateLab];
    requestLab=[[UILabel alloc]initWithFrame:CGRectMake(APP_SCREEN_WIDTH-85, 0, 70, 50)];
    requestLab.text=@"申请开店";
    requestLab.textColor=RGBCOLOR(245, 50, 109);
    requestLab.font = [UIFont systemFontOfSize:13];
    [shopView addSubview:requestLab];
    UIView*line7=[[UIView alloc]initWithFrame:CGRectMake(0, shopView.bottom  , APP_SCREEN_WIDTH, 1)];
    line7.backgroundColor=RGBCOLOR(216, 216, 216);
    [self.view addSubview:line7];
    imgViewshopRight1 = [[UIImageView alloc] initWithFrame:CGRectMake( self.view.width - 28, (shopView.height - 13) / 2, 9, 13)];
    imgViewshopRight1.image = [UIImage imageNamed:@"mine_rightGray"];
    [shopView addSubview:imgViewshopRight1];
    requestView=[[UIView alloc]initWithFrame:CGRectMake(0, shopView.bottom, APP_SCREEN_WIDTH, 50)];
    [self.view addSubview:requestView];
    requestLab1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 15)];
    requestLab1.text=@"  *当满足以下条件，下一天的凌晨则会成为店主";
    requestLab1.font=[UIFont systemFontOfSize:10];
    [requestView addSubview:requestLab1];
    requestLab2=[[UILabel alloc]initWithFrame:CGRectMake(0, requestLab1.bottom, APP_SCREEN_WIDTH, 15)];
    requestLab2.text=@"  1.填写上级分享吗";
    requestLab2.font=[UIFont systemFontOfSize:10];
    [requestView addSubview:requestLab2];
    requestLab3=[[UILabel alloc]initWithFrame:CGRectMake(0, requestLab2.bottom, APP_SCREEN_WIDTH, 15)];
    requestLab3.text=@"  2.购买芽客大礼包";
    requestLab3.font=[UIFont systemFontOfSize:10];
    [requestView addSubview:requestLab3];
    UITapGestureRecognizer *shoptap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClicked:)];
    [shopView addGestureRecognizer:shoptap];
    UIButton *confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(24, requestView.bottom+20, APP_SCREEN_WIDTH - 48, 54)];
    confirmButton.backgroundColor = BaseTintRGB;
    confirmButton.layer.cornerRadius = 5;
    [confirmButton setTitle:@"保存" forState:UIControlStateNormal];
    [self.view addSubview:confirmButton];
    [confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    if ([user.identity intValue]==2)
    {
        imgViewshopRight1.hidden=YES;
        requestLab.text=@"已成功";
        requestView.hidden=YES;
    }
    else
    {
        
        if ([user.isShoped integerValue]==1)
        {
            requestLab.text=@"申请中";
        }
        else if([user.isShoped integerValue]==0)
        {
            requestLab.text=@"申请开店";
        }
        
    }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag == 1) {// 生日
        if(!_birthdatePick) {
            _birthdatePick = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.height - 216, self.view.width, 216)];
            _birthdatePick.datePickerMode = UIDatePickerModeDate;
            _birthdatePick.accessibilityLanguage = @"Chinese";
            _birthdatePick.backgroundColor = RGBCOLOR(240, 240, 240);
            NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[user.birthDay doubleValue]];
            [_birthdatePick setDate:confromTimesp];
            [_birthdatePick addTarget:self action:@selector(changeBirthday:) forControlEvents:UIControlEventValueChanged];
            [self.view addSubview:_birthdatePick];
        }else {
            [_birthdatePick setHidden:NO];
        }
        [self showToolbar];
    } else if(textField.tag == 2){// 性别
        
    }
    return NO;
}

- (void)confirmButtonClick{
    //[self.navigationController popToRootViewControllerAnimated:YES];
    NSString*str;
    if ([_sexLab.text isEqualToString:@"男"])
    {
        str=@"1";
    }
    else if ([_sexLab.text isEqualToString:@"女"])
    {
        str=@"2";
    }
    else{
        str=nil;
    }
    
    [self requestUpdateUserInfoRegUserId:user.userId birthDay:_tfBirthDay.text imgStr:nil nickName:nil sex:str];
    
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
    [params setValue:birthDay forKey:@"birthDay"];
    //    [params setValue:imgStr forKey:@"imgStr"];
    //[params setValue:nickName forKey:@"nickName"];
    [params setValue:sex forKey:@"sex"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            [SVProgressHUD showSuccessWithStatus:responseObject[@"result"]];
            [[ZMUser userInstance] requestUserInfoByUserId:user.userId];
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"result"]];
        }
        //        NSLog(@"requestUpdateUserInfoRegUserId:%@", responseObject);
    } failure:^(NSError *error) {
        //        NSLog(@"error: %@", [error localizedDescription]);
    }];
}

- (void)showToolbar {
    if(!toolBar){
        toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.height - 216 - 44, self.view.width, 44)];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *comp = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(complete)];
        toolBar.items = @[space,comp];
        [self.view addSubview:toolBar];
    }else {
        toolBar.hidden = NO;
    }
}

#pragma mark - Action

- (void)complete
{
    _birthdatePick.hidden=YES;
    toolBar.hidden = YES;
}

//设置自己的生日
- (void)changeBirthday:(UIDatePicker *)picker
{
    NSDate *date = picker.date;
    user.birthDay = [self stringFromDate:date];
    _tfBirthDay.text = user.birthDay;
}

/**
 *  NSDate to NSString
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */
- (NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [dateFormatter setDateFormat:@"yyyy - MM - dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([user.sjwsInvitCode isEmpty] || user.sjwsInvitCode == NULL || user.sjwsInvitCode.length <= 0) {
        imgViewRight2.hidden = NO;
    } else {
        imgViewRight2.hidden = YES;
    }
}

- (void) loadData{
    _labelNickName.text = user.nickName;
    _labelRelationCode.text = user.sjwsInvitCode;
    _sexLab.text= user.sex;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%ld",buttonIndex);
    if (buttonIndex==0)
    {
        _sexLab.text=@"男";
    }
    if (buttonIndex==1)
    {
        _sexLab.text=@"女";
    }
    
}
- (void) itemClicked:(UITapGestureRecognizer *)tap{
    UIViewController *vc;
    if (tap.view.tag==1)
    {
        vc = [[ZMUpdateNickNameViewController alloc] init];
    }
    if (tap.view.tag==2)
    {
        if ([user.invitationCode isEmpty] || user.invitationCode == NULL || user.invitationCode.length <= 0) {
            vc = [[ZMRelationCodeViewController  alloc] init];
        }
    }
    if (tap.view.tag==3)
    {
        vc = [[WYAAddressManageViewController alloc] init];
    }
    if (tap.view.tag==4)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"性别" message:@"" delegate:self cancelButtonTitle:@"男" otherButtonTitles:@"女", nil];
        [alert show];
        alert.delegate = self;
    }
    if (tap.view.tag==5)
    {
        if ([user.identity intValue]==2)
        {
            return;
            
        }
        else
        {
            vc = [[ApplyShopViewController alloc] init];
        }
        
    }
    [self.navigationController pushViewController:vc animated:YES];
}

@end
