//
//  ZMReturnGoodsViewController.h
//  WY4iPhone
//
//  Created by ZM21 on 15/9/16.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseRequest.h"
#import "ZMOrder.h"
#import "ZMUser.h"

@interface ZMReturnGoodsViewController : UIViewController

@property (nonatomic, strong) ZMOrder *order;
@property (nonatomic, strong) NSArray *orderList;

@end
