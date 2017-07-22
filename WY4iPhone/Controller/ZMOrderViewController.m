//
//  ZMOrderViewController.m
//  WY4iPhone
//
//  Created by ZM21 on 15/9/14.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMOrderViewController.h"
#import "ZMPaySuccessFromConfirmViewController.h"
#import "ZMPayFailFromConfirmOrderViewController.h"
#import "DoPayProTypeViewController.h"
@interface ZMOrderViewController (){
    BaseRequest *baseRequest;
    ZMUser *user;
    long curSelectedCellIndex;
    NSMutableArray *orderList;
    
    NSDictionary *orderDict;
    NSString*Order;
}

@end

@implementation ZMOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"全部订单";
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    baseRequest = [BaseRequest sharedInstance];
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    user=[ZMUser userWithDict:userDic];
    
    [self initView];
    [self loadData];
    
}
//友盟
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
    //创建表
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - self.navigationController.navigationBar.bottom) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = RGBCOLOR(240, 240, 240);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //刷新
    _tableView.header = [MJRefreshNormalHeader  headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];    
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreOrder)];
    [self.view addSubview:_tableView];
}

- (void) loadData{
    _tableView.footer.hidden = NO;
    [self requestOrderListByRegUserId:user.userId];
}

/**
 *  请求更多数据
 *  hasNext = 1 有下一页 =0 表示没有下一页
 */
- (void) moreOrder{
    if ([orderDict[@"hasNext"] integerValue] == 1) {// 有下一页
        [self requestMoreOrderListByRegUserId:user.userId startPage:orderDict[@"nextPage"]];
    } else {
        [_tableView.footer endRefreshing];
        _tableView.footer.hidden = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [self requestOrderListByRegUserId:user.userId];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return orderList.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZMOrder *order = orderList[indexPath.row];
    ZMOrderDetail *orderDetail = order.items[0];
    static NSString *identified = @"orderCell";
    
    ZMOrderTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:identified];
    if (!cell) {
        cell = [[ZMOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identified];
    }
    [cell.imgViewHead sd_setImageWithURL:[NSURL URLWithString:orderDetail.httpImgUrl]];
    
    CGFloat h = [orderDetail.proName commonStringHeighforLabelWidth:cell.labelProductName.frame.size.width withFontSize:15];
    cell.labelProductName.text = orderDetail.proName;
    CGRect frame = cell.labelProductName.frame;
    frame.size.height = h;
    cell.labelProductName.frame = frame;
    [cell.btnPay addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnPay.tag = indexPath.row;
    
//    NSLog(@"pay status:%@, order status:%@", order.payState, order.orderState);
    
    if ([order.payState integerValue] == 0) {// 未支付
        cell.labelOrderStatus.text = @"未支付";
        if ([order.orderState integerValue] == 0) {// 已取消
            cell.btnPay.hidden = YES;
        } else {
            cell.btnPay.hidden = NO;
            cell.btnPay.layer.borderColor = RGBCOLOR(248, 153, 179).CGColor;
            [cell.btnPay setTitleColor:RGBCOLOR(248, 153, 179) forState:UIControlStateNormal];
            [cell.btnPay setTitle:@"去支付" forState:UIControlStateNormal];
        }
    } else if([order.payState integerValue] == 1) {// 已支付
        cell.btnPay.hidden = NO;
        cell.btnPay.layer.borderColor = RGBCOLOR(248, 153, 179).CGColor;
        [cell.btnPay setTitleColor:RGBCOLOR(248, 153, 179) forState:UIControlStateNormal];
        switch ([order.orderState integerValue]) {
            case 0:// 已取消
                cell.labelOrderStatus.text = @"已取消";
                cell.btnPay.hidden = YES;
                break;
            case 1:// 待审核
                cell.labelOrderStatus.text = @"待审核";
                cell.btnPay.hidden = YES;
                break;
            case 2:// 待发货
                cell.labelOrderStatus.text = @"待发货";
                cell.btnPay.hidden = YES;
                break;
            case 3:// 已发货
                cell.labelOrderStatus.text = @"已发货";
                [cell.btnPay setTitle:@"确认收货" forState:UIControlStateNormal];
                break;
            case 5:// 退货中
                cell.labelOrderStatus.text = @"退货中";
                [cell.btnPay setTitle:@"查看物流" forState:UIControlStateNormal];
                [cell.btnPay setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                cell.btnPay.layer.borderColor = [UIColor lightGrayColor].CGColor;
                break;
            case 6:// 待退款
                cell.labelOrderStatus.text = @"待退款";
                break;
            case 4:// 已完成
                cell.labelOrderStatus.text = @"已完成";
                [cell.btnPay setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                cell.btnPay.layer.borderColor = [UIColor lightGrayColor].CGColor;
                [cell.btnPay setTitle:@"查看物流" forState:UIControlStateNormal];
                break;
            case 7:// 已退款
                cell.labelOrderStatus.text = @"已退款";
                cell.btnPay.hidden = YES;
                break;
                
            default:
                break;
        }
    }  else if([order.payState integerValue] == 2){// 支付失败
        cell.labelOrderStatus.text = @"支付失败";
        cell.btnPay.hidden = YES;
    }
    
    
    cell.labelRealPrice.text = [NSString stringWithFormat:@"￥%@", order.amount];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else
        return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 186;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //跳到详情页
    ZMOrderDetailViewController *orderDetailVC = [[ZMOrderDetailViewController alloc] init];
    orderDetailVC.order = orderList[indexPath.row];
    [self.navigationController pushViewController:orderDetailVC animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  查询所有订单
 *
 *  @param regUserId 会员ID
 */
- (void) requestOrderListByRegUserId:(NSString *)regUserId{
    NSString *url = @"app/order/order/findAllOrderList.do";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:regUserId forKey:@"regUserId"];
    
    [baseRequest request:url parameters:params success:^(id responseObject) {
        [_tableView.header endRefreshing];
//        NSLog(@"order list:%@", responseObject[@"result"]);
        if ([responseObject[@"statu"] isEqualToString:@"false"]) {
            return ;
        }
        if (responseObject[@"result"]==nil)
             {
                 return;
        }
        if ( [responseObject[@"result"] isKindOfClass:[NSDictionary class]])
        {
            NSDictionary*resDic=responseObject[@"result"];
            NSArray*arr=[resDic allKeys];
            if ([arr containsObject:@"result"])
            {
                if (responseObject[@"result"][@"result"]==nil)
                {
                    return;
                }
                orderDict = responseObject[@"result"];
                NSArray *orderArray = responseObject[@"result"][@"result"];
                //NSLog(@"+++%@",orderArray);
                self.arr=orderArray;
                if (orderArray.count==0)
                {
                    
                   UILabel*tipsEmpty = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - self.navigationController.navigationBar.bottom - self.tabBarController.tabBar.height)];
                        tipsEmpty.textAlignment = NSTextAlignmentCenter;
                        tipsEmpty.text = @"目前还没有订单!";
                        tipsEmpty.textColor = RGBCOLOR(102, 102, 102);
                        [self.view addSubview:tipsEmpty];
                }
                NSMutableArray *orders = [[NSMutableArray alloc] init];
                for (NSDictionary *dict in orderArray) {
                    ZMOrder *order = [ZMOrder orderWithDictionary:dict];
                    [orders addObject:order];
                }
                orderList = orders;
                //        NSLog(@"order list count:%ld", orderList.count);
                [_tableView reloadData];
        }
        
        }
        

        
    } failure:^(NSError *error) {
//        NSLog(@"Order list request error :%@", [error localizedDescription]);
    }];
}

/**
 *  查询更多订单
 *
 *  @param regUserId 会员ID
 *  @param startPage 页吗
 */
- (void) requestMoreOrderListByRegUserId:(NSString *)regUserId startPage:(NSString *)startPage{
    NSString *url = @"app/order/order/findAllOrderList.do";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:regUserId forKey:@"regUserId"];
    [params setValue:startPage forKey:@"startPage"];
    
    [baseRequest request:url parameters:params success:^(id responseObject) {
        //        NSLog(@"order list:%@", responseObject[@"result"]);
        [_tableView.footer endRefreshing];
        if ([responseObject[@"statu"] isEqualToString:@"false"]) {
            return ;
        }
        if (responseObject[@"result"]==nil)
        {
            return;
        }
        if ( [responseObject[@"result"] isKindOfClass:[NSDictionary class]])
        {
            NSDictionary*resDic=responseObject[@"result"];
            NSArray*arr=[resDic allKeys];
            if ([arr containsObject:@"result"])
            {
                if (responseObject[@"result"][@"result"]==nil)
                {
                    return;
                }
                orderDict = responseObject[@"result"];
                NSArray *orderArray = responseObject[@"result"][@"result"];
                NSMutableArray *orders = [[NSMutableArray alloc] init];
                for (NSDictionary *dict in orderArray) {
                    ZMOrder *order = [ZMOrder orderWithDictionary:dict];
                    [orders addObject:order];
                }
                [orderList addObjectsFromArray:orders];
                //        NSLog(@"order list count:%ld", orderList.count);
                [_tableView reloadData];
                
   
        }
                }

       
    } failure:^(NSError *error) {
        [_tableView.footer endRefreshing];
//        NSLog(@"Order list request error :%@", [error localizedDescription]);
    }];
}

- (void) btnClicked:(UIButton *)button{
    curSelectedCellIndex = button.tag;
    ZMOrder *order = orderList[curSelectedCellIndex];
    Order=order.orderId;
    NSDictionary*dict=self.arr[button.tag];
    _orderDetails = [ZMOrderDetails orderDetailsWithDictionary:dict];
    if ([button.titleLabel.text isEqualToString:@"去支付"]) {
        //跳转支付页面
        DoPayProTypeViewController*payVC=[[DoPayProTypeViewController alloc]init];
        payVC.dingdanID=order.orderId;
        payVC.proAmount=order.amount;
        payVC.orderNum=order.orderNum;
        [self.navigationController pushViewController:payVC animated:YES];
        
    } else if ([button.titleLabel.text isEqualToString:@"确认收货"]){
        UIAlertView *receiveOrderAlert = [[UIAlertView alloc] initWithTitle:@"确认收货" message:@"请您收到商品后再确认付款，是否确认付款？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [receiveOrderAlert show];
        receiveOrderAlert.delegate = self;
    } else if ([button.titleLabel.text isEqualToString:@"查看物流"]){
        ZMCheckLogisticsViewController *logisticsVC = [[ZMCheckLogisticsViewController alloc] init];
        logisticsVC.order = order;
        [self.navigationController pushViewController:logisticsVC animated:YES];
    }
}
- (void)setResultOrderArray:(NSArray *)resultOrderArray{
    _resultOrderArray = resultOrderArray;
    [orderList addObjectsFromArray:_resultOrderArray];
    [_tableView reloadData];
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
        if ([responseObject[@"statu"] isEqualToString:@"true"]) {
            // 确认收货成功，刷新订单列表
            [self loadData];
        }
    } failure:^(NSError *error) {
//        NSLog(@"error: %@", [error localizedDescription]);
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    ZMOrder *order = orderList[curSelectedCellIndex];
    if (buttonIndex == 0) {// 取消
       
    } else if (buttonIndex == 1){// 确定
        [self requestReceiveOrderByRegUserId:user.userId orderId:order.orderId telNo:user.telNo];
    }
}

@end
