//
//  ZMShoppingCartPro.h
//  WY4iPhone
//
//  Created by ZM21 on 15/9/23.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMShoppingCartPro : NSObject

@property (nonatomic, strong) NSString *bandName;
@property (nonatomic, strong) NSString *httpImgUrl;
@property (nonatomic, strong) NSString *shoppingCartProId;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *proId;
@property (nonatomic, strong) NSString *proName;
@property (nonatomic, strong) NSString *quantity;
@property (nonatomic, strong) NSString *spec;
@property (nonatomic, strong) NSString *isBW;
@property (nonatomic, assign) BOOL isSelected;

- (instancetype) initWithDictionary:(NSDictionary *)dict;
+ (instancetype) shoppingCartProWithDictionary:(NSDictionary *)dict;

@end
