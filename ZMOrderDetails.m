//
//  ZMOrderDetails.m
//  WY4iPhone
//
//  Created by ZM on 15/9/29.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMOrderDetails.h"
#import "ZMOrderDetail.h"

@implementation ZMOrderDetails

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    [self setValuesForKeysWithDictionary:dict];
    return self;
}

+ (instancetype) orderDetailsWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if([key isEqualToString:@"couponAmount"]){
        _couponAmount = [NSString stringWithFormat:@"%@", value];
    } else if([key isEqualToString:@"orderState"]){
        _orderState = [NSString stringWithFormat:@"%@", value];
    } else if ([key isEqualToString:@"amount"]){
        _amount = [NSString stringWithFormat:@"%.2f", [value doubleValue]];
    } else if ([key isEqualToString:@"payState"]){
        _payState= [NSString stringWithFormat:@"%@", value];
    } else if ([key isEqualToString:@"shipAmount"]){
        _shipAmount = [NSString stringWithFormat:@"%ld", (long)[value integerValue]];
    } else if ([key isEqualToString:@"shipState"]){
        _shipState = [NSString stringWithFormat:@"%@", value];
    } else if([key isEqualToString:@"items"]){
        NSArray *array = value;
        NSMutableArray *orderLists = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in array) {
            ZMOrderDetail *detail = [ZMOrderDetail orderDetailWithDictionary:dict];
            [orderLists addObject:detail];
        }
        _items = orderLists;
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
