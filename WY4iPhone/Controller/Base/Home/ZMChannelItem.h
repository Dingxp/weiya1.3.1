//
//  ZMChannelItem.h
//  WY4iPhone
//
//  Created by ZM on 15/10/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMChannelItem : NSObject

@property (nonatomic, strong) NSString *bandId;
@property (nonatomic, strong) NSString *bandName;
@property (nonatomic, strong) NSString *bwName;
@property (nonatomic, strong) NSString *catId;
@property (nonatomic, strong) NSString *cateName;
@property (nonatomic, strong) NSString *currentPrice;
@property (nonatomic, strong) NSString *currentStock;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *httpImgUrl;
@property (nonatomic, strong) NSString *httpWebUrl;
@property (nonatomic, strong) NSString *channelItemId;
@property (nonatomic, strong) NSString *isBW;
@property (nonatomic, strong) NSString *oldPrice;
@property (nonatomic, strong) NSString *proId;
@property (nonatomic, strong) NSString *proName;
@property (nonatomic, strong) NSString *spec;
@property (nonatomic, strong) NSString *type;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;
+ (instancetype) channelItemWithDictionary:(NSDictionary *)dictionary;

@end
