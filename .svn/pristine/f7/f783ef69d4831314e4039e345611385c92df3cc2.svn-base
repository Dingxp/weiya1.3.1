//
//  UIColor+Fruitday.m
//  Fruitday
//
//  Created by Leo on 4/2/14.
//  Copyright (c) 2014 Fruitday. All rights reserved.
//

#import "UIColor+Fruitday.h"

@implementation UIColor (Fruitday)


+(UIColor *) fruitdayGreen {
    return [UIColor colorWithRed:60.0/255.0 green:140.0/255.0 blue:30.0/255.0 alpha:1];
}
//logo grean
//+(UIColor *) fruitdayGreen {
//    return [UIColor colorWithRed:100.0/255.0 green:150.0/255.0 blue:50.0/255.0 alpha:1];
//}
+(UIColor *) fruitdayOrange {
    return [UIColor colorWithRed:255.0/255.0 green:153.0/255.0 blue:51.0/255.0 alpha:1];
}
//logo orange
//+(UIColor *) fruitdayOrange {
//    return [UIColor colorWithRed:246.0/255.0 green:171.0/255.0 blue:0/255.0 alpha:1];
//}
//logo light grean
+(UIColor *) fruitdayLightGreen {
    return [UIColor colorWithRed:145.0/255.0 green:175.0/255.0 blue:60.0/255.0 alpha:1];
}
+(UIColor *) fruitdayTitleGray {
    return [UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1];
}

+(UIColor *) fruitdayBackgroundGray {
    return [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1];
}

+(UIColor *) fruitdayLightGray {
    return [UIColor colorWithRed:155.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:1];
}
+(UIColor *) fruitdayBusyBackground {
    return [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
}
+(UIColor *) fruitdayWhiteTransparent {
    return [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5];
}

+(UIColor *) fruitdayGSBackgroundGray {
    return [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1];
}

+(UIColor *) fruitdayGSLineGray {
    return [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1];
}
+(UIColor *) fruitdayTransparentGreen {
    return [UIColor colorWithRed:60.0/255.0 green:140.0/255.0 blue:30.0/255.0 alpha:0.7];
}

+(UIColor *) fruitdayTransparentOrange {
    return [UIColor colorWithRed:255.0/255.0 green:153.0/255.0 blue:51.0/255.0 alpha:0.7];
}
+(UIColor *) fruitdayTransparentGray {
    return [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3];
}

+ (UIColor *)fruitdayDescriptionText {
    return UIColorFromRGB(0x55, 0x55, 0x55);
}

+ (UIColor *)fruitdayBoldBlackText {
    return UIColorFromRGB(0x2B, 0x2B, 0x2B);
}

+ (UIColor *)fruitdayLightGaryText {
    return UIColorFromRGB(0xC4, 0xC4, 0xC4);
}

+ (UIColor *)fruitdayGaryText {
    return UIColorFromRGB(0xAA, 0xAA, 0xAA);
}

+ (UIColor *)fruitdayLine {
    return UIColorFromRGB(0xD8, 0xD8, 0xD8);
}

+ (UIColor *)fruitdaLightGaryyLine {
    return UIColorFromRGB(0xE8, 0xE8, 0xE8);
}

+ (UIColor *)colorWithHexString:(NSString *)color{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}
@end
