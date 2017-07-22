//
//  ZMAddress.h
//  WY4iPhone
//
//  Created by ZM21 on 15/9/27.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMAddress : NSObject

/**
 *  详细地址
 */
@property (nonatomic, strong) NSString *addr;
/**
 *  区
 */
@property (nonatomic, strong) NSString *addrArea;
/**
 *  市
 */
@property (nonatomic, strong) NSString *addrCity;
/**
 *  省
 */
@property (nonatomic, strong) NSString *addrProvince;
/**
 *  收货人
 */
@property (nonatomic, strong) NSString *consignee;
/**
 *  地址id
 */
@property (nonatomic, strong) NSString *addressId;
/**
 *  是否默认
 */
@property (nonatomic, strong) NSString *isDefault;
/**
 *  会员ID
 */
@property (nonatomic, strong) NSString *regUserId;
/**
 *  收货人电话
 */
@property (nonatomic, strong) NSString *telNo;
/**
 *  邮编
 */
@property (nonatomic, strong) NSString *zipCode;
/**
 *  身份证
 */
@property (nonatomic, strong) NSString *shenfenID;

- (instancetype) initWithDictionary:(NSDictionary *)dict;
+ (instancetype) addressWithDictionary:(NSDictionary *)dict;
+ (instancetype) addressInstance;

@end
