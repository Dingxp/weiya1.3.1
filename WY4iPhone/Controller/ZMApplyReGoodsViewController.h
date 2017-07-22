//
//  ZMApplyReGoodsViewController.h
//  WY4iPhone
//
//  Created by ZM on 15/9/21.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMApplyReGoodsTableView.h"
#import "ZMOrder.h"
#import "ZMReturnGoodsViewController.h"

@interface ZMApplyReGoodsViewController : UIViewController <ZMApplyReGoodsTableViewDelegate>

@property (nonatomic, strong) ZMApplyReGoodsTableView *tableView;
@property (nonatomic, strong) ZMOrder *cancelOrder;
@property (nonatomic, strong) UIPickerView *pickViewReason;
@property (nonatomic, strong) UIView *pickerBackView;
@property (nonatomic, strong) UIToolbar *toolBar;

@end
