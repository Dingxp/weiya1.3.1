//
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/11/26.
//  Copyright © 2015年 mx. All rights reserved.
//

#import "SpeRecListViewController.h"
#import "BaseRequest.h"
#import "ZMProduct.h"
#import "ProListViewController.h"
#import "WYHomeTableViewCell01.h"
#import "ZMSpecialRecommendViewController.h"
#import "MJRefresh.h"
#import "MJExample.h"
@interface SpeRecListViewController ()
{
    NSArray*specArray;
    NSArray*imgArr;
}
@end

@implementation SpeRecListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置标题
    self.title=_cItem.channelItemName;
    
    //查询专题推荐列表
    [self requestChannelDetailByChannelItemId:_cItem.channelItemId];
    
    //创建表格
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
  _tableView.backgroundColor = RGBCOLOR(245, 245, 245);
    _tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
   
    self.view.backgroundColor=[UIColor whiteColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(245, 50, 109);;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"home_shareicon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return specArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *identified = @[@"cell01",@"cell02",@"cell03",@"cell04",@"cell05",@"cell06"];
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:identified[indexPath.section]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (!cell)
    {
        cell = [[WYHomeTableViewCell01 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identified[indexPath.section]];
    }
    ChannelItem *channelitem=specArray[indexPath.row];
    [((WYHomeTableViewCell01 *)cell).imgView sd_setImageWithURL:[NSURL URLWithString:imgArr[indexPath.row]]];
    ((WYHomeTableViewCell01 *)cell).imgDesc.hidden = NO;
    ((WYHomeTableViewCell01 *)cell).imgDesc.text=channelitem.desc;
    cell.backgroundColor=[UIColor whiteColor];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (APP_SCREEN_WIDTH - 20) * 320 / 708+10+40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    MJExample *exam = [[MJExample alloc] init];
    exam.methods = @[@"refurbishData"];
    ProListViewController *vc = [[ProListViewController alloc] init];
    vc.cItem = specArray[indexPath.row];
    vc.backStr=@"1";
    vc.hidesBottomBarWhenPushed=YES;
    [vc setValue:exam.methods[0] forKeyPath:@"method"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) requestChannelDetailByChannelItemId:(NSString *) cItemId{
    //NSString *url = @"app/crm/channel/v1.2.0/findCtxByCiId.do";
    NSString*url=[NSString stringWithFormat:@"app/crm/channel/%@/findCtxByCiId.do",ppVersion];

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:cItemId forKey:@"cItemId"];
    [SVProgressHUD showWithStatus:@"加载中"];
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        [SVProgressHUD dismiss];
       // NSLog(@"channel item:－－%@", responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"] && responseObject[@"result"])
        {
            NSArray*channelArrary=responseObject[@"result"];
            NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
            NSMutableArray *imgArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in channelArrary) {
                ChannelItem *channelitem = [ChannelItem bannerWithDictionary:dict];
                [tmpArray addObject:channelitem];
                [imgArray addObject:channelitem.imgUrl];
            }
            specArray=tmpArray;
            imgArr=imgArray;
            [_tableView reloadData];
            
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
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
   ZMUser* user=[ZMUser userWithDict:userDic];
    if (!user.userId)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"未登录" message:@"请您先登录！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
        [alert show];
        alert.delegate = self;
        return;
    }
    
    NSString*picture=self.cItem.imgUrl;
    
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:picture];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UMAPPKEY
                                      shareText:_cItem.channelItemName
                                     shareImage:nil
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline]
                                       delegate:nil];
    
    NSString*urlstr=[NSString stringWithFormat:@"http://m.weiyar.com/webapp/pro/itemList.jsp?cItemId=%@&saleType=4?inviteCode=%@",_cItem.channelItemId,user.invitationCode];
    NSLog(@"===%@",urlstr);
    [UMSocialData defaultData].extConfig.wechatSessionData.url = urlstr;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = urlstr;
    
    
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
