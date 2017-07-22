//
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/11/26.
//  Copyright © 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChannelItem.h"


@interface SpeRecListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) ChannelItem *cItem;
@property (nonatomic, strong) UITableView*tableView;
@property (strong, nonatomic) NSArray *examples;

@end
