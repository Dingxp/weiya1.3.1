//
//  ZMAboutQMCYViewController.m
//  WY4iPhone
//
//  Created by ZM21 on 15/10/7.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMAboutQMCYViewController.h"

@interface ZMAboutQMCYViewController ()

@end

@implementation ZMAboutQMCYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于全民创业";
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationItem.leftBarButtonItem = barItem;

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
    CGFloat webViewH = self.view.height - self.navigationController.navigationBar.bottom;
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, webViewH)];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
}

- (void) loadData{
    [self loadWebViewByUrlString:@"http://m.weiyar.com/webapp/aboutqmcy.html"];
}

- (void) loadWebViewByUrlString:(NSString *) urlStr{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", urlStr]];
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.baidu.com/"]];
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3. 发送请求给服务器
    [self.webView loadRequest:request];
}

- (void) webViewDidStartLoad:(UIWebView *)webView{

}

- (void) webViewDidFinishLoad:(UIWebView *)webView{

}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//     NSLog(@"error: %@", [error localizedDescription]);
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
