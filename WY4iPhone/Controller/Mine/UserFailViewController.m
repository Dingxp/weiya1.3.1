//
//  UserFailViewController.m
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/12/28.
//  Copyright © 2015年 mx. All rights reserved.
//

#import "UserFailViewController.h"
#import "ApplyMoneyViewController.h"
@interface UserFailViewController ()

@end

@implementation UserFailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(245, 50, 109);;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationItem.title = @"失败";
    self.view.backgroundColor=[UIColor whiteColor];
    [self initView];
}
-(void)initView
{
    UILabel* tipsEmpty = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height/2)];
    tipsEmpty.textAlignment = NSTextAlignmentCenter;
    //tipsEmpty.text = @"开店失败";
    tipsEmpty.numberOfLines=2;
    tipsEmpty.textColor = RGBCOLOR(102, 102, 102);
    [self.view addSubview:tipsEmpty];
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(APP_SCREEN_WIDTH/4, APP_SCREEN_HEIGHT/4, APP_SCREEN_WIDTH/2, APP_SCREEN_WIDTH/2)];
    imageView.image=[UIImage imageNamed:@"fail"];
    [self.view addSubview:imageView];
    UIButton*btn=[UIButton new];
    btn.frame=CGRectMake(20, APP_SCREEN_HEIGHT-64-60, APP_SCREEN_WIDTH/2-30, 44);
    btn.layer.borderColor = RGBCOLOR(245, 50, 109).CGColor;
    btn.layer.cornerRadius=5;
    btn.layer.borderWidth = 1;
    //返回
    [btn setTitle:@"再考虑考虑" forState:UIControlStateNormal];
    [btn setTitleColor:RGBCOLOR(245, 50, 109) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goEducation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    //去支付按钮
    UIButton* paybtn=[UIButton new];
    paybtn.frame=CGRectMake(btn.right+20, APP_SCREEN_HEIGHT-64-60, btn.width, 44);
    paybtn.layer.borderColor = [UIColor redColor].CGColor;
    paybtn.layer.borderWidth = 1;
    paybtn.layer.cornerRadius=5;
    
    [paybtn setTitle:@"重新支付" forState:UIControlStateNormal];
    [paybtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    paybtn.backgroundColor=RGBCOLOR(245, 50, 109);
    [paybtn addTarget:self action:@selector(gogogo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:paybtn];
    
}
//从新支付
-(void)gogogo
{
    ApplyMoneyViewController*appMoney1=[ApplyMoneyViewController new];
    [self.navigationController pushViewController:appMoney1 animated:YES];
}
//查看教程
-(void)goEducation
{
    [self.tabBarController setSelectedIndex:0];
    [self.navigationController popToRootViewControllerAnimated:YES];
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
