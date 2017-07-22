//
//  ZMProductDetail.m
//  WY4iPhone
//
//  Created by ZM on 15/9/23.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMProductDetail.h"

@implementation ZMProductDetail

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    [self setValuesForKeysWithDictionary:dict];
    return self;
}

+ (instancetype) productDetailWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _proDetailId = [NSString stringWithFormat:@"%ld", (long)[value integerValue]];
    }}

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if([key isEqualToString:@"currentPrice"]){
        _currentPrice = [NSString stringWithFormat:@"%.2f", [value doubleValue]];
    } else if([key isEqualToString:@"currentStock"]){
        _currentPrice = [NSString stringWithFormat:@"%.2lf", [value doubleValue]];
    } else if([key isEqualToString:@"oldPrice"]){
        _oldPrice = [NSString stringWithFormat:@"%.2f", [value doubleValue]];
    } else if([key isEqualToString:@"bandId"]){
        _bandId = [NSString stringWithFormat:@"%ld", (long)[value integerValue]];
    } else if([key isEqualToString:@"catId"]){
        _catId = [NSString stringWithFormat:@"%ld", (long)[value integerValue]];
    } else if([key isEqualToString:@"isBW"]){
        _isBW = [NSString stringWithFormat:@"%ld", (long)[value integerValue]];
    }else if([key isEqualToString:@"isFav"]){
        _isFav = [NSString stringWithFormat:@"%ld", (long)[value integerValue]];
    } else if([key isEqualToString:@"totalComm"]){
        _totalComm = [NSString stringWithFormat:@"%.2f", [value doubleValue]];
    }else if([key isEqualToString:@"discount"]){
        _discount = [NSString stringWithFormat:@"%.1f", [value floatValue]];
    }else if([key isEqualToString:@"httpImgUrl"]){
        _httpImgUrl = [NSString stringWithFormat:@"%@", value];
    }
    
    else {
    
    }
}

- (id)valueForUndefinedKey:(NSString *)key{
//    NSLog(@"ZMTodayRecommend valueForUndefinedKey:%@", key);
    return nil;
}

@end
