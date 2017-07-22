//
//  ZMCouponList.h
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/12/14.
//  Copyright © 2015年 mx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMCouponList : NSObject
//开始时间
@property (strong,nonatomic)NSString*beginDate;
//优惠劵金额
@property (strong,nonatomic)NSString*couponAmount;
//优惠劵名称
@property (strong,nonatomic)NSString*couponName;
//优惠劵类型
@property (strong,nonatomic)NSString*couponType;
//创建时间
@property (strong,nonatomic)NSString*createTime;
//结束时间
@property (strong,nonatomic)NSString*endDate;
//是否为使用
@property (strong,nonatomic)NSString*isUsed;
//还有几天过期
@property (strong,nonatomic)NSString*remainderTime;
//优惠劵的期限
@property (strong,nonatomic)NSString*validity;
//优惠劵id
@property (strong,nonatomic)NSString*couponId;
//是否过期
@property (strong,nonatomic)NSString*expireState;
//描述
@property (strong,nonatomic)NSString*desc;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;
+ (instancetype) orderDetailsWithDictionary:(NSDictionary *)dictionary;
@end
