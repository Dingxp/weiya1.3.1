//
//  ApplyShopViewController.m
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/12/28.
//  Copyright © 2015年 mx. All rights reserved.
//

#import "ApplyShopViewController.h"
#import "UserListViewController.h"
#import "ApplyMoneyViewController.h"
@interface ApplyShopViewController ()
{
    UIButton*applyBtn;
}
@end

@implementation ApplyShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(245, 50, 109);;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationItem.title = @"申请开店";
    [self initView];
}
-(void)initView
{
    self.view.backgroundColor=RGBCOLOR(248, 106, 98);
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 44)];
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
    UILabel*lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, APP_SCREEN_WIDTH, 44)];
    lab.text=@"芽客佣金排行榜";
    lab.textColor=[UIColor blackColor];
    [view addSubview:lab];
    UIImageView *imgViewRight1 = [[UIImageView alloc] initWithFrame:CGRectMake( self.view.width - 28, (view.height - 13) / 2, 9, 13)];
    imgViewRight1.image = [UIImage imageNamed:@"mine_rightGray"];
    [view addSubview:imgViewRight1];
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClicked)];
    view.userInteractionEnabled=YES;
    [view addGestureRecognizer:tap4];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, view.bottom, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT-64-55-44)];
    scrollView.tag = 10;
    //    设置容量
    scrollView.contentSize = CGSizeMake(APP_SCREEN_WIDTH, 4124*APP_SCREEN_WIDTH/1080);
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 4124*APP_SCREEN_WIDTH/1080)];
    imageView.image=[UIImage imageNamed:@"advantage.jpg"];
    [scrollView addSubview:imageView];
    //    设置是否分页
    scrollView.pagingEnabled = YES;
    
    //    设置是否显示水平或者竖直的标示符
    //    Horizontal  水平的 地平线
    //   Indicator指示符 标示符
    scrollView.showsHorizontalScrollIndicator = NO;
    //    Vertical 垂直的
    scrollView.showsVerticalScrollIndicator = YES;
    
    //    设置是否回弹
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    applyBtn=[UIButton new];
    applyBtn.frame=CGRectMake(20,APP_SCREEN_HEIGHT-64-55, APP_SCREEN_WIDTH-40, 50);    
    [applyBtn setTitle:@"立即开店" forState:UIControlStateNormal];
    [applyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [applyBtn setTitleColor:RGBCOLOR(216, 216, 216) forState:UIControlStateNormal];
    applyBtn.backgroundColor=RGBCOLOR(245, 50, 109);
    applyBtn.layer.borderColor = [UIColor redColor].CGColor;
    applyBtn.layer.borderWidth = 1;
    applyBtn.layer.cornerRadius=5;
    [applyBtn addTarget:self action:@selector(togoApplyShop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:applyBtn];

}
//芽客佣金排行榜
-(void)itemClicked
{
    UserListViewController*userList=[UserListViewController new];
    [self.navigationController pushViewController:userList animated:YES];
}
-(void)togoApplyShop
{
    ApplyMoneyViewController*moneyMoey=[ApplyMoneyViewController new];
    [self.navigationController pushViewController:moneyMoey animated:YES];
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
