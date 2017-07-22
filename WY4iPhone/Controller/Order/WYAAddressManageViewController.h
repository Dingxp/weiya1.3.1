//
//  WYAAddressManageViewController.h
//  WY4iPhone
//
//  Created by zhuwei on 15/9/13.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYAAddressListCell.h"
#import "BaseRequest.h"
#import "ZMUser.h"
#import "ZMAddress.h"
#import "ZMAddAddressViewController.h"
#import "MJRefresh.h"
#import "WYAOrderConfirmViewController.h"

@interface WYAAddressManageViewController : UIViewController <UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSIndexPath *curSelectedIndex;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *addAddressButton;
@property (nonatomic, strong) WYAOrderConfirmViewController*orderVC;
@property (nonatomic, strong) NSDictionary *viewDicts;
@property (nonatomic, strong) NSMutableArray *addressList;

- (void) loadData;

@end
