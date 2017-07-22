//
//  ZMSpecialRecommendViewController.m
//  WY4iPhone
//
//  Created by ZM21 on 15/9/13.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMSpecialRecommendViewController.h"

@interface ZMSpecialRecommendViewController () {
    NSArray *arrayResult;
}

@end

@implementation ZMSpecialRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _banner.channelItemName;
    self.view.backgroundColor =  RGBCOLOR(240, 240, 240);
    
    UIBarButtonItem *backBar = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = backBar;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    [self initView];
    [self loadData];
}

- (void) loadData{
    [self requestChannelDetailByChannelItemId:_banner.channelItemId];
}

- (void) initView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, self.view.width - 10 * 2, self.view.height - self.navigationController.navigationBar.bottom)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrayResult.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *resultProDetailDic = arrayResult[indexPath.row];
    
    static NSString *identified = @"cell";
    ZMSpecRecommendTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:identified];
    if (!cell) {
        cell = [[ZMSpecRecommendTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identified];
    }
    
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:resultProDetailDic[@"httpImgUrl"]]];
    cell.imgDesc.text = [NSString stringWithFormat:@"%@", resultProDetailDic[@"desc"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellImageHeigh + 10;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *result = arrayResult[indexPath.row];
    ZMSpecRecDetailViewController *spectRecDetailVC = [[ZMSpecRecDetailViewController alloc] init];
    spectRecDetailVC.specRecDict = result;
    [self.navigationController pushViewController:spectRecDetailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadWebViewByUrlString:(NSString *) urlStr{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", urlStr]];
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
//        NSLog(@"channel item:%@", responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            arrayResult = responseObject[@"result"];
            [_tableView reloadData];
        }
    } failure:^(NSError *error) {
//        NSLog(@"error:%@", [error localizedDescription]);
    }];
}

@end
