//
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/11/27.
//  Copyright © 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProCommTopListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView*tableView;
@property (nonatomic, strong) NSMutableArray*shopCount;
@end
