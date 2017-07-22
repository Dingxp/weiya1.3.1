//
//  ZMCouponList.m
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/12/14.
//  Copyright © 2015年 mx. All rights reserved.
//

#import "ZMCouponList.h"

@implementation ZMCouponList
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    [self setValuesForKeysWithDictionary:dict];
    return self;
}

+ (instancetype) orderDetailsWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _couponId = [NSString stringWithFormat:@"%ld", (long)[value integerValue]];
    }

}

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if([key isEqualToString:@"couponAmount"]){
        _couponAmount = [NSString stringWithFormat:@"%ld", [value integerValue]];
    } else if([key isEqualToString:@"couponType"]){
        _couponType = [NSString stringWithFormat:@"%ld", [value integerValue]];
    }else if([key isEqualToString:@"isUsed"]){
        _isUsed = [NSString stringWithFormat:@"%ld", [value integerValue]];
    } else if([key isEqualToString:@"validity"]){
        _validity = [NSString stringWithFormat:@"%ld", [value integerValue]];
    }else if([key isEqualToString:@"beginDate"]){
        _beginDate = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"couponName"]){
        _couponName = [NSString stringWithFormat:@"%@", value];
    }
    else if([key isEqualToString:@"createTime"]){
        _createTime = [NSString stringWithFormat:@"%@", value];
    }
    else if([key isEqualToString:@"endDate"]){
        _endDate = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"desc"]){
        _desc = [NSString stringWithFormat:@"%@", value];
    }
    else if([key isEqualToString:@"remainderTime"]){
        _remainderTime = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"expireState"]){
        _expireState = [NSString stringWithFormat:@"%ld", [value integerValue]];
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
