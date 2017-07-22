//
//  AppDelegate.m
//  WY4iPhone
//
//  Created by mx on 15/8/31.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "AppDelegate.h"
#import "WYATabbarController.h"
#import <SMS_SDK/SMS_SDK.h>
#import <AlipaySDK/AlipaySDK.h>
#import "GuideScrollView.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "ZMPayFailedViewController.h"
#import "ZMPaySuccessViewController.h"
#import "WYAOrderConfirmViewController.h"
#import "ZMUser.h"
#import "BaseRequest.h"
#import "ZMOrderDetails.h"
#import "UMFeedback.h"
#import "UMessage.h"
#import "UMOpus.h"
#import "MobClick.h"
#define kLoginUrl       @"app/crm/reguser/login.do"

@interface AppDelegate (){
    GuideScrollView *guideScroll;
    BaseRequest *baseRequest;
    ZMUser *user;
     ZMOrderDetails *orderDetails;
    NSString *currentVersion;
    NSString *currentBulid;
    NSString*bulidUrl;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [MobClick startWithAppkey:UMAPPKEY reportPolicy:BATCH   channelId:nil];
    [WXApi registerApp:WXAPPKey withDescription:@"Weiya"];
    [UMSocialData setAppKey:UMAPPKEY];
    //友盟统计
    [MobClick startWithAppkey:UMAPPKEY reportPolicy:BATCH   channelId:nil];
    [MobClick setAppVersion:ppVersion];
    [UMSocialWechatHandler setWXAppId:WXAPPKey appSecret:@"264213cc7a922a0855caa3f706a760a6" url:@"http://www.umeng.com/social"];
     [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
    [UMFeedback setAppkey:UMAPPKEY];
     [UMessage startWithAppkey:UMAPPKEY launchOptions:launchOptions];
     #if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    if (IOS_8_OR_LATER) {
        //register remoteNotification types
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
    } else {
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge |
         UIRemoteNotificationTypeSound |
         UIRemoteNotificationTypeAlert];
    }
#else
    
    //register remoteNotification types (iOS 8.0以下)
    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
     |UIRemoteNotificationTypeSound
     |UIRemoteNotificationTypeAlert];
    
#endif
   
    //打开调试日志
    [UMessage setLogEnabled:YES];
    //自动清空角标，默认YES
    [UMessage setBadgeClear:NO];
    //当前APP发送渠道，默认App Store
    
    [UMessage setChannel:@"App Store"];
    
    //关闭状态时点击反馈消息进入反馈页
    NSDictionary *notificationDict = [launchOptions valueForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    [UMFeedback didReceiveRemoteNotification:notificationDict];
    [UMOpus setAudioEnable:NO];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    self.window = _window;
    //获取版本号与build
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    currentBulid = [infoDic objectForKey:@"CFBundleVersion"];
    [self requestRegUserAndWsxxByRegUserId];
    [self confirmButtonClick];
    WYATabbarController* tabBarController = [WYATabbarController new];
    self.window.rootViewController = tabBarController;
    
    [SMS_SDK registerApp:kAppKey withSecret:kAppSecret];
    
    [_window makeKeyAndVisible];
    
    //判断是否第一次登录
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"isGuide"] == nil) {

        [self initGuide];
    }
    
    return YES;
}

- (void)initGuide
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isGuide"];
    
    guideScroll = [[GuideScrollView alloc]initWithFrame:self.window.bounds];
    
    NSArray *arry = @[@"q1",@"q2",@"q3",@"q4"];
    
    [guideScroll scrollWithImages:arry];
    
    
    [_window addSubview:guideScroll];
}
// 网络请求是否版本更新
- (void) requestRegUserAndWsxxByRegUserId{
    NSString *url = @"app/sys/clientversion/findNewestClientVersion.do";
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:currentVersion forKey:@"version"];
    [params setValue:currentBulid forKey:@"build"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject)
    {
      // NSLog(@"用户和微商信息: %@",responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"])
        {
            if (responseObject[@"result"]==nil)
            {
                return ;
            }
            bulidUrl=responseObject[@"result"][@"downloadUrl"];
            if (currentBulid<responseObject[@"result"][@"build"])
            {
                if ([responseObject[@"result"][@"isMustUpdate"] intValue]==1)
                {
                    //等于1是必须版本更新
                    UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"检测到新版本，是否更新" message:@"" delegate:self cancelButtonTitle:@"更新" otherButtonTitles: nil];
                    [alertView show];
                    alertView.tag=110;
                    alertView.delegate=self;
                    
                }
                else
                {   //等于0可以不更新
                    UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"检测到新版本，是否更新" message:@"" delegate:self cancelButtonTitle:@"更新" otherButtonTitles:@"忽略", nil];
                    [alertView show];
                    alertView.tag=120;
                    alertView.delegate=self;
                }
            }
            
        }
        else{
                   }
        
    } failure:^(NSError *error) {
     }];
}
//alertview的点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 110)
    {
        if (buttonIndex==0)
        {
            [self webView];
        }
        
    }
   else if (alertView.tag == 120)
    {
        if (buttonIndex == 0)
        {
            [self webView];
        }
        

    }
    else
    {
        [UMessage sendClickReportForRemoteNotification:self.userInfo];
    }

}
//跳转到app store
-(void)webView
{
    UIWebView*webView=[[UIWebView alloc]initWithFrame:self.window.bounds];
    [self.window addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:bulidUrl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3. 发送请求给服务器
    [webView loadRequest:request];
}
//检测用户信息
- (void)confirmButtonClick
{ NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic1 = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    user=[ZMUser userWithDict:userDic1];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    if (!user.telNo||!user.password)
    {
        return;
    }
    NSString *cachePath = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath];
     [dict setValue:[userDic objectForKey:@"telNo"] forKey:@"telNo"];
    [dict setValue:[userDic objectForKey:@"password"]forKey:@"password"];
    [[BaseRequest sharedInstance] request:kLoginUrl parameters:dict success:^(id responseObject) {
        NSLog(@"会员信息%@",responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            if (responseObject[@"result"]==nil)
            {
                return ;
            }
            NSString*passWord=[userDic objectForKey:@"password"];
            NSMutableDictionary*dic=responseObject[@"result"];
            NSMutableDictionary*infoDic=[NSMutableDictionary dictionaryWithDictionary:dic];
            [infoDic setObject:passWord forKey:@"password"];
            [self writeToCachePath:infoDic];

 
        } else {
            [self deleteUserInfo];
        }
    } failure:^(NSError *error) {
        //[SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", [error localizedDescription]]];
    }];
   
    
}

//数据写入缓存
- (void)writeToCachePath:(id)cacheData {
    NSString *path = [HomeDirectory stringByAppendingString:kUserInfoPath];
    [cacheData writeToFile:path atomically:YES];
}
//删除本地存的用户信息
-(void)deleteUserInfo
{
    NSString *cachePath = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:cachePath error:nil];
    
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url
                                                  standbyCallback:^(NSDictionary *resultDic) {
                                                      //【由于在跳转支付宝客户端支付的过程中,商户 app 在后台很可能被系统 kill 了,所以 pay 接口的 callback 就会失效,请商户对 standbyCallback 返回的回调结果进行处理,就是在这个方法里面处理跟 callback 一样的逻辑】
                                                      //        NSLog(@"safepay result = %@",resultDic);
                                                  }];
        [[AlipaySDK defaultService] processAuth_V2Result:url
                                         standbyCallback:^(NSDictionary *resultDic) {
                                             //NSLog(@"result = %@",resultDic);NSString *resultStr = resultDic[@"result"];
                                             //NSLog(@"result = %@",resultStr);
                                         }];}
     if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中,商户 app 在后台很可能被系统 kill 了, 所以 pay 接口的 callback 就会失效,请商户对 standbyCallback 返回的回调结果进行处理,就 是在这个方法里面处理跟 callback 一样的逻辑】
            //            NSLog(@"platformapi result = %@",resultDic);
        }];
    }

    //如果极简开发包不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给开 发包
    if ([UMSocialSnsService handleOpenURL:url])
    {
        
        return [UMSocialSnsService handleOpenURL:url];
  
    }
    else
    {
        return [WXApi handleOpenURL:url delegate:self];
    }
}
-(void) onResp:(BaseResp*)resp
{
    
    

    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        
        
        switch (resp.errCode) {
            case WXSuccess:{
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"paymoney" object:@"success"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"paymoney1" object:@"success"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"paymoney2" object:@"success"];
              [[NSNotificationCenter defaultCenter] postNotificationName:@"paymoney3" object:@"success"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"paymoney4" object:@"success"];
                
                break;
            }
            default:{
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"paymoney" object:@"fail"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"paymoney1" object:@"fail"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"paymoney2" object:@"fail"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"paymoney3" object:@"fail"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"paymoney4" object:@"fail"];
                break;
            }
        }
    }
    
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    //    [UMessage didReceiveRemoteNotification:userInfo];
    [UMFeedback didReceiveRemoteNotification:userInfo];
     //[UMessage didReceiveRemoteNotification:userInfo];
    self.userInfo=userInfo;
    //关闭友盟自带的弹出框
      [UMessage setAutoAlert:NO];
        //定制自定的的弹出框
}
- (void)setFeedbackViewController:(UIViewController *)controller shouldPush:(BOOL)shouldPush
{
    [[UMFeedback sharedInstance] setFeedbackViewController:nil shouldPush:YES];
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [UMessage registerDeviceToken:deviceToken];
    NSLog(@"==%@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                  stringByReplacingOccurrencesOfString: @">" withString: @""]
                 stringByReplacingOccurrencesOfString: @" " withString: @""]);
}
@end
