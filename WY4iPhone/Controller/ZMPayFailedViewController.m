//
//  ZMPayFailedViewController.m
//  WY4iPhone
//
//  Created by ZM21 on 15/10/3.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMPayFailedViewController.h"
#import "WYAHomeViewController.h"
#import "WXApi.h"
#import "WXApiObject.h"
@interface ZMPayFailedViewController ()

@end

@implementation ZMPayFailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"支付失败";
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    
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
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 禁用 iOS7 返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}



- (void) initView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - self.navigationController.navigationBar.bottom-50) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    

    UIView*view3=[[UIView alloc]initWithFrame:CGRectMake(0, APP_SCREEN_HEIGHT-114, APP_SCREEN_WIDTH, 50)];
    view3.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view3];
    UIButton*btn=[UIButton new];
    btn.frame=CGRectMake(10, 8, 100, 34);
    btn.layer.borderColor = RGBCOLOR(245, 50, 109).CGColor;
    btn.layer.cornerRadius=5;
    btn.layer.borderWidth = 1;
    //返回
    [btn setTitle:@"返回首页" forState:UIControlStateNormal];
    [btn setTitleColor:RGBCOLOR(245, 50, 109) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnBackToHomeClicked:) forControlEvents:UIControlEventTouchUpInside];
    [view3 addSubview:btn];
    //去支付按钮
    UIButton*paybtn=[UIButton new];
    paybtn.frame=CGRectMake(APP_SCREEN_WIDTH-150, 2, 140, 44);
    paybtn.layer.borderColor = [UIColor redColor].CGColor;
    paybtn.layer.borderWidth = 1;
    paybtn.layer.cornerRadius=5;
    
    [paybtn setTitle:@"立即支付" forState:UIControlStateNormal];
    [paybtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    paybtn.backgroundColor=RGBCOLOR(245, 50, 109);
    [paybtn addTarget:self action:@selector(btnPayClicked:) forControlEvents:UIControlEventTouchUpInside];
    [view3 addSubview:paybtn];
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
    
    _labelOrderStatus = [[UILabel alloc] initWithFrame:CGRectMake(lbOrderNum.right + 20, lbOrderNum.top, tableHeaderView.width - 10 * 2 - 20 - lbOrderNum.width, 14)];
    _labelOrderStatus.font = [UIFont systemFontOfSize:14];
    _labelOrderStatus.textColor = RGBCOLOR(66, 66, 66);
    [tableHeaderView addSubview:_labelOrderStatus];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(line.left, lbOrderNum.bottom + 15, line.width, line.height)];
    line1.backgroundColor = RGBCOLOR(231, 231, 231);
    [tableHeaderView addSubview:line1];
    
    switch ([_order.orderState integerValue]) {
        case 0:// 已取消
            _labelOrderStatus.text = @"已取消";
            break;
        case 1:// 待审核
            _labelOrderStatus.text = @"待审核";
            break;
        case 2:// 待发货
            _labelOrderStatus.text = @"待发货";
            break;
        case 3:// 已发货
            _labelOrderStatus.text = @"已发货";
            break;
        case 5:// 退货中
            _labelOrderStatus.text = @"退货中";
            break;
        case 6:// 待退款
            _labelOrderStatus.text = @"待退款";
            break;
        case 4:// 已完成
            _labelOrderStatus.text = @"已完成";
            break;
        case 7:// 已退款
            _labelOrderStatus.text = @"已退款";
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
    labelOrderPrice.text = [NSString stringWithFormat:@"￥%@", _order.amount];
    [tableFooterView addSubview:labelOrderPrice];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(line.left, lbOrderPrice.bottom + 15, line.width, line.height)];
    line1.backgroundColor = RGBCOLOR(231, 231, 231);
    [tableFooterView addSubview:line1];
    
    return tableFooterView;
}

- (void) loadData{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _order.items.count;
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
    ZMOrderDetail *orderDetail = _order.items[indexPath.row];
    static NSString *identified = @"payFailedCell";
    ZMOrderDetailTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:identified];
    if (!cell) {
        cell = [[ZMOrderDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identified];
    }
    [cell.imgViewHead sd_setImageWithURL:[NSURL URLWithString:orderDetail.httpImgUrl]];
    cell.labelProductName.text = orderDetail.proName;
    cell.labelPrice.text = [NSString stringWithFormat:@"￥%@", orderDetail.price];
    cell.labelCount.text = [NSString stringWithFormat:@"x%@", orderDetail.quantity];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) btnPayClicked:(UIButton *)button{
    //[self requestPayOrderStringByUserId:[ZMUser userInstance].userId orderId:_order.orderId];
}

- (void) btnBackToHomeClicked:(UIButton *)button{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end
