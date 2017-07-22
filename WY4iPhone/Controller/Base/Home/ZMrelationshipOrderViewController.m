//
//  ZMrelationshipOrderViewController.m
//  WY4iPhone
//
//  Created by ZM21 on 15/9/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMrelationshipOrderViewController.h"
#import "ZMRelationshipOrderTableViewCell.h"

@interface ZMrelationshipOrderViewController (){
    NSArray *datas;
    UIView *viewHead;
    ZMUser*user;
    NSDictionary *resultOrderDict;
}

@end

@implementation ZMrelationshipOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"人脉圈订单";
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationItem.leftBarButtonItem = barItem;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    user=[ZMUser userWithDict:userDic];
    [self initNoOrderView];
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
    datas = @[@{@"userName":@"lisi1",@"price":@"￥100.00",@"preComm":@"5.00"},
              @{@"userName":@"lisi2",@"price":@"￥500.00",@"preComm":@"10.00"},
              @{@"userName":@"lisi3",@"price":@"￥700.00",@"preComm":@"50.00"}];
    
    [self requestRelationshipOrderByRegUserId:user.userId startPage:@"0"];
    
    if (datas == nil || datas.count == 0) {
        UILabel *labelTips = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - self.navigationController.navigationBar.bottom)];
        labelTips.textAlignment = NSTextAlignmentCenter;
        labelTips.textColor = RGBCOLOR(179, 179, 179);
        labelTips.numberOfLines = 2;
        labelTips.text = @"暂时无相关订单\n快去介绍身边的朋友使用吧";
        [self.view addSubview:labelTips];
        [viewHead removeFromSuperview];
        [_tableView removeFromSuperview];
    }
}

- (void) initOrderView{
    viewHead = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 35)];
    viewHead.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewHead];
    
    CGFloat labelW = (viewHead.width - 20 ) / 3;
    CGFloat labelH = 15;
    UILabel *labelUserName = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, labelW, labelH)];
    labelUserName.font = [UIFont systemFontOfSize:15];
    labelUserName.textColor = RGBCOLOR(205, 205, 205);
    labelUserName.text = @"用户名";
    [viewHead addSubview:labelUserName];
    
    UILabel *labelPrice = [[UILabel alloc] initWithFrame:CGRectMake(labelUserName.right, labelUserName.top, labelUserName.width, labelUserName.height)];
    labelPrice.font = [UIFont systemFontOfSize:15];
    labelPrice.textColor = RGBCOLOR(205, 205, 205);
    labelPrice.textAlignment = NSTextAlignmentCenter;
    labelPrice.text = @"订单价格";
    [viewHead addSubview:labelPrice];
    
    UILabel *labelPreComm = [[UILabel alloc] initWithFrame:CGRectMake(labelPrice.right, labelUserName.top, labelW, labelH)];
    labelPreComm.font = [UIFont systemFontOfSize:15];
    labelPreComm.textColor = RGBCOLOR(205, 205, 205);
    labelPreComm.textAlignment = NSTextAlignmentRight;
    labelPreComm.text = @"预计佣金";
    [viewHead addSubview:labelPreComm];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, viewHead.bottom + 5, self.view.width, self.view.height - viewHead.bottom) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (void) initNoOrderView{
    UIImageView *imgNoOrder = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.width - 20) / 2, (self.view.height - self.navigationController.navigationBar.bottom - 19) / 2, 20, 19)];
    imgNoOrder.image = [UIImage imageNamed:@"homepage_25"];
    [self.view addSubview:imgNoOrder];
    
    UILabel *labelNoOrder = [[UILabel alloc] initWithFrame:CGRectMake(0, imgNoOrder.bottom + 15, self.view.width, 18)];
    labelNoOrder.textAlignment = NSTextAlignmentCenter;
    labelNoOrder.textColor = [UIColor lightGrayColor];
    labelNoOrder.text = @"当前没有订单";
    labelNoOrder.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:labelNoOrder];
}

/**
 *  移除当前父View上的所有子View
 */
- (void) removeAllViewFromParent{
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
}

#pragma mark UITableView_delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = datas[indexPath.row];
    static NSString *identified = @"relationshipOrderCell";
    ZMRelationshipOrderTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:identified];
    if (!cell) {
        cell = [[ZMRelationshipOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identified];
    }
    cell.labelUserName.text = dic[@"userName"];
    cell.labelOrderPrice.text = dic[@"price"];
    cell.labelPreCommission.text = dic[@"preComm"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 46;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) requestRelationshipOrderByRegUserId:(NSString *)regUserId startPage:(NSString *)startPage{
    NSString *url = @"wbusi/wbusiinfo/wbusiinfo/findRelationalOrder.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:regUserId forKey:@"regUserId"];
    [params setValue:startPage forKey:@"startPage"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
//        NSLog(@"%@", responseObject);
        resultOrderDict = resultOrderDict[@"result"];
    } failure:^(NSError *error) {
//        NSLog(@"error: %@", [error localizedDescription]);
    }];
}

@end
