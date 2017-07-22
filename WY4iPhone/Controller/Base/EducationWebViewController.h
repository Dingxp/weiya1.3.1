//
//  EducationWebViewController.h
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/12/18.
//  Copyright © 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMEducation.h"
@interface EducationWebViewController : UIViewController
@property(nonatomic,strong)ZMEducation*education;
@property (strong, nonatomic)UIWebView*webView;

@end
