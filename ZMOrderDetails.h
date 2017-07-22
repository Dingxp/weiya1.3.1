//
//  ZMOrderDetails.h
//  WY4iPhone
//
//  Created by ZM on 15/9/29.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  订单详情
 */
@interface ZMOrderDetails : NSObject

@property (nonatomic, strong) NSString *addrArea;
@property (nonatomic, strong) NSString *addrCity;
@property (nonatomic, strong) NSString *addrProvince;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *consignee;
@property (nonatomic, strong) NSString *couponAmount;
@property (nonatomic, strong) NSString *expressCode;
@property (nonatomic, strong) NSString *expressName;
@property (nonatomic, strong) NSString *expressNum;
/**
 *  订单中的明细项（OrderDetail）
 */
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSString *orderState;
@property (nonatomic, strong) NSString *orderTime;
@property (nonatomic, strong) NSString *payState;
@property (nonatomic, strong) NSString *payTypeName;
@property (nonatomic, strong) NSString *shipAmount;
@property (nonatomic, strong) NSString *shipState;
@property (nonatomic, strong) NSString *telNo;
@property (nonatomic, strong) NSString *zipCode;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;
+ (instancetype) orderDetailsWithDictionary:(NSDictionary *)dictionary;

@end
