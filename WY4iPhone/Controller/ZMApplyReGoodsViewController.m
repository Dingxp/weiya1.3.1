//
//  ZMApplyReGoodsViewController.m
//  WY4iPhone
//
//  Created by ZM on 15/9/21.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMApplyReGoodsViewController.h"
#import "BaseRequest.h"
#import "ZMUser.h"

@interface ZMApplyReGoodsViewController () <UIPickerViewDelegate, UIPickerViewDataSource> {
    NSArray *reasonArray;
    ZMUser*user;
}

@end

@implementation ZMApplyReGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"申请退货";
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    reasonArray = @[@"不想要了",@"不好看",@"质量太差",@"不好吃",@"物流太慢"];
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
    CGFloat bottomH = 80;
    
    _tableView = [[ZMApplyReGoodsTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - bottomH - self.navigationController.navigationBar.bottom) style:UITableViewStyleGrouped];
    _tableView.applyReGoodsDelegate = self;
    [self.view addSubview:_tableView];
    
    _tableView.cancelOrder = _cancelOrder;
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - bottomH - self.navigationController.navigationBar.bottom, self.view.width, bottomH)];
    bottomView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bottomView];
    
    CGFloat btnH = 55;
    CGFloat leftSapce = 25;
    UIButton *btnRetGoods = [[UIButton alloc] initWithFrame:CGRectMake(leftSapce, (bottomView.height - btnH) / 2, bottomView.width - leftSapce * 2, btnH)];
    [btnRetGoods setTitle:@"确认退货" forState:UIControlStateNormal];
    btnRetGoods.titleLabel.font = [UIFont systemFontOfSize:17];
    btnRetGoods.layer.cornerRadius = 5;
    btnRetGoods.backgroundColor = RGBCOLOR(255, 0, 90);
    [btnRetGoods addTarget:self action:@selector(btnRetGoodsClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:btnRetGoods];

}

- (void) btnRetGoodsClicked:(UIButton *)button{
    NSMutableArray *selectedPro = [[NSMutableArray alloc] init];
    double totalPrice = 0;
    for (ZMOrderDetail *orderDetail in _tableView.tmpOrderList.items) {
        if (orderDetail.isSelected) {
            [selectedPro addObject:orderDetail];
            totalPrice += [orderDetail.price doubleValue] * [orderDetail.quantity integerValue];
        }
    }
    if (selectedPro.count <= 0) {
        [SVProgressHUD showInfoWithStatus:@"请选择要退货的商品"];
        return;
    }
    [self requestReturnOrderByOrderId:_cancelOrder.orderId regUserId:user.userId telNo:user.telNo allAmount:[NSString stringWithFormat:@"%.2f", totalPrice] items:selectedPro desc:_tableView.labelReason.text];
}

- (void) loadData{
    [self requestAppPropListByType:@"2"];
}

/**
 *  退货,会员在客户端中提交退货申请
 *
 *  @param orderId     订单id
 *  @param regUserId   会员id
 *  @param telNo       会员账号 即注册手机号
 *  @param allAmount   退货总金额
 *  @param items       订单明细集合
 *  @param orderItemId 订单明细id
 *  @param quantity    退货数量
 *  @param desc        退货原因
 */
- (void) requestReturnOrderByOrderId:(NSString *)orderId regUserId:(NSString *)regUserId telNo:(NSString *)telNo allAmount:(NSString *)allAmount items:(NSArray *)items desc:(NSString *)desc{
    NSString *url = @"app/order/order/returnOrder.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:orderId forKey:@"orderId"];
    [params setValue:regUserId forKey:@"regUserId"];
    [params setValue:telNo forKey:@"telNo"];
    [params setValue:allAmount forKey:@"allAmount"];
    [params setValue:desc forKey:@"desc"];
//    [params setValue:items forKey:@"items"];
    
    // "items":[{"orderItemId\":222,"quantity":3}]
    NSMutableArray *paramsItems = [[NSMutableArray alloc] init];
    for (ZMOrderDetail *orderDetail in items) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setValue:orderDetail.orderDetailId forKey:@"orderItemId"];
        [dict setValue:orderDetail.quantity forKey:@"quantity"];
        [paramsItems addObject:dict];
    }
    [params setValue:paramsItems forKey:@"items"];
    
    [[BaseRequest sharedInstance] orderRequest:url parameters:params success:^(id responseObject) {
//        NSLog(@"退货结果：%@", responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
//            [SVProgressHUD showSuccessWithStatus:responseObject[@"result"]];
            ZMReturnGoodsViewController *returnGoodsVC = [[ZMReturnGoodsViewController alloc] init];
            returnGoodsVC.order = _cancelOrder;
            [self.navigationController pushViewController:returnGoodsVC animated:YES];
        } else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"result"]];
        }
    } failure:^(NSError *error) {
//        NSLog(@"error :%@", [error localizedDescription]);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  根据类型查找客户端参数
 *
 *  @param type type=类型（1.客服参数，2.退货参数，3.支付宝_移动支付参数）
 */
- (void) requestAppPropListByType:(NSString *)type{
    NSString *url = @"app/sys/appProp/findAppPropListByType.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:type forKey:@"type"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        if ([responseObject[@"statu"] isEqualToString:@"true"]) {
            if ([type isEqualToString:@"2"]) {
                NSDictionary *resultParams = responseObject[@"result"];
                _tableView.resultParams = resultParams;
            }
        }
    } failure:^(NSError *error) {
        
    }];
}
/**
 *  UIPickerView只有三个高度， heights for UIPickerView (162.0, 180.0 and 216.0)
 *
 *  @param tap <#tap description#>
 */
- (void)labelReasonClicked:(UITapGestureRecognizer *)tap{
    if (_pickerBackView == nil) {
        _pickerBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        _pickerBackView.backgroundColor = [UIColor blackColor];
        _pickerBackView.alpha = 0.;
        [self.view addSubview:_pickerBackView];
    }
    if (_pickViewReason == nil) {
        _pickViewReason = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.height - 162, self.view.width, 162)];
        _pickViewReason.delegate = self;
        _pickViewReason.dataSource = self;
        _pickViewReason.backgroundColor = [UIColor whiteColor];
        _pickViewReason.alpha = 1;
        [self.view addSubview:_pickViewReason];
    }
   
    if (_toolBar == nil) {
//        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doDone:)];
//        [doneItem setTintColor:[UIColor redColor]];
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, _pickViewReason.top - 44, self.view.width, 44)];
        
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *comp = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doDone:)];
        _toolBar.items = @[space,comp];
        _toolBar.backgroundColor = [UIColor blackColor];
        [self.view addSubview:_toolBar];
    }
    _pickerBackView.hidden = NO;
    _pickViewReason.hidden = NO;
    _toolBar.hidden = NO;
    
    [_pickViewReason.delegate pickerView:_pickViewReason didSelectRow:0 inComponent:1];
}

- (void) doDone:(UIBarButtonItem *)barItem{
    _toolBar.hidden = YES;
    _pickerBackView.hidden = YES;
    _pickViewReason.hidden = YES;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return reasonArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return reasonArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _tableView.labelReason.text = reasonArray[row];
}

@end
