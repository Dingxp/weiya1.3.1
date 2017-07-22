//
//  ZMCoupon.m
//  WY4iPhone
//
//  Created by ZM on 15/10/14.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMCoupon.h"

@implementation ZMCoupon

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    [self setValuesForKeysWithDictionary:dict];
    return self;
}

+ (instancetype) couponWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _couponId = [NSString stringWithFormat:@"%ld", (long)[value integerValue]];
    }
}

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if([key isEqualToString:@"couponAmount"]){
        _couponAmount = [NSString stringWithFormat:@"%.2f", [value doubleValue]];
    } else if([key isEqualToString:@"couponType"]){
        _couponType = [NSString stringWithFormat:@"%ld", (long)[value integerValue]];
    } else if ([key isEqualToString:@"validity"]){
        _validity = [NSString stringWithFormat:@"%ld", (long)[value integerValue]];
    } else {
        
    }
}

- (id)valueForUndefinedKey:(NSString *)key{
//    NSLog(@"ZMCoupon valueForUndefinedKey:%@", key);
    return nil;
}

@end
