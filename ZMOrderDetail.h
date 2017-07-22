//
//  ZMOrderDetail.h
//  WY4iPhone
//
//  Created by ZM on 15/9/29.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  订单明细
 */
@interface ZMOrderDetail : NSObject <NSCopying>

@property (nonatomic, strong) NSString *bandName;
@property (nonatomic, strong) NSString *httpImgUrl;
@property (nonatomic, strong) NSString *orderDetailId;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *proId;
@property (nonatomic, strong) NSString *proName;
@property (nonatomic, strong) NSString *quantity;
/**
 *  规格
 */
@property (nonatomic, strong) NSString *spec;
/**
 *  金额
 */
@property (nonatomic, strong) NSString *amount;
/**
 *  商品编号
 */
@property (nonatomic, strong) NSString *proNum;
@property (nonatomic, assign) BOOL isSelected;

- (instancetype) initWithDictionary:(NSDictionary *)dict;
+ (instancetype) orderDetailWithDictionary:(NSDictionary *)dict;

@end
