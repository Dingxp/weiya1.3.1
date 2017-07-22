//
//  ZMPayFailFromConfirmOrderViewController.m
//  WY4iPhone
//
//  Created by ZM on 15/10/14.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMPayFailFromConfirmOrderViewController.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "ZMOrderDetails.h"
#import "ZMUser.h"
#import "DoPayProTypeViewController.h"
@interface ZMPayFailFromConfirmOrderViewController ()
{
    ZMOrderDetails*orderDetails;
    NSString*proAmonut;
    ZMUser*user;
    NSString*orderNum;
}
@end

@implementation ZMPayFailFromConfirmOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    user=[ZMUser userWithDict:userDic];
    [self requestOrderDetailsByOrderId:_orderId userId:user.userId];
    
  
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 禁用 iOS7 返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
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
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _orderDetails.items.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 46;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 46;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self tableHeaderView];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [self tableFooterView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZMOrderDetail *orderDetail = _orderDetails.items[indexPath.row];
    static NSString *identified = @"payFailedCell";
    ZMOrderDetailTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identified];
    if (!cell) {
        cell = [[ZMOrderDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identified];
    }
    [cell.imgViewHead sd_setImageWithURL:[NSURL URLWithString:orderDetail.httpImgUrl]];
    cell.labelProductName.text = orderDetail.proName;
    cell.labelPrice.text = [NSString stringWithFormat:@"￥%@", orderDetail.price];
    cell.labelCount.text = [NSString stringWithFormat:@"x%@", orderDetail.quantity];
    return cell;
}

/**
 *  初始化UITableView的headView
 */
- (UIView *) tableHeaderView{
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 46)];
    tableHeaderView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableHeaderView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableHeaderView.width, 1)];
    line.backgroundColor = RGBCOLOR(231, 231, 231);
    [tableHeaderView addSubview:line];
    
    UILabel *lbOrderNum = [[UILabel alloc] initWithFrame:CGRectMake(10, line.bottom + 15, 70, 14)];
    lbOrderNum.font = [UIFont systemFontOfSize:14];
    lbOrderNum.text = @"订单状态：";
    lbOrderNum.textColor = RGBCOLOR(161, 161, 161);
    [tableHeaderView addSubview:lbOrderNum];
    
    UILabel *labelOrderNum = [[UILabel alloc] initWithFrame:CGRectMake(lbOrderNum.right + 20, lbOrderNum.top, tableHeaderView.width - 10 * 2 - 20 - lbOrderNum.width, 14)];
    labelOrderNum.font = [UIFont systemFontOfSize:14];
    labelOrderNum.textColor = RGBCOLOR(66, 66, 66);
    [tableHeaderView addSubview:labelOrderNum];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(line.left, lbOrderNum.bottom + 15, line.width, line.height)];
    line1.backgroundColor = RGBCOLOR(231, 231, 231);
    [tableHeaderView addSubview:line1];
    
    switch ([_orderDetails.orderState integerValue]) {
        case 0:// 已取消
            labelOrderNum.text = @"已取消";
            break;
        case 1:// 待审核
            labelOrderNum.text = @"待审核";
            break;
        case 2:// 待发货
            labelOrderNum.text = @"待发货";
            break;
        case 3:// 已发货
            labelOrderNum.text = @"已发货";
            break;
        case 5:// 退货中
            labelOrderNum.text = @"退货中";
            break;
        case 6:// 待退款
            labelOrderNum.text = @"待退款";
            break;
        case 4:// 已完成
            labelOrderNum.text = @"已完成";
            break;
        case 7:// 已退款
            labelOrderNum.text = @"已退款";
            break;
            
        default:
            break;
    }
    
    return tableHeaderView;
}

/**
 *  初始化UITableView的footerView
 *
 *  @return
 */
- (UIView *) tableFooterView{
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 46)];
    tableFooterView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableFooterView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableFooterView.width, 1)];
    line.backgroundColor = RGBCOLOR(231, 231, 231);
    [tableFooterView addSubview:line];
    
    UILabel *lbOrderPrice = [[UILabel alloc] initWithFrame:CGRectMake(10, line.bottom + 15, 70, 14)];
    lbOrderPrice.font = [UIFont systemFontOfSize:14];
    lbOrderPrice.text = @"订单价格：";
    lbOrderPrice.textColor = RGBCOLOR(161, 161, 161);
    [tableFooterView addSubview:lbOrderPrice];
    
    UILabel *labelOrderPrice = [[UILabel alloc] initWithFrame:CGRectMake(lbOrderPrice.right + 20, lbOrderPrice.top, tableFooterView.width - 10 * 2 - 20 - lbOrderPrice.width, 14)];
    labelOrderPrice.font = [UIFont systemFontOfSize:14];
    labelOrderPrice.textColor = RGBCOLOR(252, 0, 95);
    labelOrderPrice.text = [NSString stringWithFormat:@"￥%@", _orderDetails.amount];
    proAmonut=labelOrderPrice.text;
    [tableFooterView addSubview:labelOrderPrice];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(line.left, lbOrderPrice.bottom + 15, line.width, line.height)];
    line1.backgroundColor = RGBCOLOR(231, 231, 231);
    [tableFooterView addSubview:line1];
    
    return tableFooterView;
}
//订单详情
- (void) requestOrderDetailsByOrderId:(NSString *)oId userId:(NSString *)userId{
    NSString *url = @"app/order/order/findOrderItemList.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:oId forKey:@"orderId"];
    [params setValue:userId forKey:@"regUserId"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        NSLog(@"Order detail real response object: %@", responseObject[@"result"]);
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            NSDictionary *dict = responseObject[@"result"];
            orderDetails = [ZMOrderDetails orderDetailsWithDictionary:dict];
            orderNum=responseObject[@"result"][@"orderNum"];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        //NSLog(@"error:%@", [error localizedDescription]);
    }];
    
}


- (void)btnPayClicked:(UIButton *)button{
    DoPayProTypeViewController*payVC=[[DoPayProTypeViewController alloc]init];
    payVC.dingdanID=_orderId;
    payVC.proAmount=proAmonut;
    payVC.orderNum=orderNum;
    [self.navigationController pushViewController:payVC animated:YES];
}

@end
