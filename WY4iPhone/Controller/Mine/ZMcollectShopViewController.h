//
//  ZMcollectShopViewController.h
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/11/19.
//  Copyright © 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMcollectShopViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSMutableArray*collectArray;
@property (strong,nonatomic)NSDictionary*arraySpceialProDict;
@end
