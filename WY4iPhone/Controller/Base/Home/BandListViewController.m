//
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/11/23.
//  Copyright © 2015年 mx. All rights reserved.
//

#import "BandListViewController.h"
#import "BaseRequest.h"
#import "WYHomeTableViewCell01.h"
#import "UIImageView+WebCache.h"
#import "ProListViewController.h"
#import "ZMSpecialRecommendViewController.h"
#import "ZMBand.h"
#import "ZMUser.h"
#import "WYTableViewCell07.h"
#import "LoginViewController.h"
#import "MJTestViewController.h"
#import "MJExample.h"
@interface BandListViewController ()
{
    ZMUser*user;
}
@end

@implementation BandListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=_cItem.channelItemName;
    [self initView];
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    user=[ZMUser userWithDict:userDic];    self.view.backgroundColor=[UIColor whiteColor];
    
    [self requestChannelDetailByChannelItemId:_cItem.channelItemId];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}
-(void)initView
{
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(245, 50, 109);;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"home_shareicon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _specialArr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYTableViewCell07*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell=[[WYTableViewCell07 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        ((WYTableViewCell07 *)cell).line.hidden=NO;
    }
    ZMBand*band = _specialArr[indexPath.row];
    [((WYTableViewCell07 *)cell).imgView sd_setImageWithURL:[NSURL URLWithString:band.httpImgUrl]];
    
    if (band.desc) {
        ((WYTableViewCell07 *)cell).imgDesc.hidden = NO;
        ((WYTableViewCell07 *)cell).bandName.text=band.bandName;
        CGFloat descWidth=[band.desc commonStringWidthForFont:14];
        ((WYTableViewCell07 *)cell).imgDesc.frame=CGRectMake(10, ((WYTableViewCell07 *)cell).imgView.bottom+5, descWidth, 37);
        
        ((WYTableViewCell07 *)cell).bandName.frame=CGRectMake(50+descWidth, ((WYTableViewCell07 *)cell).imgView.bottom+5, 150, 37);
    }
    else
    {
        ((WYTableViewCell07 *)cell).imgDesc.hidden =YES;
        
        ((WYTableViewCell07 *)cell).bandName.text=band.bandName;
        ((WYTableViewCell07 *)cell).bandName.frame=CGRectMake(10, ((WYTableViewCell07 *)cell).imgView.bottom+5, 150, 37);
    }
    
    
    cell.backgroundColor=[UIColor whiteColor];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (APP_SCREEN_WIDTH - 20) * 320 / 708+10+40+10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MJExample *exam = [[MJExample alloc] init];
    exam.methods = @[@"refurbishData"];
    ProListViewController *vc = [[ProListViewController alloc] init];
    vc.band = _specialArr[indexPath.row];
    vc.backStr=@"2";
    vc.hidesBottomBarWhenPushed=YES;
    [vc setValue:exam.methods[0] forKeyPath:@"method"];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) requestChannelDetailByChannelItemId:(NSString *) cItemId{
    //NSString *url = @"app/crm/channel/v1.2.0/findCtxByCiId.do";
    NSString*url=[NSString stringWithFormat:@"app/crm/channel/%@/findCtxByCiId.do",ppVersion];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:cItemId forKey:@"cItemId"];
    [SVProgressHUD showWithStatus:@"加载中"];

    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        [SVProgressHUD dismiss];
       // NSLog(@"channel item:==%@", responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"])
        {
            NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
            if (responseObject[@"result"]==nil)
            {
                return ;
            }
            NSArray*channelArrary=responseObject[@"result"];
            for (NSDictionary *dict in channelArrary) {
                
                ZMBand*band=[ZMBand productWithDictionary:dict];
                [tmpArray addObject:band];
                
            }
            _specialArr=tmpArray;
            [_tableView reloadData];
            
            
        }else{
            [SVProgressHUD showInfoWithStatus:@"网络异常"];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        //        NSLog(@"error:%@", [error localizedDescription]);
    }];
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
    
    NSString*picture=self.cItem.imgUrl;
    
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:picture];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UMAPPKEY
                                      shareText:_cItem.channelItemName
                                     shareImage:nil
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline]
                                       delegate:nil];
    //NSString*url=@"http://m.weiyar.com/webapp/invitation.jsp?invateCode=";
    //NSString*urlstr=[NSString stringWithFormat:@"http://m.weiyar.com/webapp/invitation.jsp?inviteCode=%@",[ZMUser userInstance].invitationCode];
    
    NSString*urlstr=[NSString stringWithFormat:@"http://m.weiyar.com/webapp/pro/itemList.jsp?cItemId=%@&saleType=4?inviteCode=%@",_cItem.channelItemId,[ZMUser userInstance].invitationCode];
    NSLog(@"===%@",urlstr);
    [UMSocialData defaultData].extConfig.wechatSessionData.url = urlstr;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = urlstr;
    
    
}
@end
