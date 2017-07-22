//
//  ZMShoppingCart.h
//  WY4iPhone
//
//  Created by ZM on 15/9/23.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZMShoppingCartPro.h"
#import <UIKit/UIKit.h>

@interface ZMShoppingCart : NSObject

@property (nonatomic, strong) NSMutableArray *shoppingCartProList;

+ (instancetype) shoppingCartInstance;
//- (instancetype) initWithDictionary:(NSDictionary *)dict;
//+ (instancetype) shoppingCartWithDictionary:(NSDictionary *)dict;

/**
 *  获取和刷新购物车的数据
 *
 *  @param userId  会员ID
 *  @param success 主要用于方法回掉，例如刷新UI界面
 */
- (void) refreshShoppingCartWithUserId:(NSString *)userId success:(void (^)())success;

/**
 *  获取和刷新购物车的数据
 *
 *  @param userId  会员ID
 */
//- (void)refreshShoppingCartWithUserId:(NSString *)userId;

/**
 *  删除购物车商品
 *
 *  @param proId  商品ID
 *  @param userId 会员ID
 */
- (void) deleteProductWithProId:(NSString *)proIds userId:(NSString *) userId success:(void(^)())success;


@end
