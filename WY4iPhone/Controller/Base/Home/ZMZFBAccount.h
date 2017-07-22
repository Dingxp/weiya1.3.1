//
//  ZMZFBAccount.h
//  WY4iPhone
//
//  Created by ZM21 on 15/10/14.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMZFBAccount : NSObject

@property (nonatomic, strong) NSString *zfbAccountId;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *telNo;
@property (nonatomic, strong) NSString *zfbAccount;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;
+ (instancetype) zfbAccountWithDictionary:(NSDictionary *)dictionary;

@end
