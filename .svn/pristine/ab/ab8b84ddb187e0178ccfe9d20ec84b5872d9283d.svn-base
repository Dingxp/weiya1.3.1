//
//  UserListViewController.m
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/12/28.
//  Copyright © 2015年 mx. All rights reserved.
//

#import "UserListViewController.h"
#import "MJRefresh.h"
#import "UserListTableViewCell.h"
#import "BaseRequest.h"
#import "UserList.h"
@interface UserListViewController ()
{
    NSMutableArray*listArray;
}
@end

@implementation UserListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"芽客佣金排行榜";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(245, 50, 109);;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self userlist];
    [self initWith];
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
    [SVProgressHUD dismiss];
}
-(void)initWith
{   // 创建表
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-self.navigationController.navigationBar.bottom) style:UITableViewStyleGrouped];
    //  代理与数据源
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = RGBCOLOR(240, 240, 240);

     //  获得收藏列表的数据
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
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
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*reuseIdentity=@"cell";
    UserListTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:reuseIdentity];
    
    cell.backgroundColor=[UIColor whiteColor];
    if (!cell)
    {
        cell = [[UserListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentity];
    }
    UserList*userList=listArray[indexPath.row];
    if (indexPath.row<3)
    {
        cell.listImage.hidden=NO;
        cell.listImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"grade%ld",indexPath.row+1]];
        cell.listLab.hidden=YES;
        
    }
    else
    {
        cell.listLab.hidden=NO;
        cell.listLab.text=userList.ranking;
        cell.listImage.hidden=YES;
    }
    cell.userLab.text=userList.nickName;
    cell.moneyab.attributedText = [self parserString:@"" withContentStr:[NSString stringWithFormat:@"%@", userList.totalComm] endString:@"元"];
    return cell;
  
}
-(void)moreProduct
{
    if ([_arraySpceialProDict[@"hasNext"] integerValue] >0) {// 有下一页
        [self userMorelist];
        
    } else {
        [_tableView.footer endRefreshing];
        _tableView.footer.hidden = YES;
    }
  
}
-(void)userlist
{    NSString *url = @"wbusi/wbusiinfo/wbusiinfo/findRankingList.do";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [SVProgressHUD showWithStatus:@"加载中"];
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        [SVProgressHUD dismiss];
         //NSLog(@"---%@",responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            if ( [responseObject[@"result"] isKindOfClass:[NSDictionary class]])
            {
                NSDictionary*resDic=responseObject[@"result"];
                NSArray*arr=[resDic allKeys];
                if ([arr containsObject:@"result"])
                {
                    _arraySpceialProDict=responseObject[@"result"];
                    if (responseObject[@"result"][@"result"]==nil)
                    {
                        return ;
                    }
                    
                    if ([_arraySpceialProDict[@"hasNext"] integerValue] ==1) {// 有下一页
                        
                        _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreProduct)];
                    }
                    NSArray *array = responseObject[@"result"][@"result"];
                    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
                    for (NSDictionary *dict in array) {
                        UserList*userList=[UserList userWithDictionary:dict];
                        [tmpArray addObject:userList];
                    }
                    listArray=tmpArray;
                    [_tableView reloadData];
                    if (listArray.count==0)
                    {
                        
                    UILabel*tipsEmpty = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - self.navigationController.navigationBar.bottom - self.tabBarController.tabBar.height)];
                        tipsEmpty.textAlignment = NSTextAlignmentCenter;
                        tipsEmpty.text = @"没有收藏的商品，赶紧去收藏!";
                        tipsEmpty.textColor = RGBCOLOR(102, 102, 102);
                        [self.view addSubview:tipsEmpty];
                    }

                    
                }
                
            }
            
            
        }
    } failure:^(NSError *error) {
        //        NSLog(@"requestNumOfCouponByUserId error: %@", [error localizedDescription]);
    }];
}
-(void)userMorelist
{    NSString *url = @"wbusi/wbusiinfo/wbusiinfo/findRankingList.do";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:_arraySpceialProDict[@"nextPage"] forKey:@"startPage"];
    [SVProgressHUD showWithStatus:@"加载中"];

    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        [SVProgressHUD dismiss];
        [self.tableView.footer endRefreshing];
       // NSLog(@"---%@",responseObject);
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
                     _arraySpceialProDict=responseObject[@"result"];
                    NSArray *array = responseObject[@"result"][@"result"];
                    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
                    for (NSDictionary *dict in array) {
                        UserList*userList=[UserList userWithDictionary:dict];
                        [tmpArray addObject:userList];
                    }
                    [listArray addObjectsFromArray:tmpArray];
                    [_tableView reloadData];
                    
                    
                }
                
            }
            
            
        }
        else
        {
            [_tableView.footer endRefreshing];
            _tableView.footer.hidden = YES;
        }
    } failure:^(NSError *error) {
        //        NSLog(@"requestNumOfCouponByUserId error: %@", [error localizedDescription]);
        [_tableView.footer endRefreshing];
        _tableView.footer.hidden = YES;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSMutableAttributedString *) parserString:(NSString *)preStr withContentStr:(NSString *)str endString:(NSString *)endStr{
    NSString *postStr = [NSString stringWithFormat:@"%@%@%@", preStr, str, endStr];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:postStr];
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:RGBCOLOR(253, 0, 76)
                       range:NSMakeRange(preStr.length, str.length)];
    return attrString;
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
