//
//  ZMEntrepreneurshipViewController.m
//  WY4iPhone
//
//  Created by ZM21 on 15/9/11.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMEntrepreneurshipViewController.h"
#import "ZMCommissionViewController.h"
#import "ZMRankingViewController.h"
#import "ZMPersonRelationshipTableViewController.h"
#import "ZMrelationshipOrderViewController.h"
#import "BaseRequest.h"
#import "ZMUser.h"

@interface ZMEntrepreneurshipViewController (){
    ZMUser*user;
}

@end

@implementation ZMEntrepreneurshipViewController

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
- (void) initView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 140)];
    view.backgroundColor =  RGBCOLOR(244, 78, 128);
    [self.view addSubview:view];
    
    CGFloat labComX = 10;
    CGFloat labComY = 30;
    CGFloat labComW = APP_SCREEN_WIDTH - labComX * 2;
    CGFloat labComH = 24;
    
    _labelSurplusCommission = [[UILabel alloc] initWithFrame:CGRectMake(labComX, labComY, labComW, labComH)];
    _labelSurplusCommission.textColor = [UIColor whiteColor];
    _labelSurplusCommission.font = [UIFont systemFontOfSize:24];
    _labelSurplusCommission.text = @"￥0.00";
    [view addSubview:_labelSurplusCommission];
    
    UILabel *labelCom = [[UILabel alloc] initWithFrame:CGRectMake(_labelSurplusCommission.left + 5, _labelSurplusCommission.bottom + 9, _labelSurplusCommission.width, 11)];
    labelCom.textColor = [UIColor whiteColor];
    labelCom.font = [UIFont systemFontOfSize: 11];
    labelCom.text = @"剩余佣金（元）";
    [view addSubview:labelCom];
    
    _labelTodayIncome = [[UILabel alloc] initWithFrame:CGRectMake(labelCom.left, labelCom.bottom + 22, (view.width - 20) / 2, 15)];
    _labelTodayIncome.textColor = [UIColor whiteColor];
    _labelTodayIncome.font = [UIFont systemFontOfSize: 15];
    _labelTodayIncome.text = [NSString stringWithFormat:@"%@%@", @"今日收入:", @"0"];
    [view addSubview:_labelTodayIncome];
    
    _labelTodayNewNum = [[UILabel alloc] initWithFrame:CGRectMake(view.width / 2, _labelTodayIncome.top, (view.width - 20) / 2, 15)];
    _labelTodayNewNum.textColor = [UIColor whiteColor];
    _labelTodayNewNum.font = [UIFont systemFontOfSize: 15];
    _labelTodayNewNum.textAlignment = NSTextAlignmentRight;
    _labelTodayNewNum.text = [NSString stringWithFormat:@"%@%@", @"今日新增人数：", @"0"];
    [view addSubview:_labelTodayNewNum];
    
    // 绘制表格
    UIView *viewTable = [[UIView alloc] initWithFrame:CGRectMake(0, view.bottom + 10, APP_SCREEN_WIDTH, 250)];
    viewTable.backgroundColor = [UIColor whiteColor];
    CGFloat lineH = 1;
    CALayer *lineLayerHor = [CALayer layer];
    lineLayerHor.backgroundColor = RGBCOLOR(230, 230, 230).CGColor;
    lineLayerHor.frame = CGRectMake(0, (viewTable.height - lineH) / 2, viewTable.width, lineH);
    [viewTable.layer addSublayer:lineLayerHor];
    
    for (int i = 1 ; i < 3; i++) {
        CALayer *lineVer = [CALayer layer];
        lineVer.backgroundColor = RGBCOLOR(230, 230, 230).CGColor;
        lineVer.frame = CGRectMake( i * viewTable.width / 3, 0, lineH, viewTable.height);
        [viewTable.layer addSublayer:lineVer];
    }
    [self.view addSubview:viewTable];
    
    NSArray *datas = @[@{@"desc":@"佣金",@"img":@"entrp_23"},
                      @{@"desc":@"关系用户",@"img":@"entrp_26"},
                      @{@"desc":@"排行榜",@"img":@"entrp_29"},
                      @{@"desc":@"关系订单",@"img":@"entrp_34"},
                      @{@"desc":@"关于全民创业",@"img":@"entrp_35"}
                      ];
    [self drawImgInTable:viewTable images:datas];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) drawImgInTable:(UIView *)view images:(NSArray *)data{
    int colNum = 3;
    CGFloat imgBtnViewW = view.height / (data.count / colNum + 1) ;
    CGFloat imgBtnViewH = view.width / 3;
    CGFloat baseX = view.width / 3;
    CGFloat baseY = view.height / 2;
    
    CGFloat imgH = 57;
    CGFloat imgW = 58;
    CGFloat imgY = 24;
    
    UIView *imgBtnView;
    
    for (int i = 0; i < data.count; i++) {
        NSDictionary *dic = data[i];
        imgBtnView =  [[UIView alloc]initWithFrame:CGRectMake(baseX * (i % colNum), baseY * (i / colNum), imgBtnViewW, imgBtnViewH)];
        CGFloat imgX = (imgBtnView.width - imgW) / 2;
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake( imgX, imgY, imgW, imgH)];
        imgView.image = [UIImage imageNamed:dic[@"img"]];
        [imgBtnView addSubview:imgView];
        
        UILabel *labelDesc = [[UILabel alloc] initWithFrame:CGRectMake(0, imgView.bottom + 13, imgBtnView.width, 13)];
        labelDesc.textAlignment = NSTextAlignmentCenter;
        labelDesc.textColor = RGBCOLOR(92, 92, 92);
        labelDesc.font = [UIFont systemFontOfSize:13];
        labelDesc.text = dic[@"desc"];
        [imgBtnView addSubview:labelDesc];
        [view addSubview:imgBtnView];
        
        UITapGestureRecognizer *signalTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgBtnViewClicked:)];
        imgBtnView.userInteractionEnabled = YES;
        imgBtnView.tag = 20001 + i;
        [imgBtnView addGestureRecognizer:signalTap];
    }
}

- (void) imgBtnViewClicked:(UITapGestureRecognizer *) tap{
    UIViewController *vc;
    switch (tap.view.tag) {
        case 20001:// 佣金
            vc = [[ZMCommissionViewController alloc] init];
            break;
        case 20002:// 关系用户
            vc = [[ZMPersonRelationshipTableViewController alloc] init];
            break;
        case 20003:// 排行榜
            vc = [[ZMRankingViewController alloc] init];
            break;
        case 20004:// 关系订单
            vc = [[ZMrelationshipOrderViewController alloc] init];
            break;
        case 20005:// 关于全民创业
            
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) loadData{
    [self requestWbusiInfoByRegUserId:user.userId];
}

/**
 *  刷新界面
 */
- (void) refershViewWithDictionary:(NSDictionary *)dict{
    _labelSurplusCommission.text = [NSString stringWithFormat:@"￥%@", dict[@"overPlusComm"]];
    _labelTodayIncome.text = [NSString stringWithFormat:@"%@%@", @"今日收入:", dict[@"todayComm"]];
    _labelTodayNewNum.text = [NSString stringWithFormat:@"%@%@", @"今日新增人数：", dict[@"todayNumOfWbusi"]];
}

/**
 *  全民创业首页数据获取
 *
 *  @param regUserId
 */
- (void) requestWbusiInfoByRegUserId:(NSString *)regUserId{
    NSString *url = @"wbusi/wbusiinfo/wbusiinfo/findWbusiInfo.do";
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (regUserId==nil)
    {
        return;
    }
    [params setValue:regUserId forKey:@"regUserId"];
    
    [[BaseRequest sharedInstance ] request:url parameters:params success:^(id responseObject) {
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            NSDictionary *result = responseObject[@"result"];
            [self refershViewWithDictionary:result];
        } else {
            [SVProgressHUD showInfoWithStatus:responseObject[@"result"]];
        }
    } failure:^(NSError *error) {
//        NSLog(@"error:%@", [error localizedDescription]);
    }];
}

@end
