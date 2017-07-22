//
//  ZMUserInfoViewController.h
//  WY4iPhone
//
//  Created by ZM21 on 15/10/6.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMUser.h"
#import "ZMUpdateNickNameViewController.h"
#import "ZMRelationCodeViewController.h"

@interface ZMUserInfoViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UILabel *labelNickName;
@property (nonatomic, strong) UILabel *labelRelationCode;
@property (nonatomic, strong) UILabel*sexLab;
@property (strong, nonatomic) UILabel*birthDayLab;
@property (strong, nonatomic) UILabel*areLab;
@property (nonatomic, strong) UIDatePicker *birthdatePick;
@property (nonatomic, strong) UITextField *tfBirthDay;
@property (nonatomic, strong) UITextField *tfSex;
@property (strong, nonatomic) UILabel*adressLab;
@end
