//
//  ZMAddress.m
//  WY4iPhone
//
//  Created by ZM21 on 15/9/27.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMAddress.h"

@implementation ZMAddress

static dispatch_once_t onceToken;
static ZMAddress *addressInstance;

/**
 *  类方法，实例化ZMUser对象的单例
 *
 *  @param dict
 *
 *  @return
 */
+ (instancetype)addressInstance{
    dispatch_once(&onceToken, ^{
        addressInstance = [[ZMAddress alloc] init];
    });
    return addressInstance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    [self setValuesForKeysWithDictionary:dict];
    return self;
}

+ (instancetype) addressWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _addressId = [NSString stringWithFormat:@"%@", value];
    }}

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if([key isEqualToString:@"regUserId"]){
        _regUserId = [NSString stringWithFormat:@"%@", value];
    } else if([key isEqualToString:@"isDefault"]){
        _isDefault = [NSString stringWithFormat:@"%@", value];
    } else if([key isEqualToString:@"identityCard"])
    {
        _shenfenID = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"id"])
    {
        _addressId = [NSString stringWithFormat:@"%@", value];
    }
    else
    {
        
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
