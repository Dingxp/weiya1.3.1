//
//  ZMOrderDetailTableView.h
//  WY4iPhone
//
//  Created by liang.pc on 15/9/15.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMOrderDetails.h"

@protocol ButtonClickedDelegate <NSObject>

@optional
//- (void) btnClicked:(UIButton *)button;
- (void) logisticsViewClicked:(UITapGestureRecognizer *)tap;

@end

@interface ZMOrderDetailTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UILabel *labelOrderStatus;
@property (nonatomic, strong) UILabel *labelUserName;
@property (nonatomic, strong) UILabel *labelAddress;
// 物流状态
@property (nonatomic, strong) UILabel *labelLogisticsStatus;
// 物流信息
@property (nonatomic, strong) UILabel *labelLogisticsInfo;

@property (nonatomic, strong) UILabel *labelPayBy;

// 现金券
@property (nonatomic, strong) UILabel *labelCoupons;
@property (nonatomic, strong) UILabel *labelShipping;
@property (nonatomic, strong) UILabel *labelOrderTime;
@property (nonatomic, strong) UILabel *labelRealPay;
// 申请退款按钮
@property (nonatomic, strong) UIButton *btnRefund;
// 确认收货按钮
@property (nonatomic, strong) UIButton *btnGoodsRecive;
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) ZMOrderDetails *orderDetails;

//@property (nonatomic, assign) id<ButtonClickedDelegate> btnDelegate;
// 后面需要根据订单的状态来显示或者隐藏两个按钮所在的View
@property (nonatomic, strong) UIView *bottomBtnView;

@end
