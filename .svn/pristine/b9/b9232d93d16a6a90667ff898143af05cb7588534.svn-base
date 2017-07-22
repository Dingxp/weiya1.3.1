//
//  ZMOrderDetailViewController.m
//  WY4iPhone
//
//  Created by liang.pc on 15/9/15.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMOrderDetailViewController.h"
#import "ZMUser.h"
#import "BaseRequest.h"
#import "ZMOrderDetails.h"
#import <AlipaySDK/AlipaySDK.h>
#import "ZMPaySuccessViewController.h"
#import "ZMPayFailedViewController.h"
#import "ZMApplyReGoodsViewController.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "ZMPayFailFromConfirmOrderViewController.h"
#import "ZMPaySuccessFromConfirmViewController.h"
#import "DoPayProTypeViewController.h"
@interface ZMOrderDetailViewController () <ButtonClickedDelegate>{
    ZMUser *user;
    BaseRequest *baseRequest;
    ZMOrderDetails *orderDetails;
    NSString *orderID;
    UIView*bottomView;
}

@end

@implementation ZMOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单详情";
    //self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = barBtnItem;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    user=[ZMUser userWithDict:userDic];
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
    _tableView = [[ZMOrderDetailTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - self.navigationController.navigationBar.bottom) style:UITableViewStylePlain];
    _tableView.backgroundColor = RGBCOLOR(240, 240, 240);
    _tableView.datas = orderDetails.items;
    
    [self.view addSubview:_tableView];
   bottomView=[[UIView alloc]initWithFrame:CGRectMake(0,APP_SCREEN_HEIGHT-110, APP_SCREEN_WIDTH, 46)];
    bottomView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bottomView];
    CGFloat btnW = 90;
    CGFloat btnH = 29;
    UIView *line10 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 1)];
    line10.backgroundColor = RGBCOLOR(236, 236, 236);
    [bottomView addSubview:line10];
    _btnRefund = [[UIButton alloc] initWithFrame:CGRectMake(APP_SCREEN_WIDTH-200, 9, btnW, btnH)];
    _btnRefund.layer.borderWidth = 1;
    _btnRefund.layer.borderColor = RGBCOLOR(213, 213, 213).CGColor;
    [_btnRefund setTitle:@"申请退货" forState:UIControlStateNormal];
    _btnRefund.titleLabel.font = [UIFont systemFontOfSize:14];
    [_btnRefund setTitleColor:RGBCOLOR(213, 213, 213) forState:UIControlStateNormal];
    _btnRefund.layer.cornerRadius = 5;
    [_btnRefund addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:_btnRefund];
    _btnGoodsRecive = [[UIButton alloc] initWithFrame:CGRectMake(_btnRefund.right+10,9, btnW, btnH)];
    _btnGoodsRecive.layer.borderWidth = 1;
    _btnGoodsRecive.layer.borderColor = RGBCOLOR(247, 121, 157).CGColor;
    [_btnGoodsRecive setTitle:@"确认收货" forState:UIControlStateNormal];
    _btnGoodsRecive.titleLabel.font = [UIFont systemFontOfSize:14];
    [_btnGoodsRecive setTitleColor:RGBCOLOR(247, 121, 157) forState:UIControlStateNormal];
    _btnGoodsRecive.layer.cornerRadius = 5;
    [_btnGoodsRecive addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:_btnGoodsRecive];
  
}

/**
 *  加载数据
 */
- (void) loadData{
    baseRequest = [BaseRequest sharedInstance];
    //通过ID查询订单详情
    [self requestOrderDetailsByOrderId:_order.orderId userId:user.userId];
}

/**
 *  填充数据
 */
- (void) fillData{
    _tableView.bottomBtnView.hidden = NO;
    _tableView.btnRefund.hidden = NO;
    
    // 订单状态
    switch ([orderDetails.orderState integerValue]) {
        case 0://  已取消
            _tableView.labelOrderStatus.text = @"已取消";
            bottomView.hidden = YES;
            break;
        case 1:// 待审核
            _tableView.labelOrderStatus.text = @"待审核";
            _btnRefund.hidden = YES;
            _btnGoodsRecive.hidden = YES;
            break;
        case 2:// 待发货
            _tableView.labelOrderStatus.text = @"待发货";
            _btnRefund.hidden = YES;
            _btnGoodsRecive.hidden = YES;
            break;
        case 3:// 已发货
            _tableView.labelOrderStatus.text = @"已发货";
            [_btnGoodsRecive setTitle:@"确认收货" forState:UIControlStateNormal];
            [_btnRefund setTitle:@"申请退货" forState:UIControlStateNormal];
            break;
        case 5:// 退货中
            _tableView.labelOrderStatus.text = @"退货中";
            [_btnGoodsRecive setTitle:@"查看物流" forState:UIControlStateNormal];
            _btnRefund.hidden = YES;
            break;
        case 6:// 待退款
            _tableView.labelOrderStatus.text = @"待退款";
            break;
        case 4:// 已完成
            _tableView.labelOrderStatus.text = @"已完成";
            [_btnGoodsRecive setTitle:@"查看物流" forState:UIControlStateNormal];
            _btnRefund.hidden = YES;
            break;
        case 7:// 已退款
            _tableView.labelOrderStatus.text = @"已退款";
            _btnRefund.hidden = YES;
            _btnGoodsRecive.hidden = YES;
            break;
            
        default:
            break;
    }
    if ([orderDetails.payState integerValue] == 0) {// 未支付
        if([orderDetails.orderState integerValue] == 1){// 待审核
            _tableView.labelOrderStatus.text = @"待审核";
            [_btnRefund setTitle:@"取消订单" forState:UIControlStateNormal];
            [_btnGoodsRecive setTitle:@"立即支付" forState:UIControlStateNormal];
            _btnRefund.hidden = NO;
            _btnGoodsRecive.hidden = NO;
        }
    }
    
    // 物流状态
    switch ([orderDetails.shipState integerValue]) {
        case 1:// 未发货
            _tableView.labelLogisticsStatus.text = @"未发货";
            _tableView.labelLogisticsInfo.text = @"暂时无物流信息";
            break;
        case 2:// 已发货
            _tableView.labelLogisticsStatus.text = @"已发货";
            _tableView.labelLogisticsInfo.text = orderDetails.expressName;
            break;
        case 3:// 已退货
            _tableView.labelLogisticsStatus.text = @"已退货";
            break;
        case 4:// 部分退货，暂不使用
            _tableView.labelLogisticsStatus.text = @"部分退货";
            break;
        case 5:// 已签收
            _tableView.labelLogisticsStatus.text = @"已签收";
            break;
        case 6:// 退货中
            _tableView.labelLogisticsStatus.text = @"退货中";
            break;
            
        default:
            break;
    }
    _tableView.labelUserName.text = [NSString stringWithFormat:@"%@      %@", orderDetails.consignee, orderDetails.telNo];
    _tableView.labelAddress.text = [NSString stringWithFormat:@"%@%@%@%@", orderDetails.addrProvince, orderDetails.addrCity, orderDetails.addrArea, orderDetails.address];
    _tableView.labelPayBy.text = orderDetails.payTypeName;
    _tableView.labelCoupons.text = orderDetails.couponAmount;
    _tableView.labelShipping.text = [NSString stringWithFormat:@"￥%@", orderDetails.shipAmount];
    _tableView.labelOrderTime.text = orderDetails.orderTime;
    _tableView.labelRealPay.text = [NSString stringWithFormat:@"￥%@", orderDetails.amount];
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  通过ID查询订单详情
 *
 *  @param orderId 订单ID
 *  @param userId 会员ID
 */
- (void) requestOrderDetailsByOrderId:(NSString *)orderId userId:(NSString *)userId{
    NSString *url = @"app/order/order/findOrderItemList.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:orderId forKey:@"orderId"];
    [params setValue:userId forKey:@"regUserId"];
    
    [baseRequest request:url parameters:params success:^(id responseObject) {
       // NSLog(@"Order detail real response object: %@", responseObject[@"result"]);
         if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"])
         {
             NSDictionary *dict = responseObject[@"result"];
             // NSLog(@"--%@",responseObject[@"result"]);
             orderDetails = [ZMOrderDetails orderDetailsWithDictionary:dict];
             _tableView.orderDetails = orderDetails;
             [self fillData];
         }
         else{
             
         }
        
    } failure:^(NSError *error) {
//        NSLog(@"error:%@", [error localizedDescription]);
    }];
    
}

#pragma mark - ZMOrderDetailTableView buttonDelegate
- (void)btnClicked:(UIButton *)button{
    if ([button.titleLabel.text isEqualToString:@"立即支付"]) {
        //[self requestPayOrderStringByUserId:user.userId orderId:_order.orderId];
        DoPayProTypeViewController*payVC=[[DoPayProTypeViewController alloc]init];
        payVC.dingdanID=_order.orderId;
        payVC.proAmount=_order.amount;
        payVC.orderNum=_order.orderNum;
        [self.navigationController pushViewController:payVC animated:YES];
        
    } else if([button.titleLabel.text isEqualToString:@"取消订单"]){// 确定取消订单
        UIAlertView *receiveOrderAlert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"是否取消订单" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        receiveOrderAlert.tag=10;
        [receiveOrderAlert show];
        receiveOrderAlert.delegate = self;

    } else if([button.titleLabel.text isEqualToString:@"申请退货"]){
        ZMApplyReGoodsViewController *applyReGoodsVC = [[ZMApplyReGoodsViewController alloc] init];
        applyReGoodsVC.cancelOrder = _order;
        [self.navigationController pushViewController:applyReGoodsVC animated:YES];
    } else if ([button.titleLabel.text isEqualToString:@"确认收货"]){
        UIAlertView *receiveOrderAlert = [[UIAlertView alloc] initWithTitle:@"确认收货" message:@"请您收到商品后再确认付款，是否确认付款？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        receiveOrderAlert.tag=11;

        [receiveOrderAlert show];
        receiveOrderAlert.delegate = self;
    } else if([button.titleLabel.text isEqualToString:@"查看物流"]){
        ZMCheckLogisticsViewController *logisticsVC = [[ZMCheckLogisticsViewController alloc] init];
        logisticsVC.order = _order;
        [self.navigationController pushViewController:logisticsVC animated:YES];
    }
}
/**
 *  会员取消未付款、已付款未发货的订单
 *
 *  @param orderId   订单ID
 *  @param regUserId 会员ID
 *  @param telNo     账号
 */
- (void) requestCancelOrderByOrderId:(NSString *)orderId regUserId:(NSString *)regUserId telNo:(NSString *)telNo{
    NSString *url = @"app/order/order/cancelOrder.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:orderId forKey:@"orderId"];
    [params setValue:regUserId forKey:@"regUserId"];
    [params setValue:telNo forKey:@"telNo"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        if ([responseObject[@"statu"] isEqualToString:@"true"]) {
            [SVProgressHUD showSuccessWithStatus:responseObject[@"result"]];
        } else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"result"]];
        }
    } failure:^(NSError *error) {
//        NSLog(@"error:%@", [error localizedDescription]);
    }];
}

// 物流点击查看事件
- (void)logisticsViewClicked:(UITapGestureRecognizer *)tap{
    ZMCheckLogisticsViewController *logisticsVC = [[ZMCheckLogisticsViewController alloc] init];
    logisticsVC.order = _order;
    [self.navigationController pushViewController:logisticsVC animated:YES];
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
    if (alertView.tag==10)
    {
        if (buttonIndex == 1){// 确定
            // 会员取消未付款、已付款未发货的订单
        [self requestCancelOrderByOrderId:_order.orderId regUserId:user.userId telNo:user.telNo];
        [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else if (alertView.tag==11)
    {
        if (buttonIndex == 0) {// 取消
            
        } else if (buttonIndex == 1){// 确定
            //确认收货,会员对已经发货的订单进行确认收货处理
            [self requestReceiveOrderByRegUserId:user.userId orderId:_order.orderId telNo:user.telNo];
        }
    }
        
   
}

@end
