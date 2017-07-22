//
//  ZMLogisticsViewController.m
//  WY4iPhone
//
//  Created by ZM21 on 15/9/16.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMLogisticsViewController.h"

@interface ZMLogisticsViewController ()

@end

@implementation ZMLogisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"物流详情";
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    
    [self initView];
    [self loadData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"PageOne"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"PageOne"];
}
- (void) initView{
    _tableView = [[ZMLogisticsDetialTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
}

- (void) loadData{
    NSArray *datas = @[@{@"status":@"已签收",@"time":@"2015-02-24"},
                       @{@"status":@"南京江宁公司正在派件",@"time":@"2015-02-24"},
                       @{@"status":@"物件已经打包，将要派送",@"time":@"2015-02-24"}];
    _tableView.datas = datas;
    _tableView.labelOrderNumber.text = _orderDetails.expressNum;
    _tableView.labelOrderCompany.text = _orderDetails.expressName;
    _tableView.labelOrderTime.text = _orderDetails.orderTime;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
