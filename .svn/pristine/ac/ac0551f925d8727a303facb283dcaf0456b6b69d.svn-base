//
//  DoPayProTypeViewController.m
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/12/9.
//  Copyright © 2015年 mx. All rights reserved.
//

#import "DoPayProTypeViewController.h"
#import "BaseRequest.h"
#import "ZMUser.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "ZMPayFailFromConfirmOrderViewController.h"
#import "ZMPaySuccessFromConfirmViewController.h"
#import "ZMOrderDetails.h"
#import "WYAHomeViewController.h"
@interface DoPayProTypeViewController ()
{
    BaseRequest *baseRequest;
    ZMUser*user;
    NSString*payType;
    NSString*orderId;
    ZMOrderDetails*orderDetails;
    UIButton*paybtn;
}
@end

@implementation DoPayProTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"支付方式";
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    baseRequest = [BaseRequest sharedInstance];
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    user=[ZMUser userWithDict:userDic];
    payType=@"1";
    UILabel*firstlab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, APP_SCREEN_WIDTH, 44)];
    firstlab.backgroundColor=RGBCOLOR(240, 240, 240);
    firstlab.text=@"订单详情";
    [self.view addSubview:firstlab];
    UIView*firstView=[[UIView alloc]initWithFrame:CGRectMake(0, firstlab.bottom, APP_SCREEN_WIDTH, 89)];
    firstView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:firstView];
    UILabel*dingDanLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 44)];
    dingDanLab.text=@"订单号";
    [firstView addSubview:dingDanLab];
    //订单号
    UILabel*orderLab=[[UILabel alloc]initWithFrame:CGRectMake(dingDanLab.right+20, 0, 150, 44)];
    orderLab.text=_orderNum;
    [firstView addSubview:orderLab];
    UIView*line5=[[UIView alloc]initWithFrame:CGRectMake(0, dingDanLab.bottom, APP_SCREEN_WIDTH, 1)];
    line5.backgroundColor=RGBCOLOR(232, 232, 232);
    [firstView addSubview:line5];
    UILabel*prototal=[[UILabel alloc]initWithFrame:CGRectMake(10, 45, 100, 44)];
   
    prototal.text=@"合计";
    [firstView addSubview:prototal];
    //合计
    UILabel*totalPrice=[[UILabel alloc]initWithFrame:CGRectMake(prototal.right+20, 45, 100, 44)];
    totalPrice.text=_proAmount;
    [firstView addSubview:totalPrice];
    UILabel*payTypeLab=[[UILabel alloc]initWithFrame:CGRectMake(10, firstView.bottom, APP_SCREEN_WIDTH, 44)];
    payTypeLab.backgroundColor=RGBCOLOR(240, 240, 240);
    payTypeLab.text=@"支付方式";
    [self.view addSubview:payTypeLab];
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, payTypeLab.bottom, APP_SCREEN_WIDTH, 62)];
    [self.view addSubview:view];
       UIView*line=[[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 1)];
    line.backgroundColor=RGBCOLOR(232, 232, 232);
    view.tag=10;
    view.userInteractionEnabled=YES;
    view.backgroundColor=[UIColor whiteColor];
    [view addSubview:line];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchImage:)];
    [view addGestureRecognizer:tap];
    //支付选择按钮
    _baoImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 20, 20)];
    _baoImage.layer.cornerRadius=10;
    _baoImage.layer.masksToBounds = YES;
    _baoImage.image=[UIImage imageNamed:@"hookRing"];
    [view addSubview:_baoImage];
    //支付宝logo
    UIImageView*logoImage=[[UIImageView alloc]initWithFrame:CGRectMake(_baoImage.right+10, 10, 40, 40)];
    logoImage.image=[UIImage imageNamed:@"zhifubao"];
    [view addSubview:logoImage];
    UILabel*titleLab=[[UILabel alloc]initWithFrame:CGRectMake(logoImage.right+5, 0, 200, 30)];
    titleLab.text=@"支付宝支付";
    titleLab.font=[UIFont systemFontOfSize:14];
    [view addSubview:titleLab];
    UILabel*contentLab=[[UILabel alloc]initWithFrame:CGRectMake(logoImage.right+5, 30, 200, 30)];
    contentLab.text=@"推荐支付宝用户使用";
   contentLab.font=[UIFont systemFontOfSize:13];
    contentLab.textColor=[UIColor grayColor];
    [view addSubview:contentLab];
    UIView*line1=[[UIView alloc]initWithFrame:CGRectMake(0, 61, APP_SCREEN_WIDTH, 1)];
    line1.backgroundColor=RGBCOLOR(232, 232, 232);
    [view addSubview:line1];
    UIView*view2=[[UIView alloc]initWithFrame:CGRectMake(0, view.bottom, APP_SCREEN_WIDTH, 61)];
    [self.view addSubview:view2];
    //微信按钮
    _weiImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 20, 20)];
    _weiImage.layer.cornerRadius=10;
    _weiImage.layer.masksToBounds = YES;
    _weiImage.image=[UIImage imageNamed:@"emptyRing"];
    [view2 addSubview:_weiImage];
    //微信logo
    UIImageView*logoImage1=[[UIImageView alloc]initWithFrame:CGRectMake(_baoImage.right+10, 10, 40, 40)];
    logoImage1.image=[UIImage imageNamed:@"weixin"];
    [view2 addSubview:logoImage1];
    UILabel*titleLab1=[[UILabel alloc]initWithFrame:CGRectMake(logoImage.right+5, 0, 200, 30)];
    titleLab1.text=@"微信支付";
    titleLab1.font=[UIFont systemFontOfSize:14];
    [view2 addSubview:titleLab1];
    UILabel*contentLab1=[[UILabel alloc]initWithFrame:CGRectMake(logoImage.right+5, 30, 200, 30)];
    contentLab1.text=@"推荐微信用户使用";
    contentLab1.font=[UIFont systemFontOfSize:13];
    contentLab1.textColor=[UIColor grayColor];
    [view2 addSubview:contentLab1];
    UIView*line2=[[UIView alloc]initWithFrame:CGRectMake(0, 60, APP_SCREEN_WIDTH, 1)];
    line2.backgroundColor=RGBCOLOR(232, 232, 232);
    [view2 addSubview:line2];
    view2.tag=11;
    view2.userInteractionEnabled=YES;
    view2.backgroundColor=[UIColor whiteColor];

    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchImage:)];
    [view2 addGestureRecognizer:tap1];
    
    UIView*view3=[[UIView alloc]initWithFrame:CGRectMake(0, APP_SCREEN_HEIGHT-114, APP_SCREEN_WIDTH, 50)];
    view3.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view3];
    UIButton*btn=[UIButton new];
    btn.frame=CGRectMake(10, 8, 100, 34);
    btn.layer.borderColor = RGBCOLOR(245, 50, 109).CGColor;
    btn.layer.cornerRadius=5;
    btn.layer.borderWidth = 1;
    //返回
    [btn setTitle:@"返回首页" forState:UIControlStateNormal];
    [btn setTitleColor:RGBCOLOR(245, 50, 109) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    [view3 addSubview:btn];
    //去支付按钮
    paybtn=[UIButton new];
    paybtn.frame=CGRectMake(APP_SCREEN_WIDTH-150, 2, 140, 44);
    paybtn.layer.borderColor = [UIColor redColor].CGColor;
    paybtn.layer.borderWidth = 1;
   paybtn.layer.cornerRadius=5;

    [paybtn setTitle:@"立即支付" forState:UIControlStateNormal];
    [paybtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    paybtn.backgroundColor=RGBCOLOR(245, 50, 109);
    [paybtn addTarget:self action:@selector(togoPay) forControlEvents:UIControlEventTouchUpInside];
    [view3 addSubview:paybtn];
    //微信成功回调，通过通知接受
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"paymoney1" object:nil];
    
    
}

// 微信回调  通知绑定方法，进行判断
- (void)getOrderPayResult:(NSNotification *)notification{
    if ([notification.object isEqualToString:@"success"])
    {
        //如果成功，进入成功页面
        [self requestOrderDetailsByOrderId:orderId userId:user.userId payStatus:@"1"];
        
    }
    else
    {
        //失败，进入失败页面
        [self requestOrderDetailsByOrderId:orderId userId:user.userId payStatus:@"0"];
    }
}

-(void)touchImage:(UITapGestureRecognizer*)tap
{    //选择支付宝
    if (tap.view.tag==10) {
        payType=@"1";
        _baoImage.image=[UIImage imageNamed:@"hookRing"];
        _weiImage.image=[UIImage imageNamed:@"emptyRing"];

    }
    //选择微信
    else if (tap.view.tag==11)
    {
        payType=@"2";
        _baoImage.image=[UIImage imageNamed:@"emptyRing"];
        _weiImage.image=[UIImage imageNamed:@"hookRing"];
    }
}
-(void)goback
{
     
    [self.tabBarController setSelectedIndex:0];
    [self.navigationController popToRootViewControllerAnimated:YES];

}
-(void)togoPay
{
    [self doPayOrderAction];
}
- (void) doPayOrderAction {
    paybtn.userInteractionEnabled=NO;
    paybtn.backgroundColor=RGBCOLOR(240, 240, 240);
     paybtn.layer.borderColor = RGBCOLOR(240, 240, 240).CGColor;
    NSString *url;
    if (self.dingdanID)
    {
        url = @"app/order/order/payOrder.do";
        _params=[[NSMutableDictionary alloc]init];
        [_params setValue:user.userId forKey:@"regUserId"];
        [_params setValue:self.dingdanID forKey:@"orderId"];
    }
    else
    {
        //定义请求地址
      url = @"app/order/order/insertOrder.do";
        
        //定义请求参数
        
    }
    //支付类型
    [_params setValue:payType forKey:@"payType"];
    
    [[BaseRequest sharedInstance] request:url parameters:_params success:^(id responseObject) {
        NSLog(@"++++==%@",responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            if (responseObject[@"result"]==nil) {
                [SVProgressHUD showInfoWithStatus:@"支付失败"];
                return;
            }
            //[_params removeAllObjects];
            if ([payType integerValue]==1) {           //支付宝支付
                [self doAlipay:responseObject];
            }else if([payType integerValue]==2){       //微信支付
                [self doWXpay:responseObject];
            }
        }else{
            paybtn.userInteractionEnabled=YES;
            paybtn.backgroundColor=RGBCOLOR(245, 50, 109);
            NSString*tipStr=@"支付失败";
            if (responseObject[@"result"]) {
                tipStr = responseObject[@"result"];
            }
            [SVProgressHUD showInfoWithStatus:tipStr];
        }
        
    } failure:^(NSError *error) {
        //        NSLog(@"error: %@", [error localizedDescription]);
    }];

}
/**
 * 调用支付宝支付接口
 */
- (void) doAlipay:(id)responseObject {
    orderId=responseObject[@"orderId"];
    [self payByAliWithPayOrder:responseObject[@"result"] fromScheme:kScheme];
    paybtn.userInteractionEnabled=YES;
    paybtn.backgroundColor=RGBCOLOR(245, 50, 109);
    
}

/**
 * 调用微信支付接口
 */
-(void)doWXpay:(id)responseObject
{
    orderId=responseObject[@"result"][@"orderId"];
    //判断是否安装微信，如果安装微信则调用微信支付否则提示用户去安装微信
    if([WXApi isWXAppInstalled])
        
    {
        
        PayReq *request = [[PayReq alloc] init] ;
        if (responseObject[@"result"][@"partnerid"]) {
            request.partnerId = responseObject[@"result"][@"partnerid"];
        }
        else{
            [SVProgressHUD showInfoWithStatus:@"支付失败"];
            return;
        }
        if (responseObject[@"result"][@"prepayid"]) {
            request.prepayId= responseObject[@"result"][@"prepayid"];

        }else{
            [SVProgressHUD showInfoWithStatus:@"支付失败"];
            return;
        }
        if (responseObject[@"result"][@"noncestr"]) {
            request.nonceStr= responseObject[@"result"][@"noncestr"];

        }else{
            [SVProgressHUD showInfoWithStatus:@"支付失败"];
            return;
        }
        if (responseObject[@"result"][@"timestamp"]) {
            request.timeStamp= [responseObject[@"result"][@"timestamp"] intValue];

        }else{
            [SVProgressHUD showInfoWithStatus:@"支付失败"];
            return;
        }
        if (responseObject[@"result"][@"sign"])
        {
            request.sign= responseObject[@"result"][@"sign"];

        }else{
            [SVProgressHUD showInfoWithStatus:@"支付失败"];
            return;
        }
        request.package = @"Sign=WXPay";
        [WXApi sendReq:request];
        paybtn.userInteractionEnabled=YES;
        paybtn.backgroundColor=RGBCOLOR(245, 50, 109);
    }
    else
    {
        
        [SVProgressHUD showInfoWithStatus:@"请安装微信"];
        paybtn.userInteractionEnabled=YES;
        paybtn.backgroundColor=RGBCOLOR(245, 50, 109);
    }
}
/**
 *  通过支付宝支付
 *
 *  @param payOrder <#payOrder description#>
 *  @param scheme   <#scheme description#>
 */
- (void) payByAliWithPayOrder:(NSString *)payOrder fromScheme:(NSString *)appScheme{
    [[AlipaySDK defaultService] payOrder:payOrder fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        //【callback 处理支付结果】
        if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
            //            NSLog(@"支付成功:%@", resultDic);
            [self requestOrderDetailsByOrderId:orderId userId:user.userId payStatus:@"1"];
        } else if([resultDic[@"resultStatus"] isEqualToString:@"6001"]){
            //            NSLog(@"支付失败,手动取消:%@", resultDic);
            [self requestOrderDetailsByOrderId:orderId userId:user.userId payStatus:@"0"];
        }
    }];
}

/**
 *  通过ID查询订单详情
 *
 *  @param orderId 订单ID
 *  @param userId 会员ID
 *  @param payStatus 0_成功，1_失败
 */

- (void) requestOrderDetailsByOrderId:(NSString *)oId userId:(NSString *)userId payStatus:(NSString *)payStatus{
    NSString *url = @"app/order/order/findOrderItemList.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:oId forKey:@"orderId"];
    [params setValue:userId forKey:@"regUserId"];
    
    [baseRequest request:url parameters:params success:^(id responseObject) {
        //NSLog(@"Order detail real response object: %@", responseObject[@"result"]);
        NSLog(@"支付信息 %@",responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"] && responseObject[@"result"]) {
            if (responseObject[@"result"]==nil)
            {
                return ;
            }
            NSDictionary *dict = responseObject[@"result"];
            orderDetails = [ZMOrderDetails orderDetailsWithDictionary:dict];
            if ([payStatus integerValue] == 0) {            // 失败
                ZMPayFailFromConfirmOrderViewController *failedVC = [[ZMPayFailFromConfirmOrderViewController alloc] init];
                failedVC.orderId = orderId;
                failedVC.payTapeName=orderDetails.payTypeName;
                failedVC.orderDetails = orderDetails;
                [[NSNotificationCenter defaultCenter]removeObserver:self];
                [self.navigationController pushViewController:failedVC animated:YES];
            } else if   ([payStatus integerValue] == 1){    // 成功
                ZMPaySuccessFromConfirmViewController *successVC = [[ZMPaySuccessFromConfirmViewController alloc] init];
                successVC.orderDetails = orderDetails;
                [[NSNotificationCenter defaultCenter]removeObserver:self];
                [self.navigationController pushViewController:successVC animated:YES];
            }
        }
    } failure:^(NSError *error) {
        //NSLog(@"error:%@", [error localizedDescription]);
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
