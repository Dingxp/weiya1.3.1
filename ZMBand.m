//
//  ZMBand.m
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/12/3.
//  Copyright © 2015年 mx. All rights reserved.
//

#import "ZMBand.h"

@implementation ZMBand

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    [self setValuesForKeysWithDictionary:dict];
    return self;
}

+ (instancetype) productWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"httpImgUrl"])
    {
      _httpImgUrl=[NSString stringWithFormat:@"%.@", value];
    }else if([key isEqualToString:@"bandId"]){
        _bandId = [NSString stringWithFormat:@"%.ld", [value integerValue]];
    }
     else if([key isEqualToString:@"bandName"]){
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
