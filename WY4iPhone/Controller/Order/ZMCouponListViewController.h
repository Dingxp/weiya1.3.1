//
//  ZMCouponListViewController.h
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/12/15.
//  Copyright © 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYAOrderConfirmViewController.h"
@interface ZMCouponListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView*tableView;
@property (strong, nonatomic) NSMutableArray*couponArray;
@property (strong,nonatomic) NSString*proAmount;
@property (strong,nonatomic) NSString*addressID;
@property (strong,nonatomic) NSArray*shopCatArr;
@property (nonatomic, strong) WYAOrderConfirmViewController*orderVC;
@end
