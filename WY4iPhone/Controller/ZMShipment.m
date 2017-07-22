//
//  ZMShipment.m
//  WY4iPhone
//
//  Created by ZM21 on 15/9/27.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMShipment.h"

@implementation ZMShipment

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    [self setValuesForKeysWithDictionary:dict];
    return self;
}

+ (instancetype) shipmentWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        NSNumber *number = value;
        _shipmentId = [self nsnumberToNsstring:number];
    }}

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if([key isEqualToString:@"expressId"]){
        NSNumber *number = value;
        _expressId = [self nsnumberToNsstring:number];
    } else if([key isEqualToString:@"costType"]){
        NSNumber *number = value;
        _costType = [self nsnumberToNsstring:number];
    } else if([key isEqualToString:@"cost"]){
        _cost = [NSString stringWithFormat:@"%@", value];
    } else {
        
    }
}

- (id)valueForUndefinedKey:(NSString *)key{
//    NSLog(@"ZMTodayRecommend valueForUndefinedKey:%@", key);
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
