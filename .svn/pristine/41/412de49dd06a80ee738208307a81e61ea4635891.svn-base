//
//  ZMToBePayTableViewCell.h
//  WY4iPhone
//
//  Created by liang.pc on 15/9/16.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZMToBePayTableViewCell;

@protocol ToBePayDelegate <NSObject>

@optional
/**
 *  支付按钮点击事件
 *
 *  @param toBePayTableViewCell
 *  @param index                被点击按钮index
 */
- (void) toBePayTableViewCell:(ZMToBePayTableViewCell *)toBePayTableViewCell didSelectedAtIndex:(long)index;

@end

@interface ZMToBePayTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *labelOrderStatus;
@property (nonatomic, strong) UIImageView *imgViewHead;
@property (nonatomic, strong) UILabel *labelProductName;
@property (nonatomic, strong) UILabel *labelRealPrice;
@property (nonatomic, strong) UIButton *btnPay;
@property (nonatomic, strong) UILabel *labelPrice;
@property (nonatomic, strong) UILabel *labelCount;

@property (nonatomic, assign) id<ToBePayDelegate> toBePayDelegate;

@end
