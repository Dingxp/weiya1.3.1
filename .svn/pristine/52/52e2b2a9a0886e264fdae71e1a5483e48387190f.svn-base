//
//  ZMUser.h
//  WY4iPhone
//
//  Created by ZM on 15/9/17.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequest.h"
#import "ZMAddress.h"
/**
 *  用户信息
 */
@interface ZMUser : NSObject
//用户芽客等级
@property (strong, nonatomic)NSString*grade;
// 出生日期
@property (nonatomic, strong) NSString *birthDay;
// 注册时间
@property (nonatomic, strong) NSString *createTime;
// 头像URL
@property (nonatomic, strong) NSString *headPic;
// 会员ID
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *identity;
/**
 *  专属码
 */
@property (nonatomic, strong) NSString *invitationCode;
@property (nonatomic, strong) NSString *isDelete;
// 昵称
@property (nonatomic, strong) NSString *nickName;
// 密码
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *realName;
// 性别
@property (nonatomic, strong) NSString *sex;
/**
 *  分享码
 */
@property (nonatomic, strong) NSString *sjwsInvitCode;
// 手机号
@property (nonatomic, strong) NSString *telNo;
// 修改时间
@property (nonatomic, strong) NSString *updateTime;
/**
 *  提现账号
 */
@property (nonatomic, strong) NSString *zfbAccount;
/**
 *  是否开店
 */
@property (nonatomic, strong) NSString *isShoped;
/**
 *  地址
 */
//@property (nonatomic, strong) NSString *addr;
@property (nonatomic, strong) ZMAddress *addrrss;
@property (nonatomic, assign) BOOL isLogin;

- (instancetype) initWithDict:(NSDictionary *) dict;
+ (instancetype) userWithDict:(NSDictionary *) dict;
+ (instancetype) userInstance;

- (instancetype) refreshUserInfo;



//-(void)refreshUserInstanceValue;
//-(void)saveUserInfo;

/**
 *  根据会员ID读取基本信息
 *
 *  @param userId <#userId description#>
 */
- (void) requestUserInfoByUserId:(NSString *)userId;

@end
