//
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/11/23.
//  Copyright © 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChannelItem.h"
#import "ZMProduct.h"
@interface BandListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UIAlertViewDelegate>
@property(strong,nonatomic)ZMProduct*product;
@property(strong,nonatomic)ChannelItem*cItem;
@property(strong,nonatomic)UITableView*tableView;
@property(strong,nonatomic)NSMutableArray*specialArr;
@property (strong,nonatomic)NSDictionary*arraySpceialProDict;
@property (strong, nonatomic) NSArray *examples;
@end
