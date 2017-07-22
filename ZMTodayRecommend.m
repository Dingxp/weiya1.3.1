//
//  ZMTodayRecommend.m
//  WY4iPhone
//
//  Created by ZM on 15/9/22.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMTodayRecommend.h"

@implementation ZMTodayRecommend

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    [self setValuesForKeysWithDictionary:dict];
    return self;
}

+ (instancetype) todayRecommendWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        NSNumber *number = value;
        _todayRecommendId = [self nsnumberToNsstring:number];
    }
}

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if([key isEqualToString:@"proId"]){
        NSNumber *number = value;
        _proId = [self nsnumberToNsstring:number];
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
