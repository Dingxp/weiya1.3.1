//
//  MineInfoViewController.h
//  WY4iPhone
//
//  Created by 旭朋  丁 on 15/9/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMUser.h"
#import "BaseRequest.h"

@interface MineInfoViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) UIDatePicker *birthdatePick;
@property (nonatomic, strong) UITextField *tfBirthDay;
@property (nonatomic, strong) UITextField *tfSex;

@end
