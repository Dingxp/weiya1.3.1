//
//  ZMPaySuccessViewController.m
//  WY4iPhone
//
//  Created by ZM21 on 15/10/3.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMPaySuccessViewController.h"

@interface ZMPaySuccessViewController (){
    
}

@end

@implementation ZMPaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"支付成功";
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
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 10, self.view.width, 91)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.width, 1)];
    line.backgroundColor = RGBCOLOR(233, 233, 233);
    [view addSubview:line];
    
    _lbOrderNum = [[UILabel alloc] initWithFrame:CGRectMake(10, line.bottom + 15, 56, 14)];
    _lbOrderNum.font = [UIFont systemFontOfSize:14];
    _lbOrderNum.text = @"订单状态";
    [view addSubview:_lbOrderNum];
    
    _labelOrderNum = [[UILabel alloc] initWithFrame:CGRectMake(_lbOrderNum.right + 20, _lbOrderNum.top, view.width - 10 * 2 - _lbOrderNum.width - 20, _lbOrderNum.height)];
    _labelOrderNum.font = [UIFont systemFontOfSize:14];
    [view addSubview:_labelOrderNum];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(line.left, _lbOrderNum.bottom + 15, line.width, line.height)];
    line2.backgroundColor = RGBCOLOR(233, 233, 233);
    [view addSubview:line2];
    
    UILabel *lbOrderAmount = [[UILabel alloc] initWithFrame:CGRectMake(_lbOrderNum.left, line2.bottom + 15, _lbOrderNum.width, _lbOrderNum.height)];
    lbOrderAmount.font = [UIFont systemFontOfSize:14];
    lbOrderAmount.text = @"订单金额";
    [view addSubview:lbOrderAmount];
    
    _labelOrderAmount= [[UILabel alloc] initWithFrame:CGRectMake(_labelOrderNum.left, lbOrderAmount.top, _labelOrderNum.width, _lbOrderNum.height)];
    _labelOrderAmount.font = [UIFont systemFontOfSize:14];
    [view addSubview:_labelOrderAmount];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(line.left, lbOrderAmount.bottom + 15, line.width, line.height)];
    line3.backgroundColor = RGBCOLOR(233, 233, 233);
    [view addSubview:line3];
    
    UIButton *btnHomePage = [[UIButton alloc] initWithFrame:CGRectMake(25, self.view.height - 30 - 52 - self.navigationController.navigationBar.bottom, self.view.width - 25 * 2, 52)];
    btnHomePage.backgroundColor = RGBCOLOR(255, 0, 90);
    btnHomePage.layer.cornerRadius = 5;
    [btnHomePage setTitle:@"回到首页" forState:UIControlStateNormal];
    btnHomePage.titleLabel.font = [UIFont systemFontOfSize:16];
    [btnHomePage addTarget:self action:@selector(backToHome:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnHomePage];
}

- (void) loadData{
    _labelOrderAmount.text = [NSString stringWithFormat:@"￥%@", _order.amount];
    _labelOrderNum.text = [NSString stringWithFormat:@"%@", _order.expressNum];
    
    switch ([_order.orderState integerValue]) {
        case 0:// 已取消
            _labelOrderNum.text = @"已取消";
            break;
        case 1:// 待审核
            _labelOrderNum.text = @"待审核";
            break;
        case 2:// 待发货
            _labelOrderNum.text = @"待发货";
            break;
        case 3:// 已发货
            _labelOrderNum.text = @"已发货";
            break;
        case 5:// 退货中
            _labelOrderNum.text = @"退货中";
            break;
        case 6:// 待退款
            _labelOrderNum.text = @"待退款";
            break;
        case 4:// 已完成
            _labelOrderNum.text = @"已完成";
            break;
        case 7:// 已退款
            _labelOrderNum.text = @"已退款";
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) backToHome:(UIButton *)button{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
