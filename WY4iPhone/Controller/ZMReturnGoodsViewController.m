//
//  ZMReturnGoodsViewController.m
//  WY4iPhone
//
//  Created by ZM21 on 15/9/16.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMReturnGoodsViewController.h"

@interface ZMReturnGoodsViewController (){
    ZMOrder *curOrder;
    UILabel *labelReturnMoney;
    UILabel *labelProgress;
    UILabel *labelStatus;
    ZMUser*user;
}

@end

@implementation ZMReturnGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"办理退货";
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    
    self.navigationItem.hidesBackButton = YES;
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
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, self.view.width, 129 - 48)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, topView.width, 1)];
    line.backgroundColor = RGBCOLOR(236, 236, 236);
    [topView addSubview:line];
    
    labelProgress = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, topView.width - 10 * 2, 15)];
    labelProgress.font = [UIFont systemFontOfSize:15];
    labelProgress.textColor = RGBCOLOR(198, 198, 198);
    labelProgress.text = @"申请成功 > 等待退款 > 退款成功";
    [topView addSubview:labelProgress];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, labelProgress.bottom + 10, topView.width, 1)];
    line2.backgroundColor = RGBCOLOR(236, 236, 236);
    [topView addSubview:line2];
    
    UILabel *lbStatus = [[UILabel alloc] initWithFrame:CGRectMake(10, line2.bottom + 15, 75, 15)];
    lbStatus.font = [UIFont systemFontOfSize:15];
    lbStatus.textColor = RGBCOLOR(198, 198, 198);
    lbStatus.text = @"状      态：";
    [topView addSubview:lbStatus];
    
    labelStatus = [[UILabel alloc] initWithFrame:CGRectMake(lbStatus.right, lbStatus.top, topView.width - lbStatus.width - 10 * 2, lbStatus.height)];
    labelStatus.textColor = RGBCOLOR(139, 138, 143);
    labelStatus.font = [UIFont systemFontOfSize:15];
    [topView addSubview:labelStatus];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, lbStatus.bottom + 15, topView.width, 1)];
    line3.backgroundColor = RGBCOLOR(236, 236, 236);
    [topView addSubview:line3];
    
    UILabel *lbReturnMoney = [[UILabel alloc] initWithFrame:CGRectMake(10, line3.bottom + 15, 75, 15)];
    lbReturnMoney.font = [UIFont systemFontOfSize:15];
    lbReturnMoney.textColor = RGBCOLOR(198, 198, 198);
    lbReturnMoney.text = @"退款金额：";
//    [topView addSubview:lbReturnMoney];
    
    labelReturnMoney = [[UILabel alloc] initWithFrame:CGRectMake(lbReturnMoney.right, lbReturnMoney.top, labelStatus.width, labelStatus.height)];
    labelReturnMoney.textColor = RGBCOLOR(139, 138, 143);
    labelReturnMoney.font = [UIFont systemFontOfSize:15];
//    [topView addSubview:labelReturnMoney];
    
    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(0, lbReturnMoney.bottom + 15, topView.width, 1)];
    line4.backgroundColor = RGBCOLOR(236, 236, 236);
//    [topView addSubview:line4];
    
    CGFloat footViewH = 60;
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - self.navigationController.navigationBar.bottom - footViewH, self.view.width, footViewH)];
    footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footView];
    
    CGFloat leftSpace = 25;
    CGFloat btnH = 43;
    CGFloat btnMyOrderW = (footView.width - 14 - leftSpace * 2) / 3;
    UIButton *btnMyOrder = [[UIButton alloc] initWithFrame:CGRectMake(leftSpace, (footView.height - btnH) / 2,  btnMyOrderW, btnH)];
    btnMyOrder.backgroundColor = [UIColor whiteColor];
    btnMyOrder.layer.cornerRadius = 5;
    btnMyOrder.layer.borderWidth = 1;
    btnMyOrder.layer.borderColor = RGBCOLOR(255, 183, 197).CGColor;
    [btnMyOrder setTitle:@"返回首页" forState:UIControlStateNormal];
    [btnMyOrder setTitleColor:RGBCOLOR(255, 0, 101) forState:UIControlStateNormal];
    btnMyOrder.titleLabel.font = [UIFont systemFontOfSize:18];
    [btnMyOrder addTarget:self action:@selector(myOrder:) forControlEvents:UIControlEventTouchUpInside];
//    [footView addSubview:btnMyOrder];// 暂时只保留一个按钮
    
    UIButton *btnShop = [[UIButton alloc] initWithFrame:CGRectMake(leftSpace, btnMyOrder.top, self.view.width - leftSpace * 2, btnMyOrder.height)];
    btnShop.backgroundColor = RGBCOLOR(255, 0, 90);
    btnShop.layer.cornerRadius = 5;
//    btnShop.layer.borderColor = RGBCOLOR(255, 183, 197).CGColor;
    [btnShop setTitle:@"随便逛逛" forState:UIControlStateNormal];
//    [btnShop setTitleColor:RGBCOLOR(255, 0, 101) forState:UIControlStateNormal];
    btnShop.titleLabel.font = [UIFont systemFontOfSize:18];
    [btnShop addTarget:self action:@selector(btnShopClicked:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btnShop];
}

- (void) loadData{
    [self requestReturnOrderListByRegUserId:user.userId startPage:NULL];
}

- (void) myOrder:(UIButton *)button{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) btnShopClicked:(UIButton *)button{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) requestReturnOrderListByRegUserId:(NSString *)regUserId startPage:(NSString *)startPage {
    NSString *url = @"app/order/order/findReturnOrderList.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:regUserId forKey:@"regUserId"];
    if (startPage != NULL && startPage.length > 0) {
        [params setValue:startPage forKey:@"startPage"];
    }
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
//        NSLog(@"return goods:%@", responseObject);
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
                    NSMutableArray *tmpOrderList = [[NSMutableArray alloc] init];
                    NSArray *result = responseObject[@"result"][@"result"];
                    for (NSDictionary *dict in result) {
                        ZMOrder *order = [ZMOrder orderWithDictionary:dict];
                        [tmpOrderList addObject:order];
                    }
                    _orderList = tmpOrderList;
                    //            if (tmpOrderList.count > 0) {
                    //                curOrder = tmpOrderList[0];
                    //                [self refreshView];
                    //            }
                    for (ZMOrder *order in _orderList) {
                        if ([order.orderId integerValue] == [_order.orderId integerValue]) {
                            curOrder = order;
                            [self refreshView];
                            break;
                        }
                    }
                    
                    
                }
  
            }
            
                   }
    } failure:^(NSError *error) {
//        NSLog(@"error:%@", [error localizedDescription]);
    }];
}

- (void) refreshView{
    labelReturnMoney.text = [NSString stringWithFormat:@"￥%@", curOrder.amount];
    
    switch ([curOrder.orderState integerValue]) {
        
            
        case 1:// 待审核
            
        case 2:// 待发货
            
        case 3:// 已发货
            
        case 5:// 退货中
        
        case 6:// 待退款
            labelProgress.attributedText = [self parserString:@"申请成功 > " contentStr:@"等待退款" endStr:@" > 退款成功"];
            labelStatus.text = @"正在为您办理退款，3-7天内完成";
            labelReturnMoney.text = [NSString stringWithFormat:@"￥%@", curOrder.amount];
            break;
        case 0:// 已取消
        case 7:// 已退款
        case 4:// 已完成
            labelProgress.attributedText = [self parserString:@"申请成功 > 等待退款 >" contentStr:@" 退款成功" endStr:@""];
            labelStatus.text = @"退款完成";
            labelReturnMoney.text = [NSString stringWithFormat:@"￥%@", curOrder.amount];
            break;
            
        default:
            break;
    }
}

/**
 *  富文本，拼接字符串
 *
 *  @param preStr 待拼接的字符串1
 *  @param str    待拼接的字符串2
 *
 *  @return 拼接好的字符串
 */
- (NSMutableAttributedString *) parserString:(NSString *)preStr contentStr:(NSString *)str endStr:(NSString *)endStr{
    NSString *postStr = [NSString stringWithFormat:@"%@%@%@", preStr, str, endStr];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:postStr];
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:RGBCOLOR(198, 198, 198)
                       range:NSMakeRange(0, preStr.length)];
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:BaseTintRGB
                       range:NSMakeRange(preStr.length, str.length)];
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:RGBCOLOR(198, 198, 198)
                       range:NSMakeRange(endStr.length, str.length)];
    return attrString;
}

@end
