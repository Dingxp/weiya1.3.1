//
//  ZMCommissionViewController2.h
//  WY4iPhone
//
//  Created by ZM21 on 15/10/7.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMBindAccountViewController.h"
#import "ZMWithdrawalsAccountViewController.h"
#import "ZMCommissionDetailViewController.h"
#import "BaseRequest.h"
#import "ZMUser.h"
#import "LoginViewController.h"
#import "ZMWithdrawalsAccountViewController.h"
#import "ZMCommDescriptionViewController.h"

@interface ZMCommissionViewController2 : UIViewController

// 佣金
@property (nonatomic, strong) UILabel *labelCommission;
// 可提现
@property (nonatomic, strong) UILabel *labelWithdrawals;

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *labelTotalCommission;

// 上月入账
@property (nonatomic, strong) UILabel *labelLastMonthCount;
// 历史入账
@property (nonatomic, strong) UILabel *labelHistoryCount;
//待确认佣金
@property (nonatomic, strong) UILabel *queryMoneyLab;

//团队佣金
@property (nonatomic, strong) UILabel *teamMoneyLab;

@end
