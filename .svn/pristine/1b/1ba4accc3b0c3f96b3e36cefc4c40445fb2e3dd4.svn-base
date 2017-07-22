//

//  WY4iPhone
//
//  Created by ZM on 15/9/22.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ChannelItem.h"

@implementation ChannelItem

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    [self setValuesForKeysWithDictionary:dict];
    return self;
}

+ (instancetype)bannerWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _channelItemId = [NSString stringWithFormat:@"%ld", (long)[value integerValue]];
    }
}

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if([key isEqualToString:@"saleType"]){
        _saleType = [NSString stringWithFormat:@"%ld", [value integerValue]];
    } else if([key isEqualToString:@"showType"]){
        _showType = [NSString stringWithFormat:@"%ld", (long)[value integerValue]];
    }else if([key isEqualToString:@"imgUrl"]){
        _imgUrl = [NSString stringWithFormat:@"%@", value];
    } else if([key isEqualToString:@"webUrl"]){
        _webUrl = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"channelItemName"]){
        _channelItemName = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"desc"]){
        _desc = [NSString stringWithFormat:@"%@", value];
    }
}

- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

/**
 *  将NSNumber转化成NSString
 *
 *  @param number
 *
 *  @return NSString
 */
- (NSString *) nsnumberToNsstring:(NSNumber *)number{
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    return [numberFormatter stringFromNumber:number];
}

@end
