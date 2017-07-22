//
//  ZMShortConfirmViewController.m
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/11/17.
//  Copyright © 2015年 mx. All rights reserved.
//

#import "ZMShortConfirmViewController.h"
#import "WYAOrderInfoListCell.h"
#import "ZMShoppingCartPro.h"
#import "UIImageView+WebCache.h"
@interface ZMShortConfirmViewController ()
{
    //物流费用
    UILabel*exchargeLab;
    //现金券张数
    UILabel*couponCountLab;
    // 总共
    UILabel*totalLab;
    //支付宝按钮
    UIButton*paySelectBtn;
    //微信按钮
    UIButton*weiSelect;
    //  滑动视图
    UIScrollView*scrollView;
}
@end

@implementation ZMShortConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT)];
    scrollView.contentSize =CGSizeMake(0, 1000);
    scrollView.contentSize =CGSizeMake(0, 136*self.buyProList.count+400);
    [self.view addSubview:scrollView];
    // Do any additional setup after loading the view.
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [_tableView registerClass:[WYAOrderInfoListCell class] forCellReuseIdentifier:@"cell"];
    [scrollView addSubview:_tableView];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 400)];
    view.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:view];
    scrollView.contentSize =CGSizeMake(0, 136*self.buyProList.count+view.bottom);
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.width, 1)];
    line.backgroundColor = RGBCOLOR(232, 232, 232);
    [view addSubview:line];
    // 物流费用
    UILabel *postageLab=[[UILabel alloc]initWithFrame:CGRectMake(10, line.bottom, 100, 44)];
    postageLab.text=@"物流费用";
    [view addSubview:postageLab];
    exchargeLab=[[UILabel alloc]initWithFrame:CGRectMake(APP_SCREEN_WIDTH-100, line.bottom, 100, 44)];
    [view addSubview:exchargeLab];
    UIView*lin1=[[UIView alloc]initWithFrame:CGRectMake(0, postageLab.bottom, APP_SCREEN_WIDTH, 1)];
    lin1.backgroundColor=RGBCOLOR(232, 232, 232);
    [view addSubview:lin1];
    //  现金券
    UILabel*coupon=[[UILabel alloc]initWithFrame:CGRectMake(10,lin1.bottom , 100, 44)];
    coupon.text=@"现金券";
    [view addSubview:coupon];
    couponCountLab=[[UILabel alloc]initWithFrame:CGRectMake(APP_SCREEN_WIDTH-100, lin1.bottom, 100, 44)];
    [view addSubview:couponCountLab];
    UIView*lin2=[[UIView alloc]initWithFrame:CGRectMake(0, coupon.bottom, APP_SCREEN_WIDTH, 1)];
    lin2.backgroundColor=RGBCOLOR(232, 232, 232);
    [view addSubview:lin2];
    UILabel*calcilateLab=[[UILabel alloc]initWithFrame:CGRectMake(10, lin2.bottom, 100, 44)];
    calcilateLab.text=@"合计";
    [view addSubview:calcilateLab];
    totalLab=[[UILabel alloc]initWithFrame:CGRectMake(APP_SCREEN_WIDTH-100, lin2.bottom, 100, 44)];
    UIView*lin3=[[UIView alloc]initWithFrame:CGRectMake(0, calcilateLab.bottom, APP_SCREEN_WIDTH, 1)];
    lin3.backgroundColor=RGBCOLOR(232, 232, 232);
    [view addSubview:lin3];
    UILabel*payLab=[[UILabel alloc]initWithFrame:CGRectMake(0, lin3.bottom, APP_SCREEN_WIDTH, 44)];
    payLab.text=@"支付信息";
    payLab.backgroundColor=[UIColor grayColor];
    [view addSubview:payLab];
    UIView*lin4=[[UIView alloc]initWithFrame:CGRectMake(0, payLab.bottom, APP_SCREEN_WIDTH, 1)];
    lin4.backgroundColor=RGBCOLOR(232, 232, 232);
    [view addSubview:lin4];
    paySelectBtn =[UIButton new];
    [paySelectBtn setBackgroundImage:[UIImage imageNamed:@"emptyRing"] forState:UIControlStateNormal];
    [paySelectBtn setBackgroundImage: [UIImage imageNamed:@"hookRing"] forState:UIControlStateSelected];
    paySelectBtn.frame=CGRectMake(10, lin4.bottom+30, 20, 20);
    [paySelectBtn addTarget:self action:@selector(payBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:paySelectBtn];
    UIImageView*payImage=[[UIImageView alloc]initWithFrame:CGRectMake(paySelectBtn.right+30, lin4.bottom+10, 40, 40)];
    payImage.image=[UIImage imageNamed:@"zhifubao"];
    [view addSubview:payImage];
    UIView*lin5=[[UIView alloc]initWithFrame:CGRectMake(0, lin4.bottom+60, APP_SCREEN_WIDTH, 1)];
    lin5.backgroundColor=RGBCOLOR(232, 232, 232);
    [view addSubview:lin5];
    weiSelect=[UIButton new];
    [weiSelect setBackgroundImage:[UIImage imageNamed:@"emptyRing"] forState:UIControlStateNormal];
    [weiSelect setBackgroundImage: [UIImage imageNamed:@"hookRing"] forState:UIControlStateSelected];

    [weiSelect addTarget:self action:@selector(weiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    weiSelect.frame=CGRectMake(10, lin5.bottom+30, 20, 20);
    [view addSubview:weiSelect];
    UIImageView*weiImage=[[UIImageView alloc]initWithFrame:CGRectMake(weiSelect.right+30, lin5.bottom+10, 40, 40)];
    weiImage.image=[UIImage imageNamed:@"weixin"];
    [view addSubview:weiImage];
    UIView*lin6=[[UIView alloc]initWithFrame:CGRectMake(0, lin5.bottom+60, APP_SCREEN_WIDTH, 1)];
    lin6.backgroundColor=RGBCOLOR(232, 232, 232);
    [view addSubview:lin6];
    scrollView.contentSize =CGSizeMake(0, 136*self.buyProList.count+view.bottom);
    
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
-(void)payBtnClick
{
    if (paySelectBtn.selected==YES)
    {
        weiSelect.selected=YES;
        paySelectBtn.selected=NO;
    }
    else
    {
        weiSelect.selected=NO;
        paySelectBtn.selected=YES;
    }
}
-(void)weiBtnClick
{
    if (weiSelect.selected==YES)
        
    {
        paySelectBtn.selected=YES;
        weiSelect.selected=NO;
    }
    else
    {
        paySelectBtn.selected=NO;
        weiSelect.selected=YES;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _buyProList.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYAOrderInfoListCell*cell=[_tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
   ZMShoppingCartPro * pro = _buyProList [indexPath.row];
    [cell.goodsImageView sd_setImageWithURL:[NSURL URLWithString:pro.httpImgUrl]];
    cell.goodsTitle.text = pro.proName;
 cell.priceTitle.text = [NSString stringWithFormat:@"￥%@", pro.price];
    cell.numberTitle.text = [NSString stringWithFormat:@"x%@", pro.quantity];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 136;
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
