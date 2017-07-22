//
//  ZMOrderDetailTableView.m
//  WY4iPhone
//
//  Created by liang.pc on 15/9/15.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMOrderDetailTableView.h"
#import "ZMOrderDetailTableViewCell.h"
#import "ZMOrderDetail.h"
#import "UIImageView+WebCache.h"

@interface ZMOrderDetailTableView (){
    UIView *backView;
    UIView *alertView;
}

@end

@implementation ZMOrderDetailTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initView];
    }
    return self;
}

- (void) initView{
    self.backgroundColor = RGBCOLOR(240, 240, 240);
    self.delegate = self;
    self.dataSource = self;
    
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
    
    CGFloat topSpaces = 10;
    CGFloat leftSpace = 10;
    CGFloat fontSize = 14;
    
    // headView
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 112 + fontSize * 5-68)];
    headView.backgroundColor = [UIColor whiteColor];
    self.tableHeaderView = headView;
    
    CGFloat line1H = 8;
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headView.width, line1H)];
    line1.backgroundColor = RGBCOLOR(240, 240, 240);
    [headView addSubview:line1];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, line1.bottom, headView.width, 1)];
    line2.backgroundColor = RGBCOLOR(226, 226, 226);
    [headView addSubview:line2];
    
    UILabel *lbOrderStatus = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, line2.bottom + topSpaces, 75, 15)];
    lbOrderStatus.textColor = RGBCOLOR(207, 207, 207);
    lbOrderStatus.font = [UIFont systemFontOfSize:15];
    lbOrderStatus.text = @"订单状态：";
    [headView addSubview:lbOrderStatus];
    
    _labelOrderStatus = [[UILabel alloc] initWithFrame:CGRectMake(lbOrderStatus.right + 5, lbOrderStatus.top, 200, lbOrderStatus.height)];
    _labelOrderStatus.textColor = RGBCOLOR(139, 139, 139);
    _labelOrderStatus.font = [UIFont systemFontOfSize:15];
    [headView addSubview:_labelOrderStatus];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, lbOrderStatus.bottom + topSpaces, headView.width, line2.height)];
    line3.backgroundColor = RGBCOLOR(229, 229, 229);
    [headView addSubview:line3];
    
    _labelUserName = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, line3.bottom + 15, headView.width - leftSpace * 2, fontSize)];
    _labelUserName.font = [UIFont systemFontOfSize:fontSize];
    _labelUserName.textColor = RGBCOLOR(114, 114, 114);
    [headView addSubview:_labelUserName];
    
    _labelAddress = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, _labelUserName.bottom + topSpaces, _labelUserName.width, fontSize)];
    _labelAddress.font = [UIFont systemFontOfSize:fontSize];
    _labelAddress.textColor = RGBCOLOR(114, 114, 114);
    [headView addSubview:_labelAddress];
    
    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(0, _labelAddress.bottom + 15, headView.width, line2.height)];
    line4.backgroundColor = RGBCOLOR(234, 234, 234);
    [headView addSubview:line4];
    
//    // 物流的view
//    UIView *logisticsView = [[UIView alloc] initWithFrame:CGRectMake(0, line4.bottom, headView.width, 68)];
//    logisticsView.backgroundColor = [UIColor whiteColor];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(logisticsViewClicked:)];
//    logisticsView.userInteractionEnabled = YES;
//    [logisticsView addGestureRecognizer:tap];
//    [headView addSubview:logisticsView];
//
//    _labelLogisticsStatus = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, 15, headView.width - leftSpace * 2, fontSize)];
//    _labelLogisticsStatus.font = [UIFont systemFontOfSize:fontSize];
//    _labelLogisticsStatus.textColor = RGBCOLOR(114, 114, 114);
//    [logisticsView addSubview:_labelLogisticsStatus];
//    
//    _labelLogisticsInfo = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, _labelLogisticsStatus.bottom + topSpaces, _labelLogisticsStatus.width, fontSize)];
//    _labelLogisticsInfo.font = [UIFont systemFontOfSize:fontSize];
//    _labelLogisticsInfo.textColor = RGBCOLOR(207, 207, 207);
//    [logisticsView addSubview:_labelLogisticsInfo];
//    
//    UIView *line5 = [[UIView alloc] initWithFrame:CGRectMake(0, logisticsView.bottom, headView.width, line2.height)];
//    line5.backgroundColor = RGBCOLOR(232, 232, 232);
//    [headView addSubview:line5];
    
    UIView *line6 = [[UIView alloc] initWithFrame:CGRectMake(0, line4.bottom, headView.width, line1H)];
    line6.backgroundColor = RGBCOLOR(240, 240, 240);
    [headView addSubview:line6];
    
    // footView
    CGFloat fontSize2 = 14;
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 154 + fontSize2 * 6)];
    footView.backgroundColor = [UIColor whiteColor];
    self.tableFooterView = footView;
    
    UIView *line7 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headView.width, line1H)];
    line7.backgroundColor = RGBCOLOR(240, 240, 240);
    [footView addSubview:line7];
    
    UIView *line8 = [[UIView alloc] initWithFrame:CGRectMake(0, line7.bottom, footView.width, line2.height)];
    line8.backgroundColor = RGBCOLOR(232, 232, 232);
    [footView addSubview:line8];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(leftSpace, line8.bottom + 15, 2, 15)];
    UIEdgeInsets inset = UIEdgeInsetsMake(1, 1, 1, 1);
    imgView.image = [[UIImage imageNamed:@"homepage_03"] resizableImageWithCapInsets:inset resizingMode:UIImageResizingModeTile];
    [footView addSubview:imgView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right + 5, imgView.top, 100, fontSize2)];
    title.text = @"支付信息";
    title.textColor = RGBCOLOR(246, 122, 151);
    title.font = [UIFont systemFontOfSize:15];
    [footView addSubview:title];

    UIView *line9 = [[UIView alloc] initWithFrame:CGRectMake(0, imgView.bottom + 15, footView.width, line2.height)];
    line9.backgroundColor = RGBCOLOR(236, 236, 236);
    [footView addSubview:line9];

    // 支付方式
    UILabel *lbPayBy = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, line9.bottom + 13, 60, fontSize2)];
    lbPayBy.font = [UIFont systemFontOfSize:fontSize2];
    lbPayBy.textColor = RGBCOLOR(165, 165, 165);
    lbPayBy.text = @"支付方式";
    [footView addSubview:lbPayBy];
    
    _labelPayBy = [[UILabel alloc] initWithFrame:CGRectMake(lbPayBy.right + 20, lbPayBy.top, footView.width - lbPayBy.width - leftSpace * 2 - 20, fontSize2)];
    _labelPayBy.font = [UIFont systemFontOfSize:fontSize2];
    _labelPayBy.textColor = RGBCOLOR(114, 114, 114);
    [footView addSubview:_labelPayBy];
    
    // 现金券
    UILabel *lbCoupons = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, lbPayBy.bottom + topSpaces, 60, fontSize2)];
    lbCoupons.font = [UIFont systemFontOfSize:fontSize2];
    lbCoupons.textColor = RGBCOLOR(165, 165, 165);
    lbCoupons.text = @"现  金  券";
    [footView addSubview:lbCoupons];
    
    _labelCoupons = [[UILabel alloc] initWithFrame:CGRectMake(_labelPayBy.left, lbCoupons.top, _labelPayBy.width, fontSize2)];
    _labelCoupons.font = [UIFont systemFontOfSize:fontSize2];
    _labelCoupons.textColor = RGBCOLOR(114, 114, 114);
    [footView addSubview:_labelCoupons];

    // 邮费
    UILabel *lbShipping = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, lbCoupons.bottom + topSpaces, 60, fontSize2)];
    lbShipping.font = [UIFont systemFontOfSize:fontSize2];
    lbShipping.textColor = RGBCOLOR(165, 165, 165);
    lbShipping.text = @"邮       费";
    [footView addSubview:lbShipping];
    
    _labelShipping = [[UILabel alloc] initWithFrame:CGRectMake(_labelPayBy.left, lbShipping.top, _labelPayBy.width, fontSize2)];
    _labelShipping.font = [UIFont systemFontOfSize:fontSize2];
    _labelShipping.textColor = RGBCOLOR(114, 114, 114);
    [footView addSubview:_labelShipping];
    
    // 下单时间
    UILabel *lbOrderTime = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, lbShipping.bottom + topSpaces, 60, fontSize2)];
    lbOrderTime.font = [UIFont systemFontOfSize:fontSize2];
    lbOrderTime.textColor = RGBCOLOR(165, 165, 165);
    lbOrderTime.text = @"下单时间";
    [footView addSubview:lbOrderTime];
    
    _labelOrderTime = [[UILabel alloc] initWithFrame:CGRectMake(_labelPayBy.left, lbOrderTime.top, _labelPayBy.width, fontSize2)];
    _labelOrderTime.font = [UIFont systemFontOfSize:fontSize2];
    _labelOrderTime.textColor = RGBCOLOR(114, 114, 114);
    [footView addSubview:_labelOrderTime];
    
    // 实际付款
    UILabel *lbRealPay = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, lbOrderTime.bottom + topSpaces, 60, fontSize2)];
    lbRealPay.font = [UIFont systemFontOfSize:fontSize2];
    lbRealPay.textColor = RGBCOLOR(165, 165, 165);
    lbRealPay.text = @"实际付款";
    [footView addSubview:lbRealPay];
    
    _labelRealPay = [[UILabel alloc] initWithFrame:CGRectMake(_labelPayBy.left, lbRealPay.top, _labelPayBy.width, fontSize2)];
    _labelRealPay.font = [UIFont systemFontOfSize:fontSize2];
    _labelRealPay.textColor = RGBCOLOR(246, 92, 135);
    [footView addSubview:_labelRealPay];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZMOrderDetail *orderDetail = _datas[indexPath.row];
    static NSString *identified = @"orderDetailCell";
    ZMOrderDetailTableViewCell *cell = [self dequeueReusableCellWithIdentifier:identified];
    if (!cell) {
        cell = [[ZMOrderDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identified];
    }
    [cell.imgViewHead sd_setImageWithURL:[NSURL URLWithString:orderDetail.httpImgUrl]];
    
    CGFloat h = [orderDetail.proName commonStringHeighforLabelWidth:cell.labelProductName.frame.size.width withFontSize:15];
    cell.labelProductName.text = orderDetail.proName;
    CGRect frame = cell.labelProductName.frame;
    frame.size.height = h;
    cell.labelProductName.frame = frame;
    
    cell.labelPrice.text = [NSString stringWithFormat:@"￥%@", orderDetail.price];
    cell.labelCount.text = [NSString stringWithFormat:@"x%@", orderDetail.quantity];
    return cell;
}
- (void)setOrderDetails:(ZMOrderDetails *)orderDetails{
    _orderDetails = orderDetails;
    _datas = orderDetails.items;
    [self reloadData];
}

@end
