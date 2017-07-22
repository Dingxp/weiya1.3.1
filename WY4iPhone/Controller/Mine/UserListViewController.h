//
//  UserListViewController.h
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/12/28.
//  Copyright © 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView*tableView;
@property (strong,nonatomic)NSDictionary*arraySpceialProDict;

@end
