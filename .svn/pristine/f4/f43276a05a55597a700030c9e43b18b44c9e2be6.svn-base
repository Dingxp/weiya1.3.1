//
//  ZMApplyReGoodsTableView.h
//  WY4iPhone
//
//  Created by ZM on 15/9/21.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMOrder.h"
#import "ZMApplyRetGTableViewCell.h"
#import "ZMOrderDetail.h"
#import "UIImageView+WebCache.h"

@protocol ZMApplyReGoodsTableViewDelegate <NSObject>

@optional
- (void)labelReasonClicked:(UITapGestureRecognizer *)tap;

@end

@interface ZMApplyReGoodsTableView : UITableView <UITableViewDelegate, UITableViewDataSource, ZMApplyRetGTableViewCellDelegate>

@property (nonatomic, strong) ZMOrder *cancelOrder;
@property (nonatomic, strong) UILabel *labelTipsContent;
@property (nonatomic, strong) UILabel *labelPostCode;
@property (nonatomic, strong) UILabel *labelAddress;
@property (nonatomic, strong) UILabel *labelPhoneNum;
@property (nonatomic, strong) UILabel *labelContacts;
@property (nonatomic, strong) UILabel *labelReason;
@property (nonatomic, copy) ZMOrder *tmpOrderList;

@property (nonatomic, strong) NSDictionary *resultParams;
/**
 *  主要是用来控制cell的选中状态，并没有什么卵用
 */
@property (nonatomic, strong) NSMutableArray *selectProList;
@property (nonatomic, assign) id<ZMApplyReGoodsTableViewDelegate> applyReGoodsDelegate;

@end
