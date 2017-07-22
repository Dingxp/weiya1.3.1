//
//  WY4iPhone
//
//  Created by ZM on 15/9/22.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  频道数据
 */
@interface ChannelItem : NSObject

/**
 *  id
 */
@property (nonatomic, strong) NSString *channelItemId;

/**
 *  频道项名称
 */
@property (nonatomic, strong) NSString *channelItemName;
/**
 *  活动图片地址
 */
@property (nonatomic, strong) NSString *imgUrl;
/**
 *  类型
 */
@property (nonatomic, strong) NSString *saleType;
/**
 *  形式
 */
@property (nonatomic, strong) NSString *showType;
/**
 *  web地址
 */
@property (nonatomic, strong) NSString *webUrl;
/**
 *  描述
 */
@property (nonatomic, strong) NSString *desc;

- (instancetype) initWithDictionary:(NSDictionary *) dict;
+ (instancetype) bannerWithDictionary:(NSDictionary *) dict;

@end
