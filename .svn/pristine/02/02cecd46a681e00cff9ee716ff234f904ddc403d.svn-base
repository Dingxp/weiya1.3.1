//
//  ZMShoppingCartPro.m
//  WY4iPhone
//
//  Created by ZM21 on 15/9/23.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMShoppingCartPro.h"

@implementation ZMShoppingCartPro

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    [self setValuesForKeysWithDictionary:dict];
    return self;
}

+ (instancetype) shoppingCartProWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        NSNumber *number = value;
        _shoppingCartProId = [self nsnumberToNsstring:number];
    }}

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if([key isEqualToString:@"proId"]){
        NSNumber *number = value;
        _proId = [self nsnumberToNsstring:number];
    } else if([key isEqualToString:@"isBW"]){
        NSNumber *number = value;
        _isBW = [self nsnumberToNsstring:number];
    }
    else if([key isEqualToString:@"quantity"]){
        NSNumber *number = value;
        _quantity = [self nsnumberToNsstring:number];
    }else if([key isEqualToString:@"price"]){
        _price = [NSString stringWithFormat:@"%.2f", [value doubleValue]];
    }else {
        
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
