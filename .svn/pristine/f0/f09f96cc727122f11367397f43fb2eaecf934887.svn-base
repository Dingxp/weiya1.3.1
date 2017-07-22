//
//  ZMRetOrderListViewController.m
//  WY4iPhone
//
//  Created by ZM21 on 15/10/3.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMRetOrderListViewController.h"
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

@interface ZMRetOrderListViewController () <ToBePayDelegate>{
    UIView *viewNoOrder;
    long curSelectedIndex;
}

@end

@implementation ZMRetOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"退款中";
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
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
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.backgroundColor = RGBCOLOR(240, 240, 240);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void) loadData{
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
   ZMUser* user=[ZMUser userWithDict:userDic];
    [self requestWaitPayOrderByRegUserId:user.userId];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _returnOrderList.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZMOrder *order = _returnOrderList[indexPath.row];
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
    cell.btnPay.tag = indexPath.row;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 187;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZMOrderDetailViewController *orderDetailVC = [[ZMOrderDetailViewController alloc] init];
    orderDetailVC.order = _returnOrderList[indexPath.row];
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
//        NSLog(@"result shiped order list:%@", responseObject[@"result"][@"result"]);
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
                    NSMutableArray *orderList = [[NSMutableArray alloc] init];
                    for (NSDictionary *dict in orders) {
                        ZMOrder *order = [ZMOrder orderWithDictionary:dict];
                        [orderList addObject:order];
                    }
                    _returnOrderList = orderList;
                    
                    if (_returnOrderList.count <= 0) {
                        [self thereIsNoOrderToBePayTips];
                    } else {
                        [self initView];
                    }
                    
                    
                }
 
            }
           
        }
        
    } failure:^(NSError *error) {
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

- (void)toBePayTableViewCell:(ZMToBePayTableViewCell *)toBePayTableViewCell didSelectedAtIndex:(long)index{
    curSelectedIndex = index;
    //    ZMOrder *order = _shipedOrderList[index];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
