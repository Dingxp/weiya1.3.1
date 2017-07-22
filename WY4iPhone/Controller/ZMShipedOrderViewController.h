//
//  ZMShipedOrderViewController.h
//  WY4iPhone
//
//  Created by ZM21 on 15/10/3.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  已发货
 */
@interface ZMShipedOrderViewController : UIViewController <UITableViewDelegate, UITableViewDataSource , UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *shipedOrderList;

@end
