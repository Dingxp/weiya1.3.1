//
//  ZMEducation.m
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/12/18.
//  Copyright © 2015年 mx. All rights reserved.
//

#import "ZMEducation.h"

@implementation ZMEducation
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    [self setValuesForKeysWithDictionary:dict];
    return self;
}

+ (instancetype) EducationWithDictionary:(NSDictionary *)dictionary{
    return [[self alloc] initWithDictionary:dictionary];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if([key isEqualToString:@"createTime"]){
        _createTime = [NSString stringWithFormat:@"%@", value];
    }
    else if ([key isEqualToString:@"httpImgUrl"]){
        _httpImgUrl = [NSString stringWithFormat:@"%@", value];
        
    }else if ([key isEqualToString:@"readQuan"]){
        _readQuan = [NSString stringWithFormat:@"%ld",(long) [value integerValue]];
        
    }else if ([key isEqualToString:@"summary"]){
        _summary = [NSString stringWithFormat:@"%@", value];
        
    }else if ([key isEqualToString:@"linkUrl"]){
        _linkUrl = [NSString stringWithFormat:@"%@", value];
        
    }else if ([key isEqualToString:@"title"]){
        _title = [NSString stringWithFormat:@"%@", value];
        
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
