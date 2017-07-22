//
//  ZMOrderDetail.m
//  WY4iPhone
//
//  Created by ZM on 15/9/29.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMOrderDetail.h"

@implementation ZMOrderDetail

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    [self setValuesForKeysWithDictionary:dict];
    self.isSelected = NO;
    return self;
}

+ (instancetype) orderDetailWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _orderDetailId = [NSString stringWithFormat:@"%@", value];
    }
}

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if([key isEqualToString:@"proId"]){
        _proId = [NSString stringWithFormat:@"%@", value];
    } else if([key isEqualToString:@"quantity"]){
        _quantity = [NSString stringWithFormat:@"%@", value];
    }else if ([key isEqualToString:@"amount"]){
        _amount = [NSString stringWithFormat:@"%@", value];
    } else if ([key isEqualToString:@"price"]){
        _price = [NSString stringWithFormat:@"%.2f", [value doubleValue]];
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
    ZMOrderDetail *orderDetail=[[self class] allocWithZone:zone];
    orderDetail.amount = _amount;
    orderDetail.bandName = _bandName;
    orderDetail.httpImgUrl = _httpImgUrl;
    orderDetail.orderDetailId = _orderDetailId;
    orderDetail.price = _price;
    orderDetail.proId = _proId;
    orderDetail.proName = _proName;
    orderDetail.quantity = _quantity;
    orderDetail.spec = _spec;
    orderDetail.isSelected = _isSelected;
    
    return orderDetail;
}

@end
