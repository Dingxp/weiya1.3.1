//
//  ZMCouponListViewController.m
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/12/15.
//  Copyright © 2015年 mx. All rights reserved.
//

#import "ZMCouponListViewController.h"
#import "BaseRequest.h"
#import "ZMUser.h"
#import "MJRefresh.h"
#import "CouponListTableViewCell.h"
#import "ZMCouponList.h"
@interface ZMCouponListViewController ()
{
     NSDictionary*arraySpecialProList;
    ZMUser*user;
}
@end

@implementation ZMCouponListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.navigationController.navigationBar.hidden=YES;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(245, 50, 109);;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    user=[ZMUser userWithDict:userDic];
    self.navigationItem.title = @"优惠劵列表";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 75, 30);
    button.titleLabel.font=[UIFont systemFontOfSize:12];
    
    [button setTitle:@"不使用优惠劵" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(noUsefulCounpon) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = leftItem;
    self.view.backgroundColor=[UIColor whiteColor];
     [self requestNumOfCouponByUserId:user.userId proAmount:self.proAmount];
    [self initView];
}
-(void)initView
{   // 创建表
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.width, self.view.height-self.navigationController.navigationBar.bottom) style:UITableViewStyleGrouped];
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
        [self requestMoreNumOfCouponByUserId:user.userId proAmount:self.proAmount startPage:arraySpecialProList[@"nextPage"]];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZMCouponList*CouponList=_couponArray[indexPath.row];
    self.orderVC.cashId=CouponList.couponId;
    self.orderVC.ShopcouponAmount=CouponList.couponAmount;
    [self.navigationController popViewControllerAnimated:YES];
}
//获取优惠劵列表
- (void) requestNumOfCouponByUserId:(NSString *)userId proAmount:(NSString*)proAmount{
    if (userId==nil)
    {
        return;
    }
    [SVProgressHUD showWithStatus:@"加载中"];
   
    //NSString *url = @"app/crm/coupon/findCouponItemList.do";
     //NSString*url1=@"app/crm/coupon/v1.2.0/findUsefulCouponItemList.do";
    NSString*url1=[NSString stringWithFormat:@"app/crm/coupon/%@/findUsefulCouponItemList.do",ppVersion];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:userId forKey:@"regUserId"];
    [params setValue:proAmount forKey:@"amount"];
    [params setObject:self.shopCatArr forKey:@"items"];
    if (self.addressID)
    {
        [params setValue:_addressID forKey:@"addrId"];
    }
     [[BaseRequest sharedInstance] orderRequest:url1 parameters:params success:^(id responseObject) {
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            [SVProgressHUD dismiss];
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
                    arraySpecialProList = responseObject[@"result"];
                    NSArray *array = responseObject[@"result"][@"result"];
                    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
                    for (NSDictionary *dict in array) {
                        ZMCouponList*channelItem=[ZMCouponList orderDetailsWithDictionary:dict];
                        [tmpArray addObject:channelItem];
                    }
                    if ([responseObject[@"result"][@"hasNext"] integerValue] >0)
                    {
                        _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreProduct)];
                    }
                    _couponArray=tmpArray;
                    [_tableView reloadData];
                    
                }
  
            }
                         }
    } failure:^(NSError *error) {
        
    }];

}
//获取更多优惠劵列表
- (void) requestMoreNumOfCouponByUserId:(NSString *)userId proAmount:(NSString*)proAmount startPage:(NSString*)startPage{
    if (userId==nil)
    {
        return;
    }
    NSString *url = @"app/crm/coupon/findCouponItemList.do";
    // NSString*url1=@"app/crm/coupon/findUsefulCouponItemList.do";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:userId forKey:@"regUserId"];
    [params setValue:proAmount forKey:@"amount"];
    [params setValue:startPage forKey:@"startPage"];

[[BaseRequest sharedInstance] orderRequest:url parameters:params success:^(id responseObject) {
        if ([responseObject[@"statu"] isEqualToString:@"true"] && responseObject[@"result"]) {
            {
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
                        arraySpecialProList = responseObject[@"result"];
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
                
            }
    } failure:^(NSError *error) {
        
    }];
}
-(void)noUsefulCounpon
{
    self.orderVC.cashId=@"0";
   self.orderVC.ShopcouponAmount=@"0";
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];

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
