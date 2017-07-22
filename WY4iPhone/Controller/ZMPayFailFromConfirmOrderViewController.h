//
//  ZMPayFailFromConfirmOrderViewController.h
//  WY4iPhone
//
//  Created by ZM on 15/10/14.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMPayFailedViewController.h"
#import "ZMOrderDetails.h"
#import "ZMPaySuccessFromConfirmViewController.h"

@interface ZMPayFailFromConfirmOrderViewController : ZMPayFailedViewController

@property (nonatomic, strong) ZMOrderDetails *orderDetails;
@property (nonatomic, strong) NSString *orderId;
//@property (nonatomic, strong) NSString*payTapeName;


@end
