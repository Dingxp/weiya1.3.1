//
//  ZMRankingViewController.m
//  WY4iPhone
//
//  Created by ZM21 on 15/9/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMRankingViewController.h"
#import "ZMRankingTableViewCell.h"
#import "BaseRequest.h"
#import "ZMUser.h"

@interface ZMRankingViewController (){
    NSArray *datas;
    ZMUser*user;
}

@end

@implementation ZMRankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    self.title = @"排行榜";
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
    datas = @[@{@"id":@9,@"nickName":@"wangerxiao1",@"ranking":@1,@"totalComm":@806},
              @{@"id":@6,@"nickName":@"wangerxiao2",@"ranking":@2,@"totalComm":@724},
              @{@"id":@3,@"nickName":@"wangerxiao3",@"ranking":@3,@"totalComm":@724},
              @{@"id":@12,@"nickName":@"wangerxiao4",@"ranking":@4,@"totalComm":@600},
              @{@"id":@11,@"nickName":@"wangerxiao5",@"ranking":@5,@"totalComm":@500},
              @{@"id":@7,@"nickName":@"wangerxiao6",@"ranking":@6,@"totalComm":@100}];
    
    [self requestRankingList];
}

- (void) initView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

#pragma mark UITableView_delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = datas[indexPath.row];
    static NSString *identified = @"rankCell";
    ZMRankingTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:identified];
    if (!cell) {
        cell = [[ZMRankingTableViewCell  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identified];
    }
    cell.labelUserName.text = dic[@"nickName"];
    NSString *moneyStr = [NSString stringWithFormat:@"%@%@", dic[@"totalComm"], @"元"];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:moneyStr];
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:RGBCOLOR(254, 89, 127)
                       range:NSMakeRange(0, moneyStr.length - 1)];
    cell.labelIncome.attributedText = attrString;
    
    if ([dic[@"ranking"] integerValue] == 1) {
        cell.imgRank.image = [UIImage imageNamed:@"entrp_03"];
    } else if ([dic[@"ranking"] integerValue] == 2){
        cell.imgRank.image = [UIImage imageNamed:@"entrp_16"];
    } else if([dic[@"ranking"] integerValue] == 3) {
        cell.imgRank.image = [UIImage imageNamed:@"entrp_19"];
    } else {
        cell.labelRank.text = [NSString stringWithFormat:@"%ld", (long)[dic[@"ranking"] integerValue]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  排行榜
 *
 *  @param regUserId 会员ID
 */
- (void) requestRankingList{
    NSString *url = @"wbusi/wbusiinfo/wbusiinfo/findRankingList.do";
     [[BaseRequest sharedInstance] request:url parameters:nil success:^(id responseObject) {
//        NSLog(@"responseObject:%@", responseObject[@"result"]);
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            if ([responseObject[@"result"][@"result"] count] <= 0) {
                [SVProgressHUD showInfoWithStatus:@"排行榜信息为空"];
            } else {
                           }
        } else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"result"]];
        }
    } failure:^(NSError *error) {
//        NSLog(@"error:%@", [error localizedDescription]);
    }];
}

@end
