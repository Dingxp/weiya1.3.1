//
//  EducationWebViewController.m
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/12/18.
//  Copyright © 2015年 mx. All rights reserved.
//

#import "EducationWebViewController.h"

@interface EducationWebViewController ()

@end

@implementation EducationWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(245, 50, 109);;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationItem.title = @"微芽教程";
    self.view.backgroundColor=[UIColor whiteColor];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - self.navigationController.navigationBar.bottom)];
    [self.view addSubview:self.webView];
    [self loadWebViewByUrlString:self.education.linkUrl];
}
- (void) loadWebViewByUrlString:(NSString *) urlStr{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", urlStr]];
    //    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.baidu.com/"]];
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3. 发送请求给服务器
    [self.webView loadRequest:request];
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
