//
//  ZMToBePaidViewController.m
//  WY4iPhone
//
//  Created by ZM21 on 15/9/14.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMToBePaidViewController.h"
#import "ZMToBePayTableViewCell.h"
#import "BaseRequest.h"
#import "ZMUser.h"
#import "ZMOrder.h"
#import "UIImageView+WebCache.h"
#import "ZMOrderDetail.h"
#import <AlipaySDK/AlipaySDK.h>
#import "ZMOrderDetailViewController.h"
#import "ZMPayFailedViewController.h"
#import "ZMPaySuccessViewController.h"
#import "MJRefresh.h"
#import "ZMOrderDetails.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "ZMPayFailFromConfirmOrderViewController.h"
#import "ZMPaySuccessFromConfirmViewController.h"
#import "DoPayProTypeViewController.h"
@interface ZMToBePaidViewController () <ToBePayDelegate> {
    UIView *viewNoOrder;
    long curSelectedIndex;
    ZMOrderDetails*orderDetails;
    NSDictionary *orderDict;
    NSString *orderID;
    NSString*order1;
    ZMUser*user;
    
}

@end

@implementation ZMToBePaidViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"待付款";
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    user=[ZMUser userWithDict:userDic];
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
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self loadData];
}

- (void) initView{
    //创建单元格
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    _tableView.backgroundColor = RGBCOLOR(240, 240, 240);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    //刷新
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreOrder)];
}

- (void) loadData{
    
    _tableView.footer.hidden = NO;
    //查询待支付订单个数
    [self requestCountPayingByRegUserId:user.userId];
}

/**
 *  请求更多数据
 *  hasNext = 1 有下一页 =0 表示没有下一页
 */
- (void) moreOrder{
    if ([orderDict[@"hasNext"] integerValue] == 1) {// 有下一页
        [self requestMoreWaitPayOrderByRegUserId:user.userId startPage:orderDict[@"nextPage"]];
    } else {
        [_tableView.footer endRefreshing];
        _tableView.footer.hidden = YES;
    }
}
//几个区
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _toBePayOrderList.count;
}
//注册单元格
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZMOrder *order = _toBePayOrderList[indexPath.row];
    ZMOrderDetail *orderDetail = order.items[0];
    static NSString *identified = @"toBePayCell";
    ZMToBePayTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:identified];
    if (!cell) {
        cell = [[ZMToBePayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identified];
    }
    [cell.imgViewHead sd_setImageWithURL:[NSURL URLWithString:orderDetail.httpImgUrl]];
    cell.toBePayDelegate = self;
    cell.labelProductName.text = orderDetail.proName;
    cell.labelOrderStatus.text = @"待付款";
    cell.labelRealPrice.text = [NSString stringWithFormat:@"￥%@", order.amount];
    cell.labelPrice.text = [NSString stringWithFormat:@"￥%@", orderDetail.price];
    cell.labelCount.text = [NSString stringWithFormat:@"x%@", orderDetail.quantity];
    cell.btnPay.tag = indexPath.row;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 187;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZMOrderDetailViewController *orderDetailVC = [[ZMOrderDetailViewController alloc] init];
    orderDetailVC.order = _toBePayOrderList[indexPath.row];
    [self.navigationController pushViewController:orderDetailVC animated:YES];
}

/**
 *  查询待支付订单个数
 *
 *  @param regUserId 会员ID
 */
- (void) requestCountPayingByRegUserId:(NSString *)regUserId{
    NSString *url = @"app/order/order/countPaying.do";
    if (regUserId==nil)
    {
        return;
    }
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:regUserId forKey:@"regUserId"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        [_tableView.header endRefreshing];
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            int count = [responseObject[@"result"][@"count"] intValue];
            if (count <= 0) { // 显示当前没有订单
                [self thereIsNoOrderToBePayTips];
            } else { // 请求待支付订单列表
                [self initView];
                [self requestWaitPayOrderByRegUserId:user.userId];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

/**
 *  查询待支付订单列表
 *
 *  @param regUserId 会员ID
 */
- (void) requestWaitPayOrderByRegUserId:(NSString *)regUserId{
    NSString *url = @"/app/order/order/findWaitPayOrder.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:regUserId forKey:@"regUserId"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        NSLog(@"==%@",responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            if ( [responseObject[@"result"] isKindOfClass:[NSDictionary class]])
            {
                NSDictionary*resDic=responseObject[@"result"];
                NSArray*arr=[resDic allKeys];
                if ([arr containsObject:@"result"])
                {
                    if (responseObject[@"result"][@"result"]==nil)
                    {
                        return ;
                    }
                    orderDict = responseObject[@"result"];
                    NSArray *orders = responseObject[@"result"][@"result"];
                    self.arr=orders;
                    NSMutableArray *orderList = [[NSMutableArray alloc] init];
                    for (NSDictionary *dict in orders) {
                        ZMOrder *order = [ZMOrder orderWithDictionary:dict];
                        [orderList addObject:order];
                    }
                    _toBePayOrderList = orderList;
                    [_tableView reloadData];
                }
                
   
            }
            
        }
    } failure:^(NSError *error) {
//        NSLog(@"To be pay error:%@", [error localizedDescription]);
    }];
}

/**
 *  查询更多待支付订单列表
 *
 *  @param regUserId 会员ID
 */
- (void) requestMoreWaitPayOrderByRegUserId:(NSString *)regUserId startPage:(NSString *)startPage{
    NSString *url = @"/app/order/order/findWaitPayOrder.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:regUserId forKey:@"regUserId"];
    [params setValue:startPage forKey:@"startPage"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
//        NSLog(@"result to be pay list:%@", responseObject[@"result"][@"result"]);
        [_tableView.footer endRefreshing];
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            if ( [responseObject[@"result"] isKindOfClass:[NSDictionary class]])
            {
                NSDictionary*resDic=responseObject[@"result"];
                NSArray*arr=[resDic allKeys];
                if ([arr containsObject:@"result"])
                {
                    if (responseObject[@"result"][@"result"]==nil)
                    {
                        return ;
                    }
                    orderDict = responseObject[@"result"];
                    NSArray *orders = responseObject[@"result"][@"result"];
                    NSMutableArray *orderList = [[NSMutableArray alloc] init];
                    for (NSDictionary *dict in orders) {
                        ZMOrder *order = [ZMOrder orderWithDictionary:dict];
                        [orderList addObject:order];
                    }
                    [_toBePayOrderList addObjectsFromArray:orderList];
                    [_tableView reloadData];
                }
 
            }
            
            
        }
    } failure:^(NSError *error) {
        [_tableView.footer endRefreshing];
//        NSLog(@"To be pay error:%@", [error localizedDescription]);
    }];
}

/**
 *  提示当前没有订单
 *
 *  @return
 */
- (UIView *) thereIsNoOrderToBePayTips{
    viewNoOrder = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    viewNoOrder.backgroundColor = RGBCOLOR(240, 240, 240);
    [self.view addSubview:viewNoOrder];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((viewNoOrder.width - 23) / 2, (viewNoOrder.height - 21 - 18) / 2 , 23, 21)];
    imageView.image = [UIImage imageNamed:@"homepage_07"];
    [viewNoOrder addSubview:imageView];
    
    UILabel *labelTips = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.bottom + 20, viewNoOrder.width, 18)];
    labelTips.font = [UIFont systemFontOfSize:18];
    labelTips.text = @"当前没有订单";
    labelTips.textColor = [UIColor lightGrayColor];
    labelTips.textAlignment = NSTextAlignmentCenter;
    [viewNoOrder addSubview:labelTips];
    
    return viewNoOrder;
}
//去支付
- (void)toBePayTableViewCell:(ZMToBePayTableViewCell *)toBePayTableViewCell didSelectedAtIndex:(long)index{
    curSelectedIndex = index;
    ZMOrder *order = _toBePayOrderList[index];
    //跳转到支付页面
    DoPayProTypeViewController*payVC=[[DoPayProTypeViewController alloc]init];
    payVC.dingdanID=order.orderId;
    payVC.proAmount=order.amount;
    payVC.orderNum=order.orderNum;
    [self.navigationController pushViewController:payVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
