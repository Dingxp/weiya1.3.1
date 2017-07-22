//
//  ZMOrderTableViewCell.h
//  WY4iPhone
//
//  Created by ZM21 on 15/9/14.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMOrderTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *labelOrderStatus;
@property (nonatomic, strong) UIImageView *imgViewHead;
@property (nonatomic, strong) UILabel *labelProductName;
@property (nonatomic, strong) UILabel *labelRealPrice;
@property (nonatomic, strong) UIButton *btnPay;

@end
