//
//  ZMCommissionDetailViewController.m
//  WY4iPhone
//
//  Created by ZM21 on 15/9/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMCommissionDetailViewController.h"
#import "ZMCommissionDetailTableViewCell.h"
#import "BaseRequest.h"
#import "ZMUser.h"

@interface ZMCommissionDetailViewController (){
    NSArray *datas;
    ZMUser*user;
}

@end

@implementation ZMCommissionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"佣金详情";
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    user=[ZMUser userWithDict:userDic];
    [self initView];
    [self loadData];
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
}
- (void) loadData{
    
    [self requestCommissionDetailByRegUserId:user.userId];
}

- (void) initView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - self.navigationController.navigationBar.bottom) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark UITableView_delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return datas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 71;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identified = @"commissionDetailCell";
    
    NSDictionary *result = datas[indexPath.row];
    
    ZMCommissionDetailTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:identified];
    if (!cell) {
        cell = [[ZMCommissionDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identified];
    }
    [cell.imgHead sd_setImageWithURL:[NSURL URLWithString:user.headPic] placeholderImage:[UIImage imageNamed:@"default_icon"]];
    cell.labelUserName.text = result[@"customerTel"];
    NSString *moneyStr = [NSString stringWithFormat:@"￥%.2f", [result[@"wsCommission"] doubleValue]];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:moneyStr];
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:RGBCOLOR(254, 104, 136)
                       range:NSMakeRange(0, moneyStr.length)];
    cell.labelMoney.attributedText = attrString;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  佣金详情
 *
 *  @param regUserId 会员ID
 */
- (void) requestCommissionDetailByRegUserId:(NSString *)regUserId{
    NSString *url = @"webusi/commission/commission/findCommissionDetial.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:regUserId forKey:@"regUserId"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            if ( [responseObject[@"result"] isKindOfClass:[NSDictionary class]])

            {
                NSDictionary*resDic=responseObject[@"result"];
                NSArray*arr=[resDic allKeys];
                if ([arr containsObject:@"result"])
                {if (responseObject[@"result"][@"result"]==nil)
                {
                    return ;
                }
                    datas = responseObject[@"result"][@"result"];
                    [_tableView reloadData];
                    
                    
                }
            }
            

            
        }
//        NSLog(@"commission detail:%@", responseObject[@"result"]);
    } failure:^(NSError *error) {
//        NSLog(@"error:%@", [error localizedDescription]);
    }];
}

@end
