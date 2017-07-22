//
//  ZMEducationViewController.m
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/12/18.
//  Copyright © 2015年 mx. All rights reserved.
//

#import "ZMEducationViewController.h"
#import "BaseRequest.h"
#import "ZMUser.h"
#import "EducationTableViewCell.h"
#import "ZMEducation.h"
#import "UIImageView+WebCache.h"
#import "EducationWebViewController.h"
#import "MJRefresh.h"
@interface ZMEducationViewController ()
{
    ZMUser*user;
    NSDictionary*arraySpecialProList;
    UILabel*tipsEmpty;
    
}
@end

@implementation ZMEducationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(245, 50, 109);;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    user=[ZMUser userWithDict:userDic];
    self.view.backgroundColor=[UIColor whiteColor];
    [self requestEducationByRegUserId:user.userId];
    self.navigationItem.title = @"微芽学院";
    [self initView];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];

}
-(void)initView
{   // 创建表
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    //  代理与数据源
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    tipsEmpty = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height /2)];
    tipsEmpty.textAlignment = NSTextAlignmentCenter;
    tipsEmpty.text = @"还没有分享教程，稍后再说呗!";
    tipsEmpty.hidden=YES;
    tipsEmpty.textColor = RGBCOLOR(102, 102, 102);
    [self.view addSubview:tipsEmpty];

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _educationArr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 265;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EducationTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    cell.backgroundColor=[UIColor whiteColor];
    if (!cell)
    {
        cell = [[EducationTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    ZMEducation*education=_educationArr[indexPath.row];
    cell.titleLab.text=education.title;
    [cell.titleImage sd_setImageWithURL:[NSURL URLWithString:education.httpImgUrl]];
    cell.describeLab.text=education.summary;
    cell.dateLab.text=education.createTime;
    cell.readLab.text=education.readQuan;
    
        return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZMEducation*education=_educationArr[indexPath.row];
    EducationWebViewController*vc=[EducationWebViewController new];
    vc.education=education;
    [self.navigationController pushViewController:vc animated:YES];
   
    
}
-(void)moreProduct
{
    if ([arraySpecialProList[@"hasNext"] integerValue] >= 1) {// 有下一页
        [self requestMoreEducationByRegUserId:user.userId startPage:arraySpecialProList[@"nextPage"]];
        
    } else {
        [_tableView.footer endRefreshing];
        _tableView.footer.hidden = YES;
    }
    
}
- (void) requestEducationByRegUserId:(NSString *)regUserId{
    [SVProgressHUD showWithStatus:@"加载中"];
    NSString *url = @"app/crm/wbusicourse/findWbusiCourseList.do";
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:regUserId forKey:@"regUserId"];
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        // NSLog(@"微芽教程: %@", responseObject);
        [SVProgressHUD dismiss];
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"])
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
                        ZMEducation *education = [ZMEducation EducationWithDictionary:dict];
                        [tmpArray addObject:education];
                    }
                    if (tmpArray.count==0)
                    {
                        tipsEmpty.hidden=NO;
                    }
                    else
                    {
                      tipsEmpty.hidden=YES;
                    }
                    if ([responseObject[@"result"][@"hasNext"] integerValue] >0)
                    {
                       _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreProduct)];
                    }
                    _educationArr=tmpArray;
                    [_tableView reloadData];
                    
                }
                
                
            }
 
            
        } else
        {
           
        }
    } failure:^(NSError *error) {
        //        NSLog(@"error: %@", [error localizedDescription]);
    }];
}
//查询更多教程
- (void) requestMoreEducationByRegUserId:(NSString *)userId  startPage:(NSString*)startPage{
    if (userId==nil)
    {
        return;
    }
    NSString *url = @"app/crm/coupon/findCouponItemList.do";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:userId forKey:@"regUserId"];
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
                            ZMEducation *education = [ZMEducation EducationWithDictionary:dict];
                            [tmpArray addObject:education];
                        }

                        [_educationArr addObjectsFromArray:tmpArray];
                        [_tableView reloadData];
                        
                    }
                    
                }
                
            }
            
        }
    } failure:^(NSError *error) {
        
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
