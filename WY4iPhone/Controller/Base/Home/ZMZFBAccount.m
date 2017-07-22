//
//  ZMZFBAccount.m
//  WY4iPhone
//
//  Created by ZM21 on 15/10/14.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMZFBAccount.h"

@implementation ZMZFBAccount

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    [self setValuesForKeysWithDictionary:dict];
    return self;
}

+ (instancetype) zfbAccountWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _zfbAccount = [NSString stringWithFormat:@"%ld", (long)[value integerValue]];
    }
}

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
   
}

- (id)valueForUndefinedKey:(NSString *)key{
//    NSLog(@"ZMCoupon valueForUndefinedKey:%@", key);
    return nil;
}

@end
