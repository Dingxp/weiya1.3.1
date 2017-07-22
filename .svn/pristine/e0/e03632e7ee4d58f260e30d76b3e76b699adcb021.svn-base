//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  MJCollectionViewController.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/6.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "ProListViewController.h"
#import "MJTestViewController.h"
#import "UIViewController+Example.h"
#import "MJRefresh.h"

#import "ZMBrandDetailCollectionViewCell.h"
#import "ProDetailViewController.h"
#import "UMSocial.h"
#import "ZMUser.h"

/**
 * 随机色
 */
#define MJRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

@interface ProListViewController(){
    NSArray *arrayResult;
    NSMutableArray *channelItemlist;
    NSString*channelItemId;
    NSString*shareId;
    NSString*titleNmae;
    NSDictionary*arraySpceialProDict;
    ZMUser*user;
    NSTimer *_Ftimer;;
}
/** 存放假数据 */
@property (strong, nonatomic) NSMutableArray *colors;
@end

@implementation ProListViewController
#pragma mark - 示例
#pragma mark UICollectionView 上下拉刷新
- (void)refurbishData
{
    __unsafe_unretained __typeof(self) weakSelf = self;
    
    // 下拉刷新
    self.collectionView.header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    [weakSelf.collectionView.header beginRefreshing];

}

#pragma mark - 数据相关
- (NSMutableArray *)colors
{
    if (!_colors) {
        self.colors = [NSMutableArray array];
    }
    return _colors;
}

#pragma mark - 其他

/**
 *  初始化
 */
- (id)init
{
    // UICollectionViewFlowLayout的初始化（与刷新控件无关）
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kCellWidth, kCellHeight);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    return [self initWithCollectionViewLayout:layout];
}

static NSString *const MJCollectionViewCellIdentifier = @"color";
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    user = [[ZMUser userInstance] refreshUserInfo];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"home_shareicon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(245, 50, 109);;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    channelItemlist=[NSMutableArray array];
    MJPerformSelectorLeakWarning(
                                 [self performSelector:NSSelectorFromString(self.method) withObject:nil];
                                 );
    //[self example21];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[ZMBrandDetailCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    //[self loadData];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}
- (void) loadData{
    //根据频道项ID查询该频道项下面的商品列表,查询某个活动下包含的明细列表
    if ([self.backStr isEqualToString:@"1"])
    {
        [self requestChannelDetailByChannelItemId:_cItem.channelItemId];
        self.navigationItem.title = _cItem.channelItemName;
        shareId=_cItem.channelItemId;
        titleNmae=_cItem.channelItemName;
        
    }
    else if ([self.backStr isEqualToString:@"2"])
    {
        [self requestChannelDetailByChannelItemId:_band.bandId];
        self.navigationItem.title = _band.bandName;
        shareId=_band.bandId;
        titleNmae=_band.bandName;
        
        
        
    }
    
    
    else
    {
        [self requestChannelDetailByChannelItemId:_cItem.channelItemId];
        shareId=_cItem.channelItemId;
        titleNmae=_cItem.channelItemName;
    }
    
    self.navigationItem.title=titleNmae;
}
#pragma mark - collection数据源代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // 设置尾部控件的显示和隐藏
//    self.collectionView.footer.hidden = self.colors.count == 0;
//    return self.colors.count;
    return channelItemlist.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZMChannelItem *channelItem = channelItemlist[indexPath.row];
    
    static NSString *identify = @"cell";
    ZMBrandDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
        //        NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来了。");
    }
    [cell.imgProduct sd_setImageWithURL:[NSURL URLWithString:channelItem.httpImgUrl]];
    cell.labelProductName.text = [NSString stringWithFormat:@"%@", channelItem.proName];
    cell.labelPrice.text = [NSString stringWithFormat:@"￥%@", channelItem.currentPrice];
    cell.labelOldPrice.attributedText = [[NSString stringWithFormat:@"￥%@", channelItem.oldPrice] addTextCenterLine];
    
    if ([channelItem.currentStock intValue]<=0)
    {
        cell.currentStock.hidden=NO;
        cell.currentStock.image=[UIImage imageNamed:@"sale_empty"];
    }
    else
    {
        cell.currentStock.hidden=YES;
    }
    
    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProDetailViewController*detailVC=[[ProDetailViewController alloc]init];
    detailVC.idString=@"4";
    detailVC.channelItem = channelItemlist[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];}

/**
 *  根据频道项ID查询该频道项下面的商品列表,查询某个活动下包含的明细列表
 *
 *  @param cItemId 频道项ID
 */
- (void) requestChannelDetailByChannelItemId:(NSString *) cItemId{
    [self.collectionView.header endRefreshing];
    [SVProgressHUD showWithStatus:@"加载中"];
    NSString *url;
    if ([self.backStr isEqualToString:@"2"])
    {
        url = @"app/product/pro/findProList.do";
    }
    else
    {
       url=[NSString stringWithFormat:@"app/crm/channel/%@/findCtxByCiId.do",ppVersion];

    }
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if ([self.backStr isEqualToString:@"2"])
    {
      [params setValue:cItemId forKey:@"bandId"];
    }
    else
    {
      [params setValue:cItemId forKey:@"cItemId"];
    }
    
        [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        [SVProgressHUD dismiss];
       // NSLog(@"channel item:==%@", responseObject);
        NSMutableArray *array = [[NSMutableArray alloc] init];
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            
            
            if ( [responseObject[@"result"] isKindOfClass:[NSDictionary class]])
            {
                NSDictionary*resDic=responseObject[@"result"];
                NSArray*arr=[resDic allKeys];
                if ([arr containsObject:@"result"])
                {
                    arrayResult = responseObject[@"result"][@"result"];
                    arraySpceialProDict=responseObject[@"result"];
                    for (NSDictionary *dict in arrayResult) {
                        [array addObject:[ZMChannelItem channelItemWithDictionary:dict]];
                    }
                    channelItemlist = array;
                    [self.collectionView reloadData];
                    if ([arraySpceialProDict[@"hasNext"] integerValue] ==1)
                    {
                        
                        // 上拉刷新
                        self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                            [self moreSpceialProduct];
                            
                        }];
                        
 
                    }else
                    {
                        self.collectionView.footer.hidden = YES;
                    }
                }
                
            }
            
            
        }
        else
        {
             self.collectionView.footer.hidden = YES;
            //[SVProgressHUD showErrorWithStatus:@"失败"];
        }
    } failure:^(NSError *error) {
        // NSLog(@"error:%@", [error localizedDescription]);
    }];
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
                                      shareText:titleNmae
                                     shareImage:nil
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline]
                                       delegate:nil];
    NSString*urlstr=[NSString stringWithFormat:@"http://m.weiyar.com/webapp/pro/itemList.jsp?cItemId=%@&saleType=2?inviteCode=%@",shareId,user.invitationCode];
    NSLog(@"===%@",urlstr);
    [UMSocialData defaultData].extConfig.wechatSessionData.url = urlstr;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = urlstr;
    //
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //    NSLog(@"index:%ld", (long)buttonIndex);
    if (buttonIndex == 0) { // 取消
        return;
    } else if(buttonIndex == 1) { // 登录
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.isThird = YES;
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:nil];
    }
}
-(void)moreSpceialProduct
{
    if ([arraySpceialProDict[@"hasNext"] integerValue] ==1) {// 有下一页
        [self requestMoreListChannelDetailByChannelItemId:shareId];
    } else {
        [self.collectionView.footer endRefreshing];
        self.collectionView.footer.hidden=YES;
    }
}
- (void) requestMoreListChannelDetailByChannelItemId:(NSString *) cItemId{
    
    //[SVProgressHUD showWithStatus:@"加载中"];
    NSString *url;
    if ([self.backStr isEqualToString:@"2"])
    {
        url = @"app/product/pro/findProList.do";
    }
    else
    {
        //url = @"app/crm/channel/v1.2.0/findCtxByCiId.do";
        url=[NSString stringWithFormat:@"app/crm/channel/%@/findCtxByCiId.do",ppVersion];

    }
    
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if ([self.backStr isEqualToString:@"2"])
    {
        [params setValue:cItemId forKey:@"bandId"];
    }
    else
    {
        [params setValue:cItemId forKey:@"cItemId"];
    }
    [params setValue:arraySpceialProDict[@"nextPage"] forKey:@"startPage"];
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        //[SVProgressHUD dismiss];
        //NSLog(@"channel item:==%@", responseObject);
        NSMutableArray *array = [[NSMutableArray alloc] init];
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            if ( [responseObject[@"result"] isKindOfClass:[NSDictionary class]])
            {
                NSDictionary*resDic=responseObject[@"result"];
                NSArray*arr=[resDic allKeys];
                if ([arr containsObject:@"result"])
                {
                    arrayResult = responseObject[@"result"][@"result"];
                    arraySpceialProDict=responseObject[@"result"];
                    for (NSDictionary *dict in arrayResult) {
                        [array addObject:[ZMChannelItem channelItemWithDictionary:dict]];
                    }
                    //channelItemlist = array;
                    [channelItemlist addObjectsFromArray:array];
                    // 结束刷新
                    [self.collectionView.footer endRefreshing];
                    [self.collectionView reloadData];
                    
                   
                    
                }
                
            }
            
        }
        else
        {
           [self.collectionView.footer endRefreshing];
            self.collectionView.footer.hidden=YES;
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
        }
    } failure:^(NSError *error) {
        // NSLog(@"error:%@", [error localizedDescription]);
    }];
}
@end
