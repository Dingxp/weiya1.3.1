//
//  ZMProductDetail.h
//  WY4iPhone
//
//  Created by ZM on 15/9/23.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMProductDetail : NSObject

/**
 *  品牌ID
 */
@property (nonatomic, strong) NSString *bandId;
/**
 *  品牌名称
 */
@property (nonatomic, strong) NSString *bandName;
@property (nonatomic, strong) NSString *bwName;
/**
 *  分类ID
 */
@property (nonatomic, strong) NSString *catId;
/**
 *  分类名称
 */
@property (nonatomic, strong) NSString *cateName;
/**
 *  售价
 */
@property (nonatomic, strong) NSString *currentPrice;
/**
 *  库存
 */
@property (nonatomic, strong) NSString *currentStock;
/**
 *  备注
 */
@property (nonatomic, strong) NSString *desc;
/**
 *  详情集合
 */
@property (nonatomic, strong) NSArray *descList;
/**
 *  商品图片URL
 */
@property (nonatomic, strong) NSString *httpImgUrl;
@property (nonatomic, strong) NSString *httpWebUrl;
/**
 *  商品ID
 */
@property (nonatomic, strong) NSString *proDetailId;
/**
 *  原价
 */
@property (nonatomic, strong) NSString *oldPrice;
@property (nonatomic, strong) NSString *isBW;
@property (nonatomic, strong) NSString *isFav;
@property (nonatomic, strong) NSString *discount;
/**
 *  商品名称
 */
@property (nonatomic, strong) NSString *proName;
/**
 *  商品编号
 */
@property (nonatomic, strong) NSString *proNum;
/**
 *  规格
 */
@property (nonatomic, strong) NSString *spec;
/**
 *  标题图片集合
 */
@property (nonatomic, strong) NSArray *titleList;

@property (nonatomic, strong) NSString *totalComm;

- (instancetype) initWithDictionary:(NSDictionary *)dict;
+ (instancetype) productDetailWithDictionary:(NSDictionary *)dict;

@end
