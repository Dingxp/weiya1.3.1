//
//  ZMShortConfirmViewController.h
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/11/17.
//  Copyright © 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMShortConfirmViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView*tableView;
@property (nonatomic,strong)  NSArray*buyProList;
@end
