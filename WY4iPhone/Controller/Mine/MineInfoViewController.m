//
//  MineInfoViewController.m
//  WY4iPhone
//
//  Created by 旭朋  丁 on 15/9/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "MineInfoViewController.h"

@interface MineInfoViewController (){
    ZMUser *user;
    UIToolbar *toolBar;
}

@end

@implementation MineInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    user=[ZMUser userWithDict:userDic];
    [self initNav];
    [self initTableView];
}

- (void)initNav
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationItem.title = @"个人资料";
    self.view.backgroundColor = BaseBackViewRGB;
    self.navigationController.navigationBar.translucent = NO;
}

-(void)initTableView
{
    UILabel *head = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 85)];
    head.backgroundColor = [UIColor whiteColor];
    head.font = [UIFont systemFontOfSize:14];
    head.textColor = [UIColor blackColor];
    head.text = @"   头像";
    [self.view addSubview:head];
    
    UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectMake(APP_SCREEN_WIDTH  - 38 - 62, (head.height - 62) / 2, 62, 62)];
    if ([user.headPic isEmpty] || user.headPic == NULL) {
        headImage.image = [UIImage imageNamed:@"mine_headPH"];
    } else {
        [headImage sd_setImageWithURL:[NSURL URLWithString:user.headPic]];
    }
    [self.view addSubview:headImage];
    
    UIImageView *right = [[UIImageView alloc]initWithFrame:CGRectMake(APP_SCREEN_WIDTH - 18 - 20, (head.height - 18) / 2, 18, 18)];
    right.image = [UIImage imageNamed:@"mine_rightGray"];
    right.contentMode = UIViewContentModeRight;
    [self.view addSubview:right];

    
    CALayer *bottomLayer = [[CALayer alloc]init];
    bottomLayer.frame = CGRectMake(0, head.height - 1, APP_SCREEN_WIDTH, 1);
    bottomLayer.backgroundColor = RGBCOLOR(216, 216, 216).CGColor;
    [self.view.layer addSublayer:bottomLayer];
    
    UILabel *birth = [[UILabel alloc]initWithFrame:CGRectMake(0, head.bottom, 56, 50)];
    birth.backgroundColor = [UIColor whiteColor];
    birth.font = [UIFont systemFontOfSize:14];
    birth.textColor = [UIColor blackColor];
    birth.text = @"   生日";
    [self.view addSubview:birth];
    
    _tfBirthDay = [[UITextField alloc] initWithFrame:CGRectMake(birth.right, head.bottom, self.view.width - birth.width, birth.height)];
    _tfBirthDay.text = user.birthDay;
    _tfBirthDay.backgroundColor = [UIColor whiteColor];
    _tfBirthDay.tag = 1;
    _tfBirthDay.placeholder = @"请选择生日";
    _tfBirthDay.delegate = self;
    [self.view addSubview:_tfBirthDay];
    
    CALayer *bottomLayer1 = [[CALayer alloc]init];
    bottomLayer1.frame = CGRectMake(0, birth.bottom - 1, APP_SCREEN_WIDTH, 1);
    bottomLayer1.backgroundColor = RGBCOLOR(216, 216, 216).CGColor;
    [self.view.layer addSublayer:bottomLayer1];
    
    UILabel *sex = [[UILabel alloc]initWithFrame:CGRectMake(0, birth.bottom, 56, 50)];
    sex.backgroundColor = [UIColor whiteColor];
    sex.font = [UIFont systemFontOfSize:14];
    sex.textColor = [UIColor blackColor];
    sex.text = @"   性别";
    [self.view addSubview:sex];
    
    _tfSex = [[UITextField alloc] initWithFrame:CGRectMake(sex.right, birth.bottom, _tfBirthDay.width, sex.height)];
    _tfSex.backgroundColor = [UIColor whiteColor];
    _tfSex.text = user.sex;
    _tfSex.tag = 2;
    _tfSex.placeholder = @"请输入男或者女";
    _tfSex.delegate = self;
    [self.view addSubview:_tfSex];
    
    CALayer *bottomLayer2 = [[CALayer alloc]init];
    bottomLayer2.frame = CGRectMake(0, sex.bottom - 1, APP_SCREEN_WIDTH, 1);
    bottomLayer2.backgroundColor = RGBCOLOR(216, 216, 216).CGColor;
    [self.view.layer addSublayer:bottomLayer2];
    
    UIButton *confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(24, sex.bottom + 25, APP_SCREEN_WIDTH - 48, 54)];
    confirmButton.backgroundColor = BaseTintRGB;
    confirmButton.layer.cornerRadius = 5;
    [confirmButton setTitle:@"保存" forState:UIControlStateNormal];
    [self.view addSubview:confirmButton];
    [confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)confirmButtonClick{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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

@end
