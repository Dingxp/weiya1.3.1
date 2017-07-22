//
//  ZMUser.m
//  WY4iPhone
//
//  Created by ZM on 15/9/17.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMUser.h"
#import "BaseRequest.h"

@interface ZMUser (){
    
}

@end

@implementation ZMUser

static dispatch_once_t onceToken;
static ZMUser *userInstance;

/**
 *  对象方法，通过NSDictionary来初始化一个ZMUser对象
 *
 *  @param dict
 *
 *  @return ZMUser对象
 */
- (instancetype)initWithDict:(NSDictionary *)dict{
    [self setValuesForKeysWithDictionary:dict];
    return self;
}

/**
 *  类方法，通过NSDictionary来初始化一个ZMUser对象
 *
 *  @param dict
 *
 *  @return ZMUser对象
 */
+ (instancetype)userWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

/**
 *  类方法，实例化ZMUser对象的单例
 *
 *  @param dict
 *
 *  @return
 */
+ (instancetype)userInstance{
    dispatch_once(&onceToken, ^{
        userInstance = [[ZMUser alloc] init];
    });
    return userInstance;
}

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if([key isEqualToString:@"sex"]){
        if ([value integerValue] == 1) {
            _sex = @"男";
        } else if([value integerValue] == 2) {
            _sex = @"女";
        }
         else {
            _sex = @"";
        }
    }
    else if([key isEqualToString:@"addr"]){
        _addrrss=[ZMAddress addressWithDictionary:value];
    }else if([key isEqualToString:@"addr"]){
        _addrrss=[ZMAddress addressWithDictionary:value];
    }else {
        
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _userId = [NSString stringWithFormat:@"%ld", (long)[value integerValue]];
    }
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

- (id)valueForUndefinedKey:(NSString *)key{
//    NSLog(@"ZMUser valueForUndefinedKey:%@", key);
    return nil;
}

-(instancetype)refreshUserInfo{
    NSString *cachePath = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithContentsOfFile:cachePath];
    
    ZMUser *u =  [[ZMUser userInstance] initWithDict:dict];
    if ([u.userId isEmpty] || u.userId == NULL) {
        [ZMUser userInstance].isLogin = NO;
    } else {
        [ZMUser userInstance].isLogin = YES;
    }
    return [ZMUser userInstance];
}
// 根据会员ID读取基本信息
- (void) requestUserInfoByUserId:(NSString *)userId{
   // NSString *url = @"app/crm/reguser/findRegUserById.do";
    NSString *url = @"wbusi/wbusiinfo/wbusiinfo/applyToWbusi.do";

     NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:userId forKey:@"regUserId"];
    NSString *cachePath = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath];
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
       NSLog(@"User info :%@", responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            NSString*passWord=[dict objectForKey:@"password"];
            NSMutableDictionary*dic=responseObject[@"result"];
            NSMutableDictionary*infoDic=[NSMutableDictionary dictionaryWithDictionary:dic];
            [infoDic setObject:passWord forKey:@"password"];
            [self writeToCachePath:infoDic];
        }
//        NSLog(@"user info:%@", responseObject);
    } failure:^(NSError *error) {
//        NSLog(@"request user info error:%@", [error localizedDescription]);
    }];
}

//数据写入缓存
- (void)writeToCachePath:(id)cacheData {
    NSString *path = [HomeDirectory stringByAppendingString:kUserInfoPath];
    [cacheData writeToFile:path atomically:YES];
}

@end
