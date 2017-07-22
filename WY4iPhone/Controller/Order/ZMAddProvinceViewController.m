//
//  ZMAddProvinceViewController.m
//  WY4iPhone
//
//  Created by ZM21 on 15/9/27.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMAddProvinceViewController.h"
#import "ZMAddress.h"

@interface ZMAddProvinceViewController () <UIGestureRecognizerDelegate>{
    NSArray *arrayDatas;
}

@end

@implementation ZMAddProvinceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择省份";
    self.view.backgroundColor = RGBCOLOR( 240, 240, 240);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
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
    _tableView = [[ZMProvinceTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
}

- (void) loadData{
    arrayDatas = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle]
                                                     pathForResource:@"city.plist"
                                                     ofType:nil]];
    _tableView.provinceList = arrayDatas;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Method
- (void)back
{
    NSDictionary *result = arrayDatas[_tableView.curSelectedIndex.row];
    [ZMAddress addressInstance].addrProvince = result[@"state"];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
