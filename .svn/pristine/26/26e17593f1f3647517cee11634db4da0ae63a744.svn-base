//
//  ZMCheckLogisticsViewController.m
//  WY4iPhone
//
//  Created by ZM on 15/10/14.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMCheckLogisticsViewController.h"

@interface ZMCheckLogisticsViewController ()

@end

@implementation ZMCheckLogisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"查看物流";
    self.view.backgroundColor = BaseBackViewRGB;
    
    [self initView];
    [self loadWebUrlByType:_order.expressCode postid:_order.expressNum callbackurl:nil];
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
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - self.navigationController.navigationBar.bottom)];
    [self.view addSubview:_webView];
}

/**
 *  同过快递100查看物流
 *
 *  @param type        要查询的快递公司的代码，支持中文和模糊输入
 *  @param postid      要查询的快递单号，请勿带特殊符号，不支持中文（大小写不敏感）
 *  @param callbackurl 在查询结果页面点击"返回"时跳转的地址，让用户查询后能返回原来的网站或APP
 */
- (void) loadWebUrlByType:(NSString *)type postid:(NSString *)postid callbackurl:(NSString *)callbackurl{
    NSString *urlStr = [kKuaiDi100BaseUrl stringByAppendingFormat:@"type=%@&postid=%@", type, postid];
    if (![callbackurl isEmpty] && callbackurl != NULL && callbackurl.length > 0) {
        urlStr = [urlStr stringByAppendingString:callbackurl];
    }
    NSURL *url = [NSURL URLWithString:urlStr];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
