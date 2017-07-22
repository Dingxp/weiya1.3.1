//
//  WYAHomeViewController.h
//  WY4iPhone
//
//  Created by mx on 15/8/31.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADFocusImageView.h"
#import "WYHomeTableViewCell02.h"
#import "ZMChannelDetailViewController.h"
#import "WYHomeTableViewCell01.h"
#import "WYHomeTableViewCell03.h"
#import "WYHomeTableViewCell04.h"
#import "WYTableViewCell05.h"
#import "WYTableViewCell06.h"
#import "ZMEntrepreneurshipViewController2.h"
#import "ZMBrandViewController.h"
#import "ZMFashionViewController.h"
#import "ZMRecommendViewController.h"
#import "ZMSpecialRecommendViewController.h"
#import "BaseRequest.h"
#import "ChannelItem.h"
#import "ZMTodayRecommend.h"
#import "ZMProduct.h"
#import "ZMUser.h"
#import "ZMShoppingCart.h"
#import "ProDetailViewController.h"
#import "ZMThemeViewController.h"
#import "ZMTodayRecDetailViewController.h"
#import "MJRefresh.h"
#import "ProListViewController.h"
#import "ZMBrandItemViewController.h"

@interface WYAHomeViewController : UIViewController <ADFoucsDelegate, UITableViewDelegate, UITableViewDataSource, WYHomeTableViewCell02Delegate,UIScrollViewDelegate>

@property (nonatomic, strong) ADFocusImageView *loopingView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray*scrollArray;
@property (nonatomic, strong) NSArray*Array;

@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UIScrollView*scrollView;
@property (strong, nonatomic) NSArray *examples;

@end
