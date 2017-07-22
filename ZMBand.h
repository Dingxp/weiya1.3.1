//
//  ZMBand.h
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/12/3.
//  Copyright © 2015年 mx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMBand : NSObject
/**
 *  品牌
 */
@property (nonatomic, strong) NSString *bandName;
/**
 *  品牌id
 */
@property (nonatomic, strong)NSString*bandId;
/**
 *  商品描述
 */
@property (nonatomic, strong) NSString *desc;
/**
 *  图片URL地址
 */
@property (nonatomic, strong) NSString *httpImgUrl;
- (instancetype) initWithDictionary:(NSDictionary *)dict;
+ (instancetype) productWithDictionary:(NSDictionary *)dict;
@end
