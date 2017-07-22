//
//  ZMOrderDetailViewController.h
//  WY4iPhone
//
//  Created by liang.pc on 15/9/15.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMOrderDetailTableView.h"
#import "ZMOrder.h"
#import "ZMLogisticsViewController.h"
#import "ZMCheckLogisticsViewController.h"

@interface ZMOrderDetailViewController : UIViewController <UIAlertViewDelegate>

@property (nonatomic, strong) ZMOrderDetailTableView *tableView;
@property (nonatomic, strong) ZMOrder *order;
@property (nonatomic, strong) UIButton *btnGoodsRecive;
@property (nonatomic, strong) UIButton *btnRefund;
@end
