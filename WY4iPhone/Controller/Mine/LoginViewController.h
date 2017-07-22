//
//  LoginViewController.h
//  WY4iPhone
//
//  Created by 旭朋  丁 on 15/9/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZMBindAccountViewController;
@interface LoginViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, assign) BOOL isThird;
@property (nonatomic, strong) ZMBindAccountViewController*bindVC;
@end
