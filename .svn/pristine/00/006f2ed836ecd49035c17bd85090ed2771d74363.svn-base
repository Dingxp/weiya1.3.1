//
//  FriendsViewController.m
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/12/29.
//  Copyright © 2015年 mx. All rights reserved.
//

#import "FriendsViewController.h"
#import "ZMContactListViewController.h"
#import "UMessage.h"
#import "UMSocial.h"
#import "ZMUser.h"
@interface FriendsViewController ()
{
    ZMUser*user;
}
@end

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    user=[ZMUser userWithDict:userDic];

    [self initView];
}
-(void)initView
{
    UIView*line=[[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 10)];
    line.backgroundColor=RGBCOLOR(230, 230, 230);
    [self.view addSubview:line];
    NSArray *datas = @[@{@"desc":@"通讯录",@"img":@"ca1"},
                       @{@"desc":@"微信好友",@"img":@"ca2"},
                       @{@"desc":@"朋友圈",@"img":@"ca3"},
                       ];
    //计算每个快捷入口按钮的宽度
    int tempWidth =APP_SCREEN_WIDTH/3;
    
    //遍历快捷入口数据
    for (int i=0; i<datas.count; i++)
    {
      
         NSDictionary *dic = datas[i];
        //定义view
        UIView*quickview=[[UIView alloc]initWithFrame:CGRectMake(i*tempWidth, 10, tempWidth, 90)];
        [self.view addSubview:quickview];
        
        //定义图片
        CGFloat width =(tempWidth-44)/2;
        UIImageView*quickImage=[[UIImageView alloc]initWithFrame:CGRectMake(width, 10, 44, 44)];
                [quickview addSubview:quickImage];
        quickImage.image=[UIImage imageNamed:dic[@"img"]];
        //定义文字
        UILabel*quickLab=[[UILabel alloc]initWithFrame:CGRectMake(0, quickImage.bottom+10, quickview.width, 15)];
        quickLab.text=dic[@"desc"];
        quickLab.textColor=RGBCOLOR(102, 102, 102);
        quickLab.font = [UIFont systemFontOfSize:15];
        quickLab.textAlignment = NSTextAlignmentCenter;
        [quickview addSubview:quickLab];
        quickview.userInteractionEnabled = YES;
        quickview.tag=i+1;
        
        //定义快捷入口手势操作
        UITapGestureRecognizer *singnalTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quickimgBtnClicked:)];
        [quickview addGestureRecognizer:singnalTap1];
    }
    UIView*line1=[[UIView alloc]initWithFrame:CGRectMake(APP_SCREEN_WIDTH/3, 10, 1, 90)];
    line1.backgroundColor=RGBCOLOR(230, 230, 230);
    [self.view addSubview:line1];
    UIView*line2=[[UIView alloc]initWithFrame:CGRectMake(2*APP_SCREEN_WIDTH/3, 10, 1, 90)];
    line2.backgroundColor=RGBCOLOR(230, 230, 230);
    [self.view addSubview:line2];
    UIView*line3=[[UIView alloc]initWithFrame:CGRectMake(0, 100, APP_SCREEN_WIDTH, 1)];
    line3.backgroundColor=RGBCOLOR(230, 230, 230);
    [self.view addSubview:line3];
    UILabel*lab=[[UILabel alloc]initWithFrame:CGRectMake(0, line3.bottom+20, APP_SCREEN_WIDTH, 44)];
    lab.text=@"  邀请更多好友参加,获取更多佣金。";
    lab.textColor=RGBCOLOR(102, 102, 102);
   // lab.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:lab];

    
}
- (void) quickimgBtnClicked:(UITapGestureRecognizer *) tap{
    if (tap.view.tag==1)
    {
        ZMContactListViewController*contact=[ZMContactListViewController new];
        [self.navigationController pushViewController:contact animated:YES];
    }else if (tap.view.tag==2)
    {
        [self shareFriend];
    }else
    {
        [self shareFriendLine];
    }
    
}
-(void)shareFriend
{
    NSString*str;
    if (user.invitationCode)
    {
        str=[NSString stringWithFormat:@"下载客户端立送10元红包，推荐朋友注册可返佣金。赶紧加入挣钱！分享码%@",user.invitationCode];
    }
    else
    {
        str=[NSString stringWithFormat:@"下载客户端立送10元红包，推荐朋友注册可返佣金。赶紧加入挣钱！"];
    }
    
    NSString*picture=@"http://7xkcnp.com2.z0.glb.qiniucdn.com/saleAct151229194528.png";
    
    NSString*urlstr=[NSString stringWithFormat:@"http://m.weiyar.com/webapp/invitation.jsp?inviteCode=%@",user.invitationCode];
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = urlstr;
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;       //设置分享内容和回调对象
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:picture];

    [[UMSocialControllerService defaultControllerService] setShareText:str shareImage:nil socialUIDelegate:nil];        //设置分享内容和回调对象
    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    
    

}
-(void)shareFriendLine
{
    NSString*str;
    if (user.invitationCode)
    {
        str=[NSString stringWithFormat:@"下载客户端立送10元红包，推荐朋友注册可返佣金。赶紧加入挣钱！分享码%@",user.invitationCode];
    }
    else
    {
        str=[NSString stringWithFormat:@"下载客户端立送10元红包，推荐朋友注册可返佣金。赶紧加入挣钱！"];
    }
    
    NSString*picture=@"http://7xkcnp.com2.z0.glb.qiniucdn.com/saleAct151229194528.png";
    
    NSString*urlstr=[NSString stringWithFormat:@"http://m.weiyar.com/webapp/invitation.jsp?inviteCode=%@",user.invitationCode];
    
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:picture];
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = urlstr;
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;       //设置分享内容和回调对象
    [[UMSocialControllerService defaultControllerService] setShareText:str shareImage:nil socialUIDelegate:nil];        //设置分享内容和回调对象
    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatTimeline].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
