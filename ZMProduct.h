//
//  ZMProduct.h
//  WY4iPhone
//
//  Created by ZM on 15/9/22.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  商品
 */
@interface ZMProduct : NSObject

/**
 *  品牌
 */
@property (nonatomic, strong) NSString *bandName;
/**
 *  售价
 */
@property (nonatomic, strong) NSString *currentPrice;
/**
 *  库存
 */
@property (nonatomic, strong) NSString *currentStock;
/**
 *  商品描述
 */
@property (nonatomic, strong) NSString *desc;
/**
 *  图片URL地址
 */
@property (nonatomic, strong) NSString *httpImgUrl;
@property (nonatomic, strong) NSString *httpWebUrl;
@property (nonatomic, strong) NSString *imgaeUrl;
/**
 *  商品记录ID
 */

@property (nonatomic, strong) NSString *productId;
// 原价
@property (nonatomic, strong) NSString *oldPrice;
@property (nonatomic, strong) NSString *proId;
/**
 *  商品名称
 */
@property (nonatomic, strong) NSString *proName;
// 规格（多少克）
@property (nonatomic, strong) NSString *spec;
// 佣金（通过会员id得知是否是微商，微商有佣金，不是微商没有佣金）
@property (nonatomic, strong) NSString *totalComm;
/**
 *  商品地区ID
 */
@property (nonatomic, strong) NSString *areaId;
/**
 *  商品产地名称
 */
@property (nonatomic, strong) NSString *areaName;
/**
 *  商品产地图片
 */
@property (nonatomic, strong) NSString *areaPic;
@property (nonatomic, strong) NSString *ranking;
@property (nonatomic, strong)NSString*bandId;
- (instancetype) initWithDictionary:(NSDictionary *)dict;
+ (instancetype) productWithDictionary:(NSDictionary *)dict;

@end
