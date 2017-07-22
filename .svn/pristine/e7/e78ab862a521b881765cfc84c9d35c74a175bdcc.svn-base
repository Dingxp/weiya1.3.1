//
//  ZMPaySuccessFromConfirmViewController.m
//  WY4iPhone
//
//  Created by ZM on 15/10/14.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMPaySuccessFromConfirmViewController.h"
#import "ZMUser.h"
#import "UMSocial.h"
#import "LoginViewController.h"
@interface ZMPaySuccessFromConfirmViewController ()
{
    ZMUser*user;
}
@end

@implementation ZMPaySuccessFromConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    user=[ZMUser userWithDict:userDic];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"home_shareicon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        LoginViewController* loginVC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}
-(void)shareAction
{
    if (!user.userId)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"未登录" message:@"请您先登录！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
        [alert show];
        alert.delegate = self;
        return;
    }
    
    
    //                NSLog(@"data= %@",responseObject);
    
    
    
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UMAPPKEY
                                      shareText:@"微芽"
                                     shareImage:nil
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline]
                                       delegate:nil];
    NSString*urlstr=[NSString stringWithFormat:@"http://m.weiyar.com/webapp/index.jsp?inviteCode=%@",user.invitationCode];
    //NSLog(@"===%@",urlstr);
    [UMSocialData defaultData].extConfig.wechatSessionData.url = urlstr;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = urlstr;
    //
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 禁用 iOS7 返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"PageOne"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"PageOne"];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}


- (void) loadData{
    self.labelOrderAmount.text = [NSString stringWithFormat:@"￥%@", _orderDetails.amount];
    self.labelOrderNum.text = [NSString stringWithFormat:@"%@", _orderDetails.expressNum];
    
    switch ([_orderDetails.orderState integerValue]) {
        case 0:// 已取消
            self.lbOrderNum.text = @"已取消";
            break;
        case 1:// 待审核
            self.lbOrderNum.text = @"待审核";
            break;
        case 2:// 待发货
            self.lbOrderNum.text = @"待发货";
            break;
        case 3:// 已发货
            self.lbOrderNum.text = @"已发货";
            break;
        case 5:// 退货中
            self.lbOrderNum.text = @"退货中";
            break;
        case 6:// 待退款
            self.lbOrderNum.text = @"待退款";
            break;
        case 4:// 已完成
            self.lbOrderNum.text = @"已完成";
            break;
        case 7:// 已退款
            self.lbOrderNum.text = @"已退款";
            break;
            
        default:
            break;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
