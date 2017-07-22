//
//  ZMTodayRecommend.h
//  WY4iPhone
//
//  Created by ZM on 15/9/22.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  今日推荐
 */
@interface ZMTodayRecommend : NSObject

/**
 *  图片地址
 */
@property (nonatomic, strong) NSString *httpImgUrl;
/**
 *  静态文件地址
 */
@property (nonatomic, strong) NSString *httpWebUrl;
/**
 *  今日推荐ID
 */
@property (nonatomic, strong) NSString *todayRecommendId;
/**
 *  商品id
 */
@property (nonatomic, strong) NSString *proId;
/**
 *  商品名称
 */
@property (nonatomic, strong) NSString *proName;

- (instancetype) initWithDictionary:(NSDictionary *) dict;
+ (instancetype) todayRecommendWithDictionary:(NSDictionary *) dict;

@end
