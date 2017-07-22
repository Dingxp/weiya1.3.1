//
//  ZMCommDescriptionViewController.h
//  WY4iPhone
//
//  Created by ZM21 on 15/10/7.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  佣金说明
 */
@interface ZMCommDescriptionViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSString *urlStr;

@end
