//
//  ZMShipment.h
//  WY4iPhone
//
//  Created by ZM21 on 15/9/27.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  配送信息
 */
@interface ZMShipment : NSObject

/**
 *  运费
 */
@property (nonatomic, assign) NSString *cost;
/**
 *  运费类型（1表示统一价，2区域价）
 */
@property (nonatomic, strong) NSString *costType;
/**
 *  快递公司代码
 */
@property (nonatomic, strong) NSString *expressCode;
/**
 *  物流公司ID
 */
@property (nonatomic, strong) NSString *expressId;
/**
 *  物流公司名称
 */
@property (nonatomic, strong) NSString *expressName;
/**
 *  配送方式ID
 */
@property (nonatomic, strong) NSString *shipmentId;
/**
 *  配送方式名称
 */
@property (nonatomic, strong) NSString *shipMentName;

- (instancetype) initWithDictionary:(NSDictionary *)dict;
+ (instancetype) shipmentWithDictionary:(NSDictionary *)dict;

@end
