//
//  UserList.m
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/12/28.
//  Copyright © 2015年 mx. All rights reserved.
//

#import "UserList.h"

@implementation UserList

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    [self setValuesForKeysWithDictionary:dict];
    return self;
}

+ (instancetype) userWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        NSNumber *number = value;
        _rankId = [self nsnumberToNsstring:number];
    }}

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if([key isEqualToString:@"nickName"]){
        _nickName=[NSString stringWithFormat:@"%@",value];
    } if([key isEqualToString:@"ranking"]){
        _ranking=[NSString stringWithFormat:@"%@",value];
    } if([key isEqualToString:@"totalComm"]){
        _totalComm = [NSString stringWithFormat:@"%.2f", [value doubleValue]];
    }    else {
        
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
