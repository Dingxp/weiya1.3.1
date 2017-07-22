//
//  ZMcollectShopViewController.m
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/11/19.
//  Copyright © 2015年 mx. All rights reserved.
//

#import "ZMcollectShopViewController.h"
#import "BaseRequest.h"
#import "ZMUser.h"
#import "ZMProduct.h"
#import "UIImageView+WebCache.h"
#import "ProDetailViewController.h"
#import "ZMUITableViewCell.h"
#import "ZMBrandItemViewController.h"
#import "ZMChannelItem.h"
#import "MJRefresh.h"
@interface ZMcollectShopViewController ()
{
    ZMUser*user;
    UILabel*tipsEmpty;
}
@end

@implementation ZMcollectShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(245, 50, 109);;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationItem.title = @"我的收藏";
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    user=[ZMUser userWithDict:userDic];
     [self collectShoplist];
    //  加载数据
    [self initWith];
    
    
}
//导航回来, 进行数据刷新

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"PageOne"];
    [self collectShoplist];
    [_tableView reloadData];

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"PageOne"];
}
-(void)loadData
{
    [_tableView.header endRefreshing];
}
-(void)initWith
{   // 创建表
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-self.navigationController.navigationBar.bottom) style:UITableViewStyleGrouped];
    //  代理与数据源
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = RGBCOLOR(240, 240, 240);
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
   
    [self.view addSubview:_tableView];
}
//加载更多数据
-(void)moreProduct
{
    if ([_arraySpceialProDict[@"hasNext"] integerValue] >0) {// 有下一页
        [self collectMoreShoplist];

    } else {
        [_tableView.footer endRefreshing];
        _tableView.footer.hidden = YES;
    }

}
#pragma UITableView的一系列方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _collectArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZMUITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    ZMChannelItem*channelItem=_collectArray[indexPath.row];
    
    cell.backgroundColor=[UIColor whiteColor];
    if (!cell)
    {
      cell = [[ZMUITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    NSArray*subviews = [[NSArray alloc]initWithArray:cell.contentView.subviews];
    
    for (UIView *subview in subviews) {
        
        [subview removeFromSuperview];
        
    }
    cell.channelItem=channelItem;

                
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}
//  点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ProDetailViewController*  vc = [[ProDetailViewController alloc] init];
    vc.channelItem = _collectArray[indexPath.row];
    vc.idString=@"3";
    //  设置 UITableBar隐藏
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
//  获得收藏请求
-(void)collectShoplist
{    NSString *url = @"app/crm/favPro/findFavProList.do";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (user.userId)
    {
       [params setValue:user.userId forKey:@"regUserId"];
        
    }
    [params setValue:@"1" forKey:@"type"];
    if ([_arraySpceialProDict[@"hasNext"] integerValue] >0)
    {
        [params setValue:_arraySpceialProDict[@"hasNext"] forKey:@"startPage"];
    }
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
       // NSLog(@"---%@",responseObject);
        _arraySpceialProDict=responseObject[@"result"];
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            if ( [responseObject[@"result"] isKindOfClass:[NSDictionary class]])
            {
                NSDictionary*resDic=responseObject[@"result"];
                NSArray*arr=[resDic allKeys];
                if ([arr containsObject:@"result"])
                {
                    if (responseObject[@"result"][@"result"]==nil)
                    {
                        return ;
                    }
                    NSArray *array = responseObject[@"result"][@"result"];
                    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
                    for (NSDictionary *dict in array) {
                        ZMChannelItem*channelItem=[ZMChannelItem channelItemWithDictionary:dict];
                        [tmpArray addObject:channelItem];
                    }
                    _collectArray=tmpArray;
                    if (_collectArray.count==0)
                    {
                        
                        tipsEmpty = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - self.navigationController.navigationBar.bottom - self.tabBarController.tabBar.height)];
                        tipsEmpty.textAlignment = NSTextAlignmentCenter;
                        tipsEmpty.text = @"没有收藏的商品，赶紧去收藏!";
                        tipsEmpty.textColor = RGBCOLOR(102, 102, 102);
                        [self.view addSubview:tipsEmpty];
                    }
                    if ([responseObject[@"result"][@"hasNext"] integerValue] ==0)
                    {
                        
                    }
                    else
                    {
                        _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreProduct)];
                    }
                    [_tableView reloadData];
                    
                    
                }
 
            }
            
            
        }
    } failure:^(NSError *error) {
        //        NSLog(@"requestNumOfCouponByUserId error: %@", [error localizedDescription]);
    }];
}
//  获得更多收藏请求
-(void)collectMoreShoplist
{    NSString *url = @"app/crm/favPro/findFavProList.do";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (user.userId)
    {
        [params setValue:user.userId forKey:@"regUserId"];
        
    }
    [params setValue:@"1" forKey:@"type"];
    if ([_arraySpceialProDict[@"hasNext"] integerValue] >0)
    {
        [params setValue:_arraySpceialProDict[@"nextPage"] forKey:@"startPage"];
    }
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        // NSLog(@"---%@",responseObject);
        _arraySpceialProDict=responseObject[@"result"];
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            if ( [responseObject[@"result"] isKindOfClass:[NSDictionary class]])
            {
                NSDictionary*resDic=responseObject[@"result"];
                NSArray*arr=[resDic allKeys];
                if ([arr containsObject:@"result"])
                {
                    if (responseObject[@"result"][@"result"]==nil)
                    {
                        return ;
                    }
                    NSArray *array = responseObject[@"result"][@"result"];
                    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
                    for (NSDictionary *dict in array) {
                        ZMChannelItem*channelItem=[ZMChannelItem channelItemWithDictionary:dict];
                        [tmpArray addObject:channelItem];
                    }
                    [_collectArray addObjectsFromArray:tmpArray];
                    [_tableView reloadData];
                    
                    
                }
  
            }
           
        }
    } failure:^(NSError *error) {
        //        NSLog(@"requestNumOfCouponByUserId error: %@", [error localizedDescription]);
    }];
}

/**
 *  富文本，拼接字符串
 *
 *  @param preStr 待拼接的字符串1
 *  @param str    待拼接的字符串2
 *
 *  @return 拼接好的字符串
 */
- (NSMutableAttributedString *) parserString:(NSString *)preStr withContentStr:(NSString *)str{
    NSString *postStr = [NSString stringWithFormat:@"%@%@", preStr, str];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:postStr];
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:RGBCOLOR(115, 115, 115)
                       range:NSMakeRange(0, preStr.length)];
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:RGBCOLOR(238, 68, 100)
                       range:NSMakeRange(preStr.length, str.length)];
    UIFont *preFont = [UIFont systemFontOfSize:12];
    [attrString addAttribute:NSFontAttributeName value:preFont range:NSMakeRange(0, preStr.length)];
    
    UIFont *font = [UIFont systemFontOfSize:17];
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(preStr.length, str.length)];
    
    //    cell.textLabel.attributedText = attrString;
    return attrString;
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
