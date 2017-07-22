//
//  ZMPayFailedViewController.h
//  WY4iPhone
//
//  Created by ZM21 on 15/10/3.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMOrder.h"
#import "ZMOrderDetailTableViewCell.h"
#import "ZMOrderDetail.h"
#import "UIImageView+WebCache.h"
#import "BaseRequest.h"
#import <AlipaySDK/AlipaySDK.h>
#import "ZMPayFailedViewController.h"
#import "ZMPaySuccessViewController.h"
#import "ZMUser.h"

@interface ZMPayFailedViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZMOrder *order;
@property (nonatomic, strong) UILabel *labelOrderStatus;
@property (nonatomic, strong) NSString*payTapeName;
- (UIView *) tableHeaderView;
- (UIView *) tableFooterView;
//- (void) requestPayOrderStringByUserId:(NSString *)userId orderId:(NSString *)orderId;
- (void) btnPayClicked:(UIButton *)button;

@end
