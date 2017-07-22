//
//  AppImport.h
//  schoolmanageOS
//
//  Created by 旭朋  丁 on 15/2/3.
//  Copyright (c) 2015年 旭朋  丁. All rights reserved.
//

#ifndef schoolmanageOS_AppImport_h
#define schoolmanageOS_AppImport_h

#import "UIViewExt.h"
#import "SVProgressHUD.h"

//微信APPKey
#define WXAPPKey                    @"wx426ef02081f3de29"
//  友盟正式
#define UMAPPKEY                    @"55efd3c567e58e47460025fe"
//   友盟测试
//#define UMAPPKEY                    @"5617775967e58eda750032bb"


//设置RGB颜色
#define RGBCOLOR(r,g,b)             [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a)          [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define BaseTintRGB                 RGBCOLOR(245, 50, 109)
#define BaseBackViewRGB             RGBCOLOR(240, 240, 240)


//屏幕物理宽、高
#define APP_SCREEN_WIDTH            [UIScreen mainScreen].bounds.size.width
#define APP_SCREEN_HEIGHT           [UIScreen mainScreen].bounds.size.height

#define contentWidth                3859 + 225
#define contentHeigh                2240
#define topSpace                    64 + 10

#define BaseViewHeigh               APP_SCREEN_HEIGHT - 20 - self.navigationController.navigationBar.height

//沙盒存储路径
#define HomeDirectory               [NSHomeDirectory() stringByAppendingString:@"/Documents/"]

//缓存路径 ---- 清除缓存时使用
#define APP_CACHES_PATH             [NSSearchPathForDirectoriesInDomains (NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
// 用户信息存储目录
#define kUserInfoPath   @"userInfo"

// shareDSK appkey,注释的是自己在mob平台注册的账号
//#define kAppKey         @"a7cd2e701eca"
#define kAppKey     @"8cdaaf2fac9e"

//#define kAppSecret      @"3a115f7def5aedc024e215f40187611f"
#define kAppSecret      @"244cff20cd162b72716b1393e170e90c"
// 支付宝支付时用到的scheme
#define kScheme     @"WYAPayByAliScheme"
#define IOS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define ppVersion         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define appbulid          [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#endif
