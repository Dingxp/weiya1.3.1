//
//  ZMChannelDetailViewController.m
//  WY4iPhone
//
//  Created by ZM21 on 15/10/8.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMChannelDetailViewController.h"
#import "ZMChannelItem.h"
@interface ZMChannelDetailViewController ()
{
    ZMChannelItem*zmChannelItem;
}
@end

@implementation ZMChannelDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BaseBackViewRGB;
    self.navigationItem.title = _cItem.channelItemName;
    
    [self initView];
    [self loadData];
}

- (void) initView{
    if ([_cItem.showType integerValue] == 2) {// web显示
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - self.navigationController.navigationBar.bottom)];
        [self.view addSubview:self.webView];
        [self loadWebViewByUrlString:_cItem.webUrl];
    } else if([_cItem.showType integerValue] == 1){
        
    }
    
}

- (void) loadData{
    [self requestChannelDetailByChannelItemId:_cItem.channelItemId];
}

- (void) loadWebViewByUrlString:(NSString *) urlStr{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", urlStr]];
    //    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.baidu.com/"]];
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3. 发送请求给服务器
    [self.webView loadRequest:request];
}

/**
 *  根据频道项ID查询该频道项下面的商品列表,查询某个活动下包含的明细列表
 *
 *  @param cItemId 频道项ID
 */
- (void) requestChannelDetailByChannelItemId:(NSString *) cItemId{
   // NSString *url = @"app/crm/channel/v1.2.0/findCtxByCiId.do";
    NSString*url=[NSString stringWithFormat:@"app/crm/channel/%@/findCtxByCiId.do",ppVersion];

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:cItemId forKey:@"cItemId"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
       // NSLog(@"channel item:%@", responseObject);
    } failure:^(NSError *error) {
//        NSLog(@"error:%@", [error localizedDescription]);
    }];
}


@end
