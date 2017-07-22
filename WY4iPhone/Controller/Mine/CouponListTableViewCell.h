//
//  CouponListTableViewCell.h
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/12/14.
//  Copyright © 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMCouponList.h"
@interface CouponListTableViewCell : UITableViewCell
@property(strong,nonatomic)NSArray*couponArray;
@property(strong,nonatomic)UILabel*couponAmount;
@property(strong,nonatomic)UIImageView*isUsedImage;
@property(strong,nonatomic)UILabel*couponName;
@property(strong,nonatomic)UILabel*lab;
@property(strong,nonatomic)UILabel*remainderTimeLab;
@property(strong,nonatomic)ZMCouponList*couponList;

@end
