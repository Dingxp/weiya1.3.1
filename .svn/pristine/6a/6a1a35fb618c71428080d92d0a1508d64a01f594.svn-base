//
//  ZMShoppingCart.m
//  WY4iPhone
//
//  Created by ZM on 15/9/23.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMShoppingCart.h"
#import "BaseRequest.h"

@interface ZMShoppingCart (){
    BaseRequest *baseRequest;
}

@end

@implementation ZMShoppingCart

static dispatch_once_t onceToken;
static ZMShoppingCart *shoppingCartInstance;

/**
 *  购物车单例对象
 *
 *  @return 购物车的单例对象
 */
+ (instancetype) shoppingCartInstance{
    dispatch_once(&onceToken, ^{
        shoppingCartInstance = [[ZMShoppingCart alloc] init];
        if (shoppingCartInstance.shoppingCartProList == nil) {
            shoppingCartInstance.shoppingCartProList  = [[NSMutableArray alloc] init];
        }
    });
    return shoppingCartInstance;
}


- (void)refreshShoppingCartWithUserId:(NSString *)userId success:(void (^)())success{
    baseRequest = [BaseRequest sharedInstance];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params removeAllObjects];
    [params setValue:userId forKey:@"regUserId"];
    if (userId==nil)
    {
        return;
    }
    NSString *url = @"app/cart/cartPro/findCartProList.do";
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        if ([responseObject[@"statu"] isEqualToString:@"false"]) {
            //NSLog(@"find cart pro list:%@", responseObject[@"result"]);
            return ;
        }
        NSLog(@"%@", responseObject);
        if ( [responseObject[@"result"] isKindOfClass:[NSDictionary class]])
        {
            NSDictionary*resDic=responseObject[@"result"];
            NSArray*arr=[resDic allKeys];
            if ([arr containsObject:@"result"])
            {
                if (responseObject[@"result"][@"result"]==nil)
                {
                    return;
                }
                NSArray *array = responseObject[@"result"][@"result"];
                NSMutableArray *shoppingCartList = [[NSMutableArray alloc] init];
                for (NSDictionary *dict in array) {
                    ZMShoppingCartPro *pro = [ZMShoppingCartPro shoppingCartProWithDictionary:dict];
                    pro.isSelected = NO;
                    [shoppingCartList addObject:pro];
                }
                [ZMShoppingCart shoppingCartInstance].shoppingCartProList = shoppingCartList;
                success();
            }
  
        }
        
    } failure:^(NSError *error) {
//        NSLog(@"error: %@", [error localizedDescription]);
    }];
}


- (void) deleteProductWithProId:(NSString *)proId userId:(NSString *)userId success:(void(^)())success{
    NSString *url = @"app/cart/cartPro/deleteCartPro.do";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setValue:proIds forKey:@"cartProIds"];
    [params setValue:userId forKey:@"regUserId"];
    
//    NSMutableDictionary *proIds = [[NSMutableDictionary alloc] init];
//    [proIds setValue:proId forKey:@"cartProId"];
    
    [params setValue:proId forKey:@"cartProIds"];
    
    
    [baseRequest request:url parameters:params success:^(id responseObject) {
        if ([responseObject[@"statu"] isEqualToString:@"false"]) {

            return ;
        }
        success();

    } failure:^(NSError *error) {
//        NSLog(@"error: %@", [error localizedDescription]);
    }];
}

@end
