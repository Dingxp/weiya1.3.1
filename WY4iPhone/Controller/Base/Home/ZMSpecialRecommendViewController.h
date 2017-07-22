//
//  ZMSpecialRecommendViewController.h
//  WY4iPhone
//
//  Created by ZM21 on 15/9/13.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChannelItem.h"
#import "BaseRequest.h"
#import "ZMSpecRecommendTableViewCell.h"
#import "ZMSpecRecDetailViewController.h"

/**
 *  专题推荐，,后面做了修改，用品牌的collectioncell（ProListViewController）进行显示
 */
@interface ZMSpecialRecommendViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ChannelItem *banner;
@property (nonatomic, strong) UIWebView *webView;

@end
