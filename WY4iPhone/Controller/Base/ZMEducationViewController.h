//
//  ZMEducationViewController.h
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/12/18.
//  Copyright © 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMEducationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView*tableView;
@property (strong, nonatomic)NSMutableArray*educationArr;
@property (strong, nonatomic)UIWebView*webView;
@end
