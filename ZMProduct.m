//
//  ZMProduct.m
//  WY4iPhone
//
//  Created by ZM on 15/9/22.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMProduct.h"

@implementation ZMProduct

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    [self setValuesForKeysWithDictionary:dict];
    return self;
}

+ (instancetype) productWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        NSNumber *number = value;
        _productId = [self nsnumberToNsstring:number];
    }}

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if([key isEqualToString:@"currentPrice"]){
        _currentPrice = [NSString stringWithFormat:@"%.2lf", [value doubleValue]];
    } else if([key isEqualToString:@"currentStock"]){
        NSNumber *number = value;
        _currentStock = [self nsnumberToNsstring:number];
    } else if([key isEqualToString:@"oldPrice"]){
       _oldPrice = [NSString stringWithFormat:@"%.2lf", [value doubleValue]];
    } else if([key isEqualToString:@"totalComm"]){
        _totalComm = [NSString stringWithFormat:@"%.2lf", [value doubleValue]];
    }
    else if([key isEqualToString:@"imgUrl"]){
        _imgaeUrl= [NSString stringWithFormat:@"%.2lf", [value doubleValue]];
    }
    else if([key isEqualToString:@"proId"]){
        _proId = [NSString stringWithFormat:@"%.ld", [value integerValue]];
    }else if([key isEqualToString:@"bandId"]){
        _bandId = [NSString stringWithFormat:@"%.ld", [value integerValue]];
    } else if([key isEqualToString:@"ranking"]){
        _ranking = [NSString stringWithFormat:@"%.@", value];
    }  else if([key isEqualToString:@"bandName"]){
        _bandName = [NSString stringWithFormat:@"%.@", value];
    }  else {
        
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
