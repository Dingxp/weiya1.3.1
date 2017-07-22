//
//  ZMOrder.m
//  WY4iPhone
//
//  Created by ZM on 15/9/29.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMOrder.h"
#import "BaseRequest.h"

@implementation ZMOrder

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    [self setValuesForKeysWithDictionary:dict];
    return self;
}

+ (instancetype) orderWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _orderId = [NSString stringWithFormat:@"%@", value];
    }}

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if([key isEqualToString:@"orderState"]){
        _orderState = [NSString stringWithFormat:@"%@", value];
    } else if([key isEqualToString:@"payState"]){
        _payState = [NSString stringWithFormat:@"%@", value];
    }else if ([key isEqualToString:@"amount"]){
        _amount = [NSString stringWithFormat:@"%.2f", [value doubleValue]];
    } else if ([key isEqualToString:@"orderNum"]){
        _orderNum = [NSString stringWithFormat:@"%@", value];
    }else if ([key isEqualToString:@"regUserId"]){
        _regUserId = [NSString stringWithFormat:@"%@", value];
    } else if([key isEqualToString:@"items"]){
        NSArray *array = value;
        NSMutableArray *orderLists = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in array) {
            ZMOrderDetail *detail = [ZMOrderDetail orderDetailWithDictionary:dict];
            [orderLists addObject:detail];
        }
        _items = orderLists;
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

- (id)copyWithZone:(NSZone *)zone{
    //实现自定义浅拷贝
    ZMOrder *order=[[self class] allocWithZone:zone];
    order.amount = _amount;
    order.expressCode = _expressCode;
    order.expressName = _expressName;
    order.expressNum = _expressNum;
    order.orderId = _orderId;
    order.items = [_items copy];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (ZMOrderDetail *detail in order.items) {
        [array addObject:[detail copy]];
    }
    order.items = array;
    order.orderState = _orderState;
    order.orderTime = _orderTime;
    order.payState = _payState;
    order.regUserId = _regUserId;

    return order;
}

@end
