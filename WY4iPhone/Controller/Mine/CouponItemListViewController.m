//
//  CouponItemListViewController.m
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/12/14.
//  Copyright © 2015年 mx. All rights reserved.
//

#import "CouponItemListViewController.h"
#import "BaseRequest.h"
#import "ZMUser.h"
#import "MJRefresh.h"
#import "CouponListTableViewCell.h"
#import "ZMCouponList.h"

@interface CouponItemListViewController ()
{
    NSDictionary*arraySpecialProList;
    ZMUser*user;
    UILabel*tipsEmpty;
}
@end

@implementation CouponItemListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(245, 50, 109);;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationItem.title = @"优惠劵列表";
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    user=[ZMUser userWithDict:userDic];
    [self requestNumOfCouponByUserId:user.userId];

    [self initView];
}
-(void)initView
{   // 创建表
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-self.navigationController.navigationBar.bottom) style:UITableViewStyleGrouped];
    //  代理与数据源
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = RGBCOLOR(240, 240, 240);
    [self.view addSubview:_tableView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _couponArray.count;
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
    CouponListTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
   
    
    cell.backgroundColor=[UIColor whiteColor];
    if (!cell)
    {
        cell = [[CouponListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    ZMCouponList*couponList=_couponArray[indexPath.row];
    cell.couponList=couponList;
    return cell;
}
-(void)moreProduct
{
    if ([arraySpecialProList[@"hasNext"] integerValue] >= 1) {// 有下一页
        [self requestNumOfCouponByUserId:user.userId startPage:arraySpecialProList[@"nextPage"]];
    } else {
        [_tableView.footer endRefreshing];
        _tableView.footer.hidden = YES;
    }
 
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return 10;
    }
    else
    {
        return 0;
    }
}
//获取优惠劵列表
- (void) requestNumOfCouponByUserId:(NSString *)userId{
    if (userId==nil)
    {
        return;
    }
    NSString *url = @"app/crm/coupon/findCouponItemList.do";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:userId forKey:@"regUserId"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
         //NSLog(@"requestNumOfCouponByUserId:%@",responseObject );
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
                        ZMCouponList*channelItem=[ZMCouponList orderDetailsWithDictionary:dict];
                        [tmpArray addObject:channelItem];
                    }
                    if ([responseObject[@"result"][@"hasNext"] integerValue] ==0)
                    {
                        
                    }
                    else
                    {
                        _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreProduct)];
                    }
                    _couponArray=tmpArray;
                    [_tableView reloadData];
                    
                    if (_couponArray.count==0)
                    {
                        tipsEmpty = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - self.navigationController.navigationBar.bottom - self.tabBarController.tabBar.height)];
                        tipsEmpty.textAlignment = NSTextAlignmentCenter;
                        tipsEmpty.text = @"没有优惠劵！";
                        tipsEmpty.textColor = RGBCOLOR(102, 102, 102);
                        [self.view addSubview:tipsEmpty];

                    }
                }
 
            }
            
                    }
    } failure:^(NSError *error) {
               //NSLog(@"requestNumOfCouponByUserId error: %@", [error localizedDescription]);
    }];
}
//获取更多优惠劵列表
- (void) requestNumOfCouponByUserId:(NSString *)userId startPage:(NSString*)startPage{
    if (userId==nil)
    {
        return;
    }
    NSString *url = @"app/crm/coupon/findCouponItemList.do";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:userId forKey:@"regUserId"];
    [params setValue:startPage forKey:@"startPage"];
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        NSLog(@"requestNumOfCouponByUserId:%@",responseObject );
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
                         ZMCouponList*channelItem=[ZMCouponList orderDetailsWithDictionary:dict];
                         [tmpArray addObject:channelItem];
                     }
                     [_couponArray addObjectsFromArray:tmpArray];
                     
                     [_tableView reloadData];
                 }
                 
 
             }
            
        }
    } failure:^(NSError *error) {
        //NSLog(@"requestNumOfCouponByUserId error: %@", [error localizedDescription]);
    }];
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
