//
//  ZMEntrepreneurshipViewController2.m
//  WY4iPhone
//
//  Created by ZM21 on 15/10/6.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMEntrepreneurshipViewController2.h"
#import "ZMContactListViewController.h"
#import "ZMEducationViewController.h"
#import "FriendsViewController.h"
#import "UserListViewController.h"
#import "LoginViewController.h"
@interface ZMEntrepreneurshipViewController2 ()
{
    UIImageView*redImage;
    ZMUser*user;
}
@end

@implementation ZMEntrepreneurshipViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(245, 50, 109);
    self.title = @"全民创业";
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    user=[ZMUser userWithDict:userDic];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    // 透明状态栏的延伸
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"mainbackimg32"]
                                                 forBarPosition:UIBarPositionAny
                                                     barMetrics:UIBarMetricsDefault];
    // 添加上这一句，可以去掉导航条下边的shadowImage，就可以正常显示了
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    [self initView];
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
- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadData];
}

- (void) initView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 140)];
    view.backgroundColor =  RGBCOLOR(245, 50, 109);
    [self.view addSubview:view];
    
    CGFloat labComX = 20;
    CGFloat labComY = 30;
    CGFloat labComW = APP_SCREEN_WIDTH - labComX * 2;
    CGFloat labComH = 24;
    //我的余额
    UILabel *labelCom = [[UILabel alloc] initWithFrame:CGRectMake(labComX, labComY, labComW, 14)];
    labelCom.textColor = [UIColor whiteColor];
    labelCom.font = [UIFont systemFontOfSize: 14];
    labelCom.text = @"我的余额（元）";
    [view addSubview:labelCom];
    
    _labelSurplusCommission = [[UILabel alloc] initWithFrame:CGRectMake(labelCom.left, labelCom.bottom + 10, labComW, labComH)];
    _labelSurplusCommission.textColor = [UIColor whiteColor];
    _labelSurplusCommission.font = [UIFont systemFontOfSize:24];
    _labelSurplusCommission.text = @"￥0.00";
    [view addSubview:_labelSurplusCommission];
     //今日收入
    _labelTodayIncome = [[UILabel alloc] initWithFrame:CGRectMake(labelCom.left, labelCom.bottom + 55, (view.width - 20) / 2, 15)];
    _labelTodayIncome.textColor = [UIColor whiteColor];
    _labelTodayIncome.font = [UIFont systemFontOfSize: 15];
    _labelTodayIncome.text = [NSString stringWithFormat:@"%@%@", @"今日收入:", @"0"];
    [view addSubview:_labelTodayIncome];
    //今日新增人数
    _labelTodayNewNum = [[UILabel alloc] initWithFrame:CGRectMake(view.width / 2, _labelTodayIncome.top, (view.width - 20) / 2, 15)];
    _labelTodayNewNum.textColor = [UIColor whiteColor];
    _labelTodayNewNum.font = [UIFont systemFontOfSize: 15];
    _labelTodayNewNum.textAlignment = NSTextAlignmentRight;
    _labelTodayNewNum.text = [NSString stringWithFormat:@"%@%@", @"今日新增人数：", @"0"];
    [view addSubview:_labelTodayNewNum];

    
    // 绘制表格
    UIView *viewTable = [[UIView alloc] initWithFrame:CGRectMake(0, view.bottom + 10, APP_SCREEN_WIDTH, 220 )];
    viewTable.backgroundColor = [UIColor whiteColor];
    CGFloat lineH = 1;
    CALayer *lineLayerHor = [CALayer layer];
    lineLayerHor.backgroundColor = RGBCOLOR(230, 230, 230).CGColor;
    lineLayerHor.frame = CGRectMake(0, viewTable.height, viewTable.width, lineH);
    [viewTable.layer addSublayer:lineLayerHor];
    for (int i = 1 ; i < 3; i++) {
        CALayer *lineVer = [CALayer layer];
        lineVer.backgroundColor = RGBCOLOR(230, 230, 230).CGColor;
        lineVer.frame = CGRectMake( i * viewTable.width / 3, 0, lineH, viewTable.height);
        [viewTable.layer addSublayer:lineVer];
    }
    [self.view addSubview:viewTable];
    
    NSArray *datas = @[@{@"desc":@"佣金",@"img":@"a1"},
                       @{@"desc":@"人脉圈",@"img":@"a2"},
                       @{@"desc":@"人脉圈订单",@"img":@"a3"},
                       @{@"desc":@"邀请好友",@"img":@"a4"},
                       @{@"desc":@"微芽学院",@"img":@"a5"},
                       @{@"desc":@"微芽排行榜",@"img":@"a6"}
                       ];
    [self drawImgInTable:viewTable images:datas];
    
    UIView *viewAbountQMCY = [[UIView alloc] initWithFrame:CGRectMake(0, viewTable.bottom + 10, self.view.width, 45)];
    viewAbountQMCY.backgroundColor = [UIColor whiteColor];
    viewAbountQMCY.tag = 20007;
    viewAbountQMCY.userInteractionEnabled = YES;
    UITapGestureRecognizer *viewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgBtnViewClicked:)];
    [viewAbountQMCY addGestureRecognizer:viewTap];
    [self.view addSubview:viewAbountQMCY];
    
    CALayer *layer1 = [CALayer layer];
    layer1.frame = CGRectMake(0, 0, self.view.width, 1);
    layer1.backgroundColor = RGBCOLOR(230, 230, 230).CGColor;
    [viewAbountQMCY.layer addSublayer:layer1];
    
    CALayer *layer2 = [CALayer layer];
    layer2.frame = CGRectMake(0, viewAbountQMCY.height, self.view.width, 1);
    layer2.backgroundColor = RGBCOLOR(230, 230, 230).CGColor;
    [viewAbountQMCY.layer addSublayer:layer2];
    
    UIImageView *imgAbount = [[UIImageView alloc] initWithFrame:CGRectMake(10, (viewAbountQMCY.height - 24) / 2, 24, 24)];
    imgAbount.image = [UIImage imageNamed:@"iconfont_laba"];
    [viewAbountQMCY addSubview:imgAbount];
    
    UILabel *labelAbount = [[UILabel alloc] initWithFrame:CGRectMake(imgAbount.right + 5, (viewAbountQMCY.height - 15) / 2, viewAbountQMCY.width - imgAbount.width - 10 * 2 - 5, 15)];
    labelAbount.textColor = [UIColor blackColor];
    labelAbount.text = @"关于全民创业";
    labelAbount.font = [UIFont systemFontOfSize:15];
    [viewAbountQMCY addSubview:labelAbount];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) drawImgInTable:(UIView *)view images:(NSArray *)data{
    int colNum = 3;
    CGFloat imgBtnViewW = view.width / 3 ;
    CGFloat imgBtnViewH = view.height / 1;
    CGFloat baseX = view.width / 3;
    CGFloat baseY = view.height /2;
    
    CGFloat imgH = 57;
    CGFloat imgW = 58;
    CGFloat imgY = 15;
    
    UIView *imgBtnView;
    redImage=[[UIImageView alloc]initWithFrame:CGRectMake(baseX-20, 5, 10, 10)];
    
    redImage.layer.cornerRadius=5;
    redImage.layer.masksToBounds=NO;
    [view addSubview:redImage];
    for (int i = 0; i < data.count; i++) {
        NSDictionary *dic = data[i];
        imgBtnView =  [[UIView alloc]initWithFrame:CGRectMake(baseX * (i % colNum), baseY * (i / colNum), imgBtnViewW, imgBtnViewH)];
        
        CGFloat imgX = (imgBtnView.width - imgW) / 2;
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake( imgX, imgY, imgW, imgH)];
        imgView.image = [UIImage imageNamed:dic[@"img"]];
        [imgBtnView addSubview:imgView];
        
        UILabel *labelDesc = [[UILabel alloc] initWithFrame:CGRectMake(0, imgView.bottom + 13, imgBtnViewW, 13)];
        labelDesc.textAlignment = NSTextAlignmentCenter;
        labelDesc.textColor = [UIColor blackColor];
        labelDesc.font = [UIFont systemFontOfSize:13];
        labelDesc.text = dic[@"desc"];
        [imgBtnView addSubview:labelDesc];
        
        [view addSubview:imgBtnView];
        
        UITapGestureRecognizer *signalTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgBtnViewClicked:)];
        imgBtnView.userInteractionEnabled = YES;
        imgBtnView.tag = 20001 + i;
        [imgBtnView addGestureRecognizer:signalTap];
        [imgBtnView bringSubviewToFront:redImage];
    }
    //
    UIView*lineView=[[UIView alloc]initWithFrame:CGRectMake(0, view.height/2, view.width, 1)];
    lineView.backgroundColor=RGBCOLOR(230, 230, 230);
    [view addSubview:lineView];

}

- (void) imgBtnViewClicked:(UITapGestureRecognizer *) tap{
    UIViewController *vc;
    switch (tap.view.tag) {
        case 20001:// 佣金
            vc = [[ZMCommissionViewController2 alloc] init];
            
            break;
        case 20002:// 人脉圈
            vc = [[ZMPersonRelationshipTableViewController alloc] init];
            break;
        case 20003:// 人脉圈订单
            vc = [[ZMRelationshipOrderViewController2 alloc] init];
            break;
        case 20004:// 邀请好友
            vc = [[FriendsViewController alloc] init];
            break;
        case 20005:// 微芽学院
            vc = [[ZMEducationViewController alloc] init];
            break;
        case 20006:// 微芽排行榜
            vc = [[UserListViewController alloc] init];
            break;
        case 20007:// 关于全民创业
            vc = [[ZMAboutQMCYViewController alloc] init];
            break;
        default:
            break;
    }
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];  
}

- (void) loadData{
    //全民创业首页数据获取
    [self requestWbusiInfoByRegUserId:user.userId];
    // 查看支付宝是否绑定
    [self requestZFBAccountByRegUserId:user.userId];
    
}

/**
 *  通过网络请求，得到数据进行，刷新界面
 */
- (void) refershViewWithDictionary:(NSDictionary *) dict{
    _labelSurplusCommission.text = [NSString stringWithFormat:@"￥%.2f", [dict[@"overPlusComm"] doubleValue]];
    _labelTodayIncome.text = [NSString stringWithFormat:@"%@%@", @"今日收入:", dict[@"todayComm"]];
    _labelTodayNewNum.text = [NSString stringWithFormat:@"%@%@", @"今日新增人数：", dict[@"todayNumOfWbusi"]];
}
/**
 *  查看支付宝是否绑定
 *
 *
 */
- (void) requestZFBAccountByRegUserId:(NSString *)regUserId{
    NSString *url = @"wbusi/wbusiinfo/wbusiinfo/findZfbInfo.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (regUserId==nil)
    {
        return;
    }
    [params setValue:regUserId forKey:@"regUserId"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
       // NSLog(@"支付宝账户信息: %@", responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"])
        {
            redImage.hidden=NO;
            redImage.backgroundColor=[UIColor redColor];
            
        } else
        {
            redImage.hidden=YES;
        }
    } failure:^(NSError *error) {
        //        NSLog(@"error: %@", [error localizedDescription]);
    }];
}
/**
 *  全民创业首页数据获取
 *
 *  @param regUserId
 */
- (void) requestWbusiInfoByRegUserId:(NSString *)regUserId{
    NSString *url = @"wbusi/wbusiinfo/wbusiinfo/findWbusiInfo.do";
    if (regUserId==nil)
    {
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:regUserId forKey:@"regUserId"];
    
    [[BaseRequest sharedInstance ] request:url parameters:params success:^(id responseObject) {
        //NSLog(@"==%@",responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            NSDictionary *result = responseObject[@"result"];
            [self refershViewWithDictionary:result];
        }
//        NSLog(@"全民创业首页数据:%@", responseObject[@"result"]);
    } failure:^(NSError *error) {
//        NSLog(@"error:%@", [error localizedDescription]);
    }];
}

@end
