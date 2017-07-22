//
//  ZMShipedOrderViewController.m
//  WY4iPhone
//
//  Created by ZM21 on 15/10/3.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMShipedOrderViewController.h"
#import "ZMUser.h"
#import "ZMOrder.h"
#import "ZMOrderDetail.h"
#import "ZMToBePayTableViewCell.h"
#import "ZMOrderDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "BaseRequest.h"
#import <AlipaySDK/AlipaySDK.h>
#import "ZMPayFailedViewController.h"
#import "ZMPaySuccessViewController.h"
#import "MJRefresh.h"

/**
 *  查询物流按钮被隐藏cell.btnPay.hidden = YES;
 */
@interface ZMShipedOrderViewController () <ToBePayDelegate>{
    UIView *viewNoOrder;
    long curSelectedIndex;
    ZMUser*user;
    NSDictionary *orderDict;
}

@end

@implementation ZMShipedOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"待收货";
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    user=[ZMUser userWithDict:userDic];
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
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    _tableView.backgroundColor = RGBCOLOR(240, 240, 240);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreOrder)];
}

- (void) loadData{
    _tableView.footer.hidden = NO;
    [self requestWaitPayOrderByRegUserId:user.userId];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _shipedOrderList.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZMOrder *order = _shipedOrderList[indexPath.row];
    ZMOrderDetail *orderDetail = order.items[0];
    static NSString *identified = @"shipedOrderCell";
    ZMToBePayTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:identified];
    if (!cell) {
        cell = [[ZMToBePayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identified];
    }
    [cell.imgViewHead sd_setImageWithURL:[NSURL URLWithString:orderDetail.httpImgUrl]];
    cell.toBePayDelegate = self;
    cell.labelProductName.text = orderDetail.proName;
    cell.labelOrderStatus.text = @"已发货";
    cell.labelRealPrice.text = [NSString stringWithFormat:@"￥%@", order.amount];
    cell.labelPrice.text = [NSString stringWithFormat:@"￥%@", orderDetail.price];
    cell.labelCount.text = [NSString stringWithFormat:@"x%@", orderDetail.quantity];
//    [cell.btnPay setTitle:@"查看物流" forState:UIControlStateNormal];
    cell.btnPay.hidden = YES;
    [cell.btnPay setTitle:@"确认收货" forState:UIControlStateNormal];
    cell.btnPay.tag = indexPath.row;
    cell.btnPay.hidden = NO;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 187;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZMOrderDetailViewController *orderDetailVC = [[ZMOrderDetailViewController alloc] init];
    orderDetailVC.order = _shipedOrderList[indexPath.row];
    [self.navigationController pushViewController:orderDetailVC animated:YES];
}

/**
 *  查询已发货订单列表
 *
 *  @param regUserId 会员ID
 */
- (void) requestWaitPayOrderByRegUserId:(NSString *)regUserId{
    NSString *url = @"app/order/order/findShipedOrderList.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:regUserId forKey:@"regUserId"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        [_tableView.header endRefreshing];
//         NSLog(@"result shiped order list:%@", responseObject[@"result"][@"result"]);
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
                    NSArray *orders = responseObject[@"result"][@"result"];
                    orderDict = responseObject[@"result"];
                    NSMutableArray *orderList = [[NSMutableArray alloc] init];
                    for (NSDictionary *dict in orders) {
                        ZMOrder *order = [ZMOrder orderWithDictionary:dict];
                        [orderList addObject:order];
                    }
                    _shipedOrderList = orderList;
                    
                    if (_shipedOrderList.count <= 0) {
                        [self thereIsNoOrderToBePayTips];
                    } else {
                        [self initView];
                        //            [_tableView reloadData];
                    }
                    
                }
 
            }
            
        }
        } failure:^(NSError *error) {
//        NSLog(@"To be pay error:%@", [error localizedDescription]);
    }];
}

/**
 *  查询更多已发货订单列表
 *
 *  @param regUserId 会员ID
 */
- (void) requestMoreWaitPayOrderByRegUserId:(NSString *)regUserId startPage:(NSString *)startPage{
    NSString *url = @"app/order/order/findShipedOrderList.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:regUserId forKey:@"regUserId"];
    [params setValue:startPage forKey:@"startPage"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
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
                    NSArray *orders = responseObject[@"result"][@"result"];
                    orderDict = responseObject[@"result"];
                    NSMutableArray *orderList = [[NSMutableArray alloc] init];
                    for (NSDictionary *dict in orders) {
                        ZMOrder *order = [ZMOrder orderWithDictionary:dict];
                        [orderList addObject:order];
                    }
                    [_shipedOrderList addObjectsFromArray:orderList];
                    
                    if (_shipedOrderList.count <= 0) {
                        [self thereIsNoOrderToBePayTips];
                    } else {
                        [self initView];
                        //            [_tableView reloadData];
                    }
                    
                }
  
            }
           
                    }
    } failure:^(NSError *error) {
//        NSLog(@"To be pay error:%@", [error localizedDescription]);
        [_tableView.footer endRefreshing];
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

- (void)toBePayTableViewCell:(ZMToBePayTableViewCell *)toBePayTableViewCell didSelectedAtIndex:(long)index{
    curSelectedIndex = index;
    UIAlertView *receiveOrderAlert = [[UIAlertView alloc] initWithTitle:@"确认收货" message:@"请您收到商品后再确认付款，是否确认付款？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [receiveOrderAlert show];
    receiveOrderAlert.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  确认收货,会员对已经发货的订单进行确认收货处理
 *
 *  @param regUserId 会员id
 *  @param orderId   订单id
 *  @param telNo     账号
 */
- (void) requestReceiveOrderByRegUserId:(NSString *)regUserId orderId:(NSString *)orderId telNo:(NSString *)telNo{
    NSString *url = @"app/order/order/receiveOrder.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:regUserId forKey:@"regUserId"];
    [params setValue:orderId forKey:@"orderId"];
    [params setValue:telNo forKey:@"telNo"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            // 确认收货成功，刷新订单列表
            [self loadData];
        }
    } failure:^(NSError *error) {
//        NSLog(@"error: %@", [error localizedDescription]);
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    ZMOrder *order = _shipedOrderList[curSelectedIndex];
    if (buttonIndex == 0) {// 取消
        
    } else if (buttonIndex == 1){// 确定
        [self requestReceiveOrderByRegUserId:user.userId orderId:order.orderId telNo:user.telNo];
    }
}

@end
