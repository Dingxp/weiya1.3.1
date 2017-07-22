//
//  ZMOrderViewController.h
//  WY4iPhone
//
//  Created by ZM21 on 15/9/14.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMOrderTableViewCell.h"
#import "ZMOrderDetailViewController.h"
#import "BaseRequest.h"
#import "ZMUser.h"
#import "ZMOrder.h"
#import "ZMOrderDetail.h"
#import "MJRefresh.h"
#import <AlipaySDK/AlipaySDK.h>
#import "ZMPaySuccessViewController.h"
#import "ZMPayFailedViewController.h"
#import "ZMOrderDetails.h"
#import "WXApiObject.h"
#import "WXApi.h"
@interface ZMOrderViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *resultOrderArray;
@property (nonatomic, copy) NSArray *arr;
@property (nonatomic, strong)ZMOrderDetails*orderDetails;
- (void) loadData;

@end
