//
//  ZMCity.h
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/12/11.
//  Copyright © 2015年 mx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMCity : NSObject
@property (nonatomic, strong) NSString *addrcity;
@property (nonatomic, strong) NSArray *areaArr;
- (instancetype) initWithDictionary:(NSDictionary *)dictionary;
+ (instancetype) orderDetailsWithDictionary:(NSDictionary *)dictionary;
@end
