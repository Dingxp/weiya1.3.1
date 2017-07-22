//
//  ZMBrandItemViewController.m
//  WY4iPhone
//
//  Created by ZM on 15/10/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMBrandItemViewController.h"

@interface ZMBrandItemViewController ()

@end

@implementation ZMBrandItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    
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
    [SVProgressHUD dismiss];
}

- (void)loadData{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

    


@end
