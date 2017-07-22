//
//  ZMChannelItem.m
//  WY4iPhone
//
//  Created by ZM on 15/10/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMChannelItem.h"

@implementation ZMChannelItem

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    [self setValuesForKeysWithDictionary:dict];
    return self;
}

+ (instancetype) channelItemWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _channelItemId = [NSString stringWithFormat:@"%ld", (long)[value integerValue]];
    }
}

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if([key isEqualToString:@"proId"]){
        _proId = [NSString stringWithFormat:@"%ld", (long)[value integerValue]];
    } else if([key isEqualToString:@"bandId"]){
        _bandId = [NSString stringWithFormat:@"%ld", (long)[value integerValue]];
    } else if ([key isEqualToString:@"catId"]){
        _catId = [NSString stringWithFormat:@"%ld", (long)[value integerValue]];
    } else if ([key isEqualToString:@"isBW"]){
        _isBW= [NSString stringWithFormat:@"%ld", (long)[value integerValue]];
    } else if ([key isEqualToString:@"oldPrice"]){
        _oldPrice = [NSString stringWithFormat:@"%.2f", [value doubleValue]];
    } else if ([key isEqualToString:@"currentPrice"]){
        _currentPrice = [NSString stringWithFormat:@"%.2f", [value doubleValue]];
    } else if ([key isEqualToString:@"currentStock"]){
        _currentStock = [NSString stringWithFormat:@"%ld", (long)[value integerValue]];
    } else if ([key isEqualToString:@"type"]){
        _type = [NSString stringWithFormat:@"%ld", (long)[value integerValue]];
    } else {
        
    }
}

- (id)valueForUndefinedKey:(NSString *)key{
//    NSLog(@"ZMChannelItem valueForUndefinedKey:%@", key);
    return nil;
}

@end
