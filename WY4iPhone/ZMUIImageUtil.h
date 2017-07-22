//
//  ZMUIImageUtil.h
//  WY4iPhone
//
//  Created by ZM on 15/10/14.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMUIImageUtil : NSObject

/**
 *  指定宽度按比例缩放
 *
 *  @param sourceImage <#sourceImage description#>
 *  @param defineWidth <#defineWidth description#>
 *
 *  @return <#return value description#>
 */
+ (UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

@end
