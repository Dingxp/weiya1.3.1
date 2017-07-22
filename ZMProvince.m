//
//  ZMProvince.m
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/12/11.
//  Copyright © 2015年 mx. All rights reserved.
//

#import "ZMProvince.h"
#import "ZMCity.h"
@implementation ZMProvince
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
    if([key isEqualToString:@"address"]){
        _addrProvince = [NSString stringWithFormat:@"%@", value];
    } else if([key isEqualToString:@"subAddrList"]){
        NSArray *array = value;
        NSMutableArray *orderLists = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in array) {
            ZMCity *detail = [ZMCity orderDetailsWithDictionary:dict];
            [orderLists addObject:detail];
        }
        _cityArr = orderLists;
    }else
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
