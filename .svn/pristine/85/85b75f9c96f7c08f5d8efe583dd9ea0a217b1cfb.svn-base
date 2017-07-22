//
//  WYAOrderConfirmViewController.m
//  WY4iPhone
//
//  Created by zhuwei on 15/9/8.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "WYAOrderConfirmViewController.h"
#import "WYAAddressManageViewController.h"
#import "JSONKit.h"
#import "WYAOrderInfoListCell.h"
#import "WYAOrderCostListCell.h"
#import "WYAPayInfoListCell.h"
#import "BaseRequest.h"
#import "ZMShoppingCart.h"
#import "ZMShoppingCartPro.h"
#import "ZMShipment.h"
#import <AlipaySDK/AlipaySDK.h>
#import "ZMPayFailedViewController.h"
#import "ZMPaySuccessViewController.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "ZMCouponListViewController.h"
#define kScheme     @"WYAPayByAliScheme"
#define kLoginUrl       @"app/crm/reguser/login.do"

@interface WYAOrderConfirmViewController ()<UIGestureRecognizerDelegate>{
    BaseRequest *baseRequest;
    ZMUser *user;
    
    ZMShipment *defaultShipment;
    UIView *footerView;
    NSInteger couponId;
    NSInteger couponNum;    //优惠券张数
    NSString* payType;//支付方式1-支付宝，2-微信
    NSArray *parTypeArray;
    NSIndexPath *curPayIndexPath;
    NSString*selCouponItemId;
    // 总金额
    float amount;
    // 运费
    float expCharge;
    // 商品总价
    float proAmont;
    
    UILabel *nameTitle;
    NSString *payUrlResult;
    
    NSArray *couponList;
    
    NSString *orderId;
    
    ZMOrderDetails *orderDetails;
    UIView*view5;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *payButton;

@property (nonatomic, strong) NSDictionary *viewDicts;

@end

@implementation WYAOrderConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"订单确认";
    payType=@"1";
    //返回按钮
    // Do any additional setup after loading the view.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(245, 50, 109);;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //微信支付
    _weiXin=[[WXApi alloc]init];
    
    baseRequest = [BaseRequest sharedInstance];
    parTypeArray = @[@1, @2];
    //给地址复制
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    user=[ZMUser userWithDict:userDic];
    _cosign=_zmUser.addrrss.consignee;
    _tellphone=_zmUser.addrrss.telNo;
    _province=_zmUser.addrrss.addrProvince;
    _city=_zmUser.addrrss.addrCity;
    _area=_zmUser.addrrss.addrArea;
    _detailAdd=_zmUser.addrrss.addr;
    _shenfenhao=_zmUser.addrrss.shenfenID;
    _addressId=_zmUser.addrrss.addressId;
    [self bigView];
    [self initView];
    [self requestView];
    //微信成功回调，通过通知接受
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"paymoney" object:nil];
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
}
//移除通知
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"paymoney" object:nil];
    
}
/**
 *  初始化UI界面
 */
- (void) initView{
    UIView *bottomView = [UIView new];
    bottomView.frame=CGRectMake(0, APP_SCREEN_HEIGHT-114, APP_SCREEN_WIDTH, 50);
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    //合计
    UILabel *priceLabel = [UILabel new];
    priceLabel.frame=CGRectMake(0, 0, APP_SCREEN_WIDTH/2, 50);
    
    [bottomView addSubview:priceLabel];
    //支付按钮
    UIButton *payButton = [UIButton new];
    payButton.frame=CGRectMake(priceLabel.right, 0, APP_SCREEN_WIDTH/2, 50);
    payButton.translatesAutoresizingMaskIntoConstraints = NO;
    payButton.backgroundColor = RGBCOLOR(245, 43, 105);
    payButton.tag=100;
    [payButton setTitle:@"立即支付" forState:UIControlStateNormal];
    [payButton addTarget:self action:@selector(payButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:payButton];
    
    self.priceLabel = priceLabel;
    self.payButton = payButton;
    
    
    
    self.bottomView = bottomView;
    //[self.view addSubview:_tableView];
    
}

/**
 *  加载数据
 */
- (void)viewWillAppear:(BOOL)animated
{
    //[super viewWillAppear:animated];
    [MobClick beginLogPageView:@"PageOne"];
    if (_address) {
        //给地址复制
        _cosign=_address.consignee;
        _tellphone=_address.telNo;
        _province=_address.addrProvince;
        _city=_address.addrCity;
        _area=_address.addrArea;
        _detailAdd=_address.addr;
        _shenfenhao=_address.shenfenID;
        _addressId=_address.addressId;
        [self bigView];
        [self initView];
        [self requestView];
 
    }
    if (self.cashId)
    {
        [self confirmOrderByUserId:user.userId couponItemId:self.cashId shoppingCartPros:_buyProductList addressId:_addressId];
        
    }
 
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"PageOne"];
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

/**
 * 加载数据
 */
- (void) requestView{
    [self confirmOrderByUserId:user.userId couponItemId:self.cashId shoppingCartPros:_buyProductList addressId:_addressId];
    
}


-(void)bigView
{
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT)];
    _scrollView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_scrollView];
    UILabel*addBackLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 35)];
    addBackLab.text=@"  收货人信息";
    //addBackLab.alpha=0.2;
    addBackLab.textColor=RGBCOLOR(159, 169, 176);
    addBackLab.backgroundColor=RGBCOLOR(245, 245, 245);
    [_scrollView addSubview:addBackLab];
    UIView *addLIne = [[UIView alloc] initWithFrame:CGRectMake(0, addBackLab.bottom, self.view.width, 1)];
    addLIne.backgroundColor = RGBCOLOR(237, 237, 237);
    [_scrollView addSubview:addLIne];
    UIView *view;
    
    if (_addressId)
    {
        view = [[UIView  alloc] initWithFrame:CGRectMake(0,addBackLab.bottom+ 11, APP_SCREEN_WIDTH, 90)];
        view.backgroundColor = [UIColor whiteColor];
        CGFloat font = 14;
        //名字
        nameTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, font + 2)];
        nameTitle.font = [UIFont systemFontOfSize:font];
        nameTitle.text = _cosign;
        [view addSubview:nameTitle];
        //电话
        UILabel *phoneTitle = [[UILabel alloc] initWithFrame:CGRectMake(nameTitle.right, nameTitle.top, view.width - 10 * 2 - nameTitle.width, font + 2)];
        phoneTitle.font = [UIFont systemFontOfSize:font];
        phoneTitle.text = _tellphone;
        [view addSubview:phoneTitle];
        //省市县
        UILabel *generalTitle = [[UILabel alloc] initWithFrame:CGRectMake(nameTitle.left, nameTitle.bottom + 10, 200, font + 2)];
        generalTitle.font = [UIFont systemFontOfSize:font];
        generalTitle.text = [NSString stringWithFormat:@"%@ - %@ - %@",_province, _city, _area];
        [view addSubview:generalTitle];
        //详细地址
        UILabel *detailTitle = [[UILabel alloc] initWithFrame:CGRectMake(nameTitle.left, generalTitle.bottom + 10, APP_SCREEN_WIDTH-15, font + 2)];
        detailTitle.font = [UIFont systemFontOfSize:font];
        detailTitle.text = _detailAdd;
        //身份证
        _IDtextField=[[UITextField alloc]initWithFrame:CGRectMake(nameTitle.left, detailTitle.bottom+10, APP_SCREEN_WIDTH-30, 44)];
        _IDtextField.delegate=self;
        _IDtextField.placeholder=@"请输入你的身份证号";
        //_IDtextField.textColor=RGBCOLOR(159, 169, 176);
        [_IDtextField setValue:RGBCOLOR(159, 169, 176) forKeyPath:@"_placeholderLabel.textColor"];
        _IDtextField.hidden=YES;
        
        
        //_IDtextField.backgroundColor=[UIColor grayColor];
        [view addSubview:_IDtextField];
        [view addSubview:detailTitle];
        //判断填写身份证的框是否隐藏，先通过数组遍历，添加一个对象进行遍历，并通过正则判断身份证是否正确
        
        for (int i=0;  i <self.buyProductList.count;i++)
        {
            ZMShoppingCartPro*pro=self.buyProductList[i];
            if ([pro.isBW isEqualToString:@"1"])
            {
                _IDtextField.hidden=NO;
                view.frame=CGRectMake(0,addBackLab.bottom+ 11, APP_SCREEN_WIDTH, 140);
                if (_shenfenhao) {
                    _IDtextField.text=_shenfenhao;
                }
                break;
            }
        }
    }
    else
    {
        view = [[UIView  alloc] initWithFrame:CGRectMake(0, addBackLab.bottom+1, APP_SCREEN_WIDTH, 44)];
        view.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.width, 5)];
        //line.backgroundColor = RGBCOLOR(240, 240, 240);
        [view addSubview:line];
        
        UIImageView *imgAddView = [[UIImageView alloc] initWithFrame:CGRectMake(10, line.bottom + 10, 14, 14)];
        imgAddView.image = [UIImage imageNamed:@"addAddress_icon"];
        [view addSubview:imgAddView];
        
        CGFloat font = 14;
        nameTitle = [[UILabel alloc] initWithFrame:CGRectMake(imgAddView.right + 10, line.bottom + 10, 200, font)];
        nameTitle.font = [UIFont systemFontOfSize:font];
        nameTitle.text = @"请先填写收货地址";
        [view addSubview:nameTitle];
        
        UIImageView *imgRightIndicate = [[UIImageView alloc] initWithFrame:CGRectMake(view.width - 10 - 9 - 5, (view.height - 13 - line.height) / 2 + line.bottom, 9, 13)];
        imgRightIndicate.image = [UIImage imageNamed:@"mine_rightGray"];
        [view addSubview:imgRightIndicate];
    }
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *Viewtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressViewClicked:)];
    [view addGestureRecognizer:Viewtap];
    [_scrollView addSubview:view];
    UIView *line9 = [[UIView alloc] initWithFrame:CGRectMake(0, view.bottom-1, self.view.width, 1)];
    line9.backgroundColor = RGBCOLOR(237, 237, 237);
    [_scrollView addSubview:line9];
    UILabel*proBackLab=[[UILabel alloc]initWithFrame:CGRectMake(0, view.bottom, APP_SCREEN_WIDTH, 35)];
    proBackLab.text=@"  订单信息";
    
    proBackLab.textColor=RGBCOLOR(159, 169, 176);
    proBackLab.backgroundColor=RGBCOLOR(245, 245, 245);
    [_scrollView addSubview:proBackLab];
    UIView *line10 = [[UIView alloc] initWithFrame:CGRectMake(0, proBackLab.bottom, self.view.width, 1)];
    line10.backgroundColor = RGBCOLOR(237, 237, 237);
    [_scrollView addSubview:line10];
    for (int i=0; i<_buyProductList.count;i++ )
    {
        UIView*proView=[[UIView alloc]initWithFrame:CGRectMake(0, proBackLab.bottom+100*i, APP_SCREEN_WIDTH, 100)];
        [_scrollView addSubview:proView];
        UIImageView *goodsImageView = [UIImageView new];
        goodsImageView.frame=CGRectMake(10, 10, 80, 80);
        goodsImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [proView addSubview:goodsImageView];
        
        UILabel *goodsTitle = [UILabel new];
        goodsTitle.frame=CGRectMake(goodsImageView.right+5, 10, 120, 60);
        goodsTitle.translatesAutoresizingMaskIntoConstraints = NO;
        goodsTitle.numberOfLines = 0;
        goodsTitle.font = [UIFont systemFontOfSize:15];
        goodsTitle.textColor = RGBCOLOR(53, 53, 53);
        [proView addSubview:goodsTitle];
        
        UILabel *priceTitle = [UILabel new];
        priceTitle.frame=CGRectMake(APP_SCREEN_WIDTH-100, 45, 90, 15);
        priceTitle.translatesAutoresizingMaskIntoConstraints = NO;
        priceTitle.text = @"￥ 12";
        priceTitle.textAlignment=NSTextAlignmentRight;
        priceTitle.font = [UIFont systemFontOfSize:14];
        priceTitle.textColor = RGBCOLOR(53, 53, 53);;
        [proView addSubview:priceTitle];
        
        UILabel *numberTitle = [UILabel new];
        numberTitle.frame=CGRectMake(APP_SCREEN_WIDTH-100, priceTitle.bottom+5, 90, 15);
        numberTitle.translatesAutoresizingMaskIntoConstraints = NO;
        numberTitle.text = @"x1";
        numberTitle.textAlignment=NSTextAlignmentRight;
        numberTitle.textColor = RGBCOLOR(143, 143, 143);
        numberTitle.font = [UIFont systemFontOfSize:14];
        [proView addSubview:numberTitle];
        UIView*proLine=[[UIView alloc]initWithFrame:CGRectMake(0, proView.bottom-1, APP_SCREEN_WIDTH, 1)];
        proLine.backgroundColor = RGBCOLOR(237, 237, 237);
        [_scrollView addSubview:proLine];
        ZMShoppingCartPro *pro;
        pro = _buyProductList[i];
        [goodsImageView sd_setImageWithURL:[NSURL URLWithString:pro.httpImgUrl]];
        goodsTitle.text = pro.proName;
        priceTitle.text = [NSString stringWithFormat:@"￥%@", pro.price];
        numberTitle.text = [NSString stringWithFormat:@"x%@", pro.quantity];
        
        
    }
    //物流费用
    UILabel *expChargeLable = [[UILabel alloc] initWithFrame:CGRectMake(10, proBackLab.bottom+100*_buyProductList.count+15 , 56, 14)];
    expChargeLable.textColor = RGBCOLOR( 205, 205, 205);
    expChargeLable.text = @"物流费用";
    expChargeLable.font = [UIFont systemFontOfSize:14];
    [_scrollView addSubview:expChargeLable];
    NSInteger labelWidth=self.view.width - 10 * 2 - expChargeLable.width;
    _labelExpCharge = [[UILabel alloc] initWithFrame:CGRectMake(expChargeLable.right, expChargeLable.top, labelWidth, 14)];
    _labelExpCharge.textColor = RGBCOLOR( 53, 53, 53);
    _labelExpCharge.textAlignment = NSTextAlignmentRight;
    _labelExpCharge.font = [UIFont systemFontOfSize:14];
    [_scrollView addSubview:_labelExpCharge];
    //分界线
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, expChargeLable.bottom + 15, self.view.width, 1)];
    line1.backgroundColor = RGBCOLOR(237, 237, 237);
    [_scrollView addSubview:line1];
    
    UIView *couponView = [[UIView alloc] initWithFrame:CGRectMake(0, line1.bottom, self.view.width, 44)];
    couponView.backgroundColor = [UIColor clearColor];
    couponView.userInteractionEnabled = YES;
    [_scrollView addSubview:couponView];
    //代金券
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(expChargeLable.left,line1.bottom+ 15, expChargeLable.width, expChargeLable.height)];
    titleLabel.textColor = RGBCOLOR( 205, 205, 205);
    titleLabel.text = @"代金券";
    titleLabel.font = [UIFont systemFontOfSize:14];
    [_scrollView addSubview:titleLabel];
    
    //定义查询优惠券手势
    UITapGestureRecognizer *queryCouponListTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(queryCouponListAction)];
    [couponView addGestureRecognizer:queryCouponListTap];
    
    _labelCouponLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.right, titleLabel.top, labelWidth-14, 14)];
    _labelCouponLabel.textColor = RGBCOLOR( 53, 53, 53);
    _labelCouponLabel.textAlignment = NSTextAlignmentRight;
    _labelCouponLabel.font = [UIFont systemFontOfSize:14];
    [_scrollView addSubview:_labelCouponLabel];
    
    UIImageView *imgRightIndiate = [[UIImageView alloc] initWithFrame:CGRectMake(_labelCouponLabel.right + 5, (couponView.height - 13) / 2, 9, 13)];
    imgRightIndiate.image = [UIImage imageNamed:@"mine_rightGray"];
    [couponView addSubview:imgRightIndiate];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, couponView.bottom, self.view.width, 1)];
    line2.backgroundColor = RGBCOLOR(237, 237, 237);
    [_scrollView addSubview:line2];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(expChargeLable.left, line2.bottom + 15, expChargeLable.width, expChargeLable.height)];
    priceLabel.font = [UIFont systemFontOfSize:14];
    priceLabel.text = @"商品总价";
    priceLabel.textColor = RGBCOLOR( 205, 205, 205);
    [_scrollView addSubview:priceLabel];
    
    _labelPrice = [[UILabel alloc] initWithFrame:CGRectMake(priceLabel.right, priceLabel.top,   labelWidth, 14)];
    _labelPrice.textColor = RGBCOLOR( 53, 53, 53);
    _labelPrice.textAlignment = NSTextAlignmentRight;
    _labelPrice.font = [UIFont systemFontOfSize:14];
    [_scrollView addSubview:_labelPrice];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, priceLabel.bottom + 15, self.view.width, 1)];
    line3.backgroundColor = RGBCOLOR(237, 237, 237);
    [_scrollView addSubview:line3];
    UILabel*payTypeLab=[[UILabel alloc]initWithFrame:CGRectMake(0, line3.bottom, APP_SCREEN_WIDTH, 35)];
    payTypeLab.backgroundColor=RGBCOLOR(240, 240, 240);
    payTypeLab.textColor=RGBCOLOR(159, 169, 176);
    payTypeLab.backgroundColor=RGBCOLOR(245, 245, 245);
    payTypeLab.text=@"  支付方式";
    [_scrollView addSubview:payTypeLab];
    UIView*view3=[[UIView alloc]initWithFrame:CGRectMake(0, payTypeLab.bottom, APP_SCREEN_WIDTH, 62)];
    [_scrollView addSubview:view3];
    UIView*line=[[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 1)];
    line.backgroundColor=RGBCOLOR(232, 232, 232);
    view3.tag=10;
    view3.userInteractionEnabled=YES;
    view3.backgroundColor=[UIColor whiteColor];
    [view3 addSubview:line];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchImage:)];
    [view3 addGestureRecognizer:tap];
    //支付选择按钮
    _baoImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 20, 20)];
    _baoImage.layer.cornerRadius=10;
    _baoImage.layer.masksToBounds = YES;
    _baoImage.image=[UIImage imageNamed:@"hookRing"];
    [view3 addSubview:_baoImage];
    //支付宝logo
    UIImageView*logoImage=[[UIImageView alloc]initWithFrame:CGRectMake(_baoImage.right+10, 10, 40, 40)];
    logoImage.image=[UIImage imageNamed:@"zhifubao"];
    [view3 addSubview:logoImage];
    UILabel*titleLab=[[UILabel alloc]initWithFrame:CGRectMake(logoImage.right+5, 0, 200, 30)];
    titleLab.text=@"支付宝支付";
    titleLab.font=[UIFont systemFontOfSize:14];
    [view3 addSubview:titleLab];
    UILabel*contentLab=[[UILabel alloc]initWithFrame:CGRectMake(logoImage.right+5, 30, 200, 30)];
    contentLab.text=@"推荐支付宝用户使用";
    contentLab.font=[UIFont systemFontOfSize:13];
    contentLab.textColor=[UIColor grayColor];
    [view3 addSubview:contentLab];
    UIView*labline1=[[UIView alloc]initWithFrame:CGRectMake(0, 61, APP_SCREEN_WIDTH, 1)];
    labline1.backgroundColor=RGBCOLOR(232, 232, 232);
    [view3 addSubview:labline1];
    UIView*view2=[[UIView alloc]initWithFrame:CGRectMake(0, view3.bottom, APP_SCREEN_WIDTH, 61)];
    [_scrollView addSubview:view2];
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
    UIView*labline2=[[UIView alloc]initWithFrame:CGRectMake(0, 60, APP_SCREEN_WIDTH, 1)];
    labline2.backgroundColor=RGBCOLOR(232, 232, 232);
    [view2 addSubview:labline2];
    view2.tag=11;
    view2.userInteractionEnabled=YES;
    view2.backgroundColor=[UIColor whiteColor];
    
    UITapGestureRecognizer *latap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchImage:)];
    [view2 addGestureRecognizer:latap1];
    view5=[[UIView alloc]initWithFrame:CGRectMake(0, view2.bottom, APP_SCREEN_WIDTH, 60)];
    view5.backgroundColor=[UIColor whiteColor];
    [_scrollView addSubview:view5];
    _contentTextField = [[UITextField alloc] initWithFrame:CGRectMake(5, 5, APP_SCREEN_WIDTH-10,50)];
    _contentTextField.delegate = self;
    _contentTextField.returnKeyType = UIReturnKeyDone;
    _contentTextField.placeholder=@"  备注:";
    _contentTextField.layer.borderColor = RGBCOLOR(237, 237, 237).CGColor;
    _contentTextField.layer.borderWidth = 1;
    _contentTextField.layer.cornerRadius=5;
    [view5 addSubview:_contentTextField];
    UIView *line6 = [[UIView alloc] initWithFrame:CGRectMake(0, 59, self.view.width, 1)];
    line6.backgroundColor = RGBCOLOR(237, 237, 237);
    [view5 addSubview:line6];
    
    _scrollView.contentSize = CGSizeMake(APP_SCREEN_WIDTH,view5.bottom+120);
    
    
}
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    //_tableView.frame = CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT-height-60);
    [UIView animateWithDuration:0.23 animations:^{
        _scrollView.frame = CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT-height-64);
        _scrollView.contentSize = CGSizeMake(APP_SCREEN_WIDTH,view5.bottom);
        
    }];
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    
    [self.view endEditing:YES];
    
    
    [UIView animateWithDuration:0.23 animations:^{
        [_bottomView sendSubviewToBack:_scrollView];
        _scrollView.contentSize = CGSizeMake(APP_SCREEN_WIDTH,view5.bottom+120);
        _scrollView.frame = CGRectMake(0, 0, APP_SCREEN_WIDTH,APP_SCREEN_HEIGHT);
        
    }];
    
    
    
    
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
- (void) addressViewClicked:(UITapGestureRecognizer *)tap{
    WYAAddressManageViewController *addressManageVC = [WYAAddressManageViewController new];
    //通过属性传值，保留self
    
    addressManageVC.orderVC=self;
    
    [self.navigationController pushViewController:addressManageVC animated:YES];
}

/**
 * 查询优惠券列表
 */
-(void)queryCouponListAction
{
    
    if (couponNum>0) {
        NSMutableArray *shoppingCartPros = [NSMutableArray array];
        for (ZMShoppingCartPro *pro in _buyProductList) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setValue:pro.proId forKey:@"proId"];
            [dict setValue:pro.price forKey:@"price"];
            [dict setValue:pro.quantity forKey:@"quantity"];
            [shoppingCartPros addObject:dict];
        }
        ZMCouponListViewController*couponListVC=[ZMCouponListViewController new];
        couponListVC.addressID=_addressId;
        couponListVC.orderVC=self;
        couponListVC.shopCatArr=shoppingCartPros;
        [self.navigationController pushViewController:couponListVC animated:YES];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:@"没有优惠劵"];
    }
  
}
#pragma mark - Custom Method

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  确认订单
 *
 *  @param userId       会员ID
 *  @param couponItemId 优惠券ID，没有 = 0
 *  @param products     商品列表
 */
- (void) confirmOrderByUserId:(NSString *)userId couponItemId:(NSString *)couponItemId shoppingCartPros:(NSArray *)products addressId:(NSString*)addressId{
    NSString *url = @"app/order/order/confirmOrder.do";
    _payButton.userInteractionEnabled=NO;
    _payButton.backgroundColor= RGBCOLOR(143, 136, 136);
    NSMutableArray *shoppingCartPros = [NSMutableArray array];
    for (ZMShoppingCartPro *pro in products) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:pro.proId forKey:@"proId"];
        [dict setValue:pro.price forKey:@"price"];
        [dict setValue:pro.quantity forKey:@"quantity"];
        [shoppingCartPros addObject:dict];
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userId forKey:@"regUserId"];
    if (couponItemId)
    {
        [params setObject:couponItemId forKey:@"couponItemId"];
        
    }
    if (addressId)
    {
        [params setValue:addressId forKey:@"addrId"];
        
    }
    [params setObject:shoppingCartPros forKey:@"items"];
    [baseRequest orderRequest:url parameters:params success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        if ([responseObject[@"statu"] isEqualToString:@"true"] && responseObject[@"result"]) {
            NSDictionary *result = responseObject[@"result"];
            amount = [result[@"amount"] floatValue];
            expCharge = [result[@"expCharge"] floatValue];
            proAmont = [result[@"proAmont"] floatValue];
            //合计
            _priceLabel.attributedText = [self parserString:@"合计：" withContentStr:[NSString stringWithFormat:@"￥%.2f",  amount] endString:@""];
            //物流费用
            _labelExpCharge.text = [NSString stringWithFormat:@"￥%.2f", expCharge];
            
            //商品价格
            _labelPrice.text = [NSString stringWithFormat:@"￥%.2f", proAmont];
            _payButton.userInteractionEnabled=YES;
            _payButton.backgroundColor=RGBCOLOR(245, 43, 105);
            [self requestNumOfCouponByUserId:user.userId adressID:addressId];
            
        }else{
            NSString*tipStr=@"订单确认失败";
            if (responseObject[@"result"]) {
                tipStr = responseObject[@"result"];
            }
            [SVProgressHUD showInfoWithStatus:tipStr];
        }
    } failure:^(NSError *error) {
        //        NSLog(@"confirmOrderByUserId error: %@", [error localizedDescription]);
    }];
}

/**
 *  查询可使用的优惠券张数
 *
 *  @param userId 会员ID
 */
- (void) requestNumOfCouponByUserId:(NSString *)userId adressID:(NSString*)addressId{
    if (userId==nil)
    {
        return;
    }
    
    //NSString *url = @"app/crm/coupon/v1.2.0/findUsefulCouponNumByRegUserId.do";
    NSString*url=[NSString stringWithFormat:@"app/crm/coupon/%@/findUsefulCouponNumByRegUserId.do",ppVersion];

    NSMutableArray *shoppingCartPros = [NSMutableArray array];
    for (ZMShoppingCartPro *pro in _buyProductList) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:pro.proId forKey:@"proId"];
        [dict setValue:pro.price forKey:@"price"];
        [dict setValue:pro.quantity forKey:@"quantity"];
        [shoppingCartPros addObject:dict];
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
       [params setValue:shoppingCartPros forKey:@"items"];
    [params setValue:userId forKey:@"regUserId"];
    [params setValue:addressId forKey:@"addrId"];
    
    [baseRequest orderRequest:url parameters:params success:^(id responseObject) {
        // NSLog(@"==%@",responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"] && responseObject[@"result"]) {
            couponNum = [responseObject[@"result"][@"couponNum"] integerValue];
            if (couponNum==0)
            {
                _labelCouponLabel.text=@"暂无优惠劵可用";
            }
            else
            {
                _labelCouponLabel.attributedText = [self parserString:@"" withContentStr:[NSString stringWithFormat:@"%ld", (long)couponNum] endString:@"张可用"];
            }
            if ([self.ShopcouponAmount integerValue] >0)
            {
                _labelCouponLabel.text=[NSString stringWithFormat:@"%@元优惠劵",self.ShopcouponAmount];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}


/**
 *  富文本，拼接字符串
 *
 *  @param preStr 待拼接的字符串1
 *  @param str    待拼接的字符串2
 *
 *  @return 拼接好的字符串
 */
- (NSMutableAttributedString *) parserString:(NSString *)preStr withContentStr:(NSString *)str endString:(NSString *)endStr{
    NSString *postStr = [NSString stringWithFormat:@"%@%@%@", preStr, str, endStr];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:postStr];
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:RGBCOLOR(253, 0, 76)
                       range:NSMakeRange(preStr.length, str.length)];
    return attrString;
}

/**
 *  下单
 */
- (void) doPayOrderAction {
    //支付按钮置灰
    UIButton*btn=(UIButton *)[self.view viewWithTag:100];
    btn.userInteractionEnabled=NO;
    btn.backgroundColor=[UIColor grayColor];
    
    //定义请求地址
    NSString *url = @"app/order/order/insertOrder.do";
    
    //定义请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:user.userId forKey:@"regUserId"];                          //用户id
    [params setValue:user.telNo forKey:@"regUserTel"];                          //用户手机号码
    [params setValue:_addressId forKey:@"addrId"];                       //地址id
    [params setValue:_IDtextField.text forKey:@"identityCard"];                 //身份证号码
    [params setValue:[NSNumber numberWithFloat:amount] forKey:@"amount"];       //订单总金额
    
    //优惠券id
    int couponItemId = 0;
    if (self.cashId) {
        couponItemId =[self.cashId intValue];
    }
    [params setValue:[NSNumber numberWithInteger:couponItemId] forKey:@"couponItemId"];
    
    [params setValue:payType forKey:@"payType"];   //支付类型
    [params setValue:[NSNumber numberWithFloat:expCharge] forKey:@"shipAmount"];//邮费
    
    //商品明细
    NSMutableArray *pros = [NSMutableArray array];
    for (ZMShoppingCartPro *pro in _buyProductList) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:pro.proId forKey:@"proId"];
        [dict setValue:pro.quantity forKey:@"quantity"];
        [dict setValue:pro.price forKey:@"price"];
        [pros addObject:dict];
    }
    [params setValue:pros forKey:@"items"];
    //  备注
    if (_contentTextField.text)
    {
        [params setObject:_contentTextField.text forKey:@"desc"];
        
    }
    
    //下单请求
    [baseRequest orderRequest:url parameters:params success:^(id responseObject) {
        if ([responseObject[@"statu"] isEqualToString:@"true"]) {
            if (responseObject[@"result"]==nil) {
                [SVProgressHUD showInfoWithStatus:@"支付失败"];
                return;
            }
            if ([payType integerValue]==1) {           //支付宝支付
                [self doAlipay:responseObject];
            }else if([payType integerValue]==2){       //微信支付
                [self doWXpay:responseObject];
            }
        }else{
            NSString*tipStr=@"支付失败";
            if (responseObject[@"result"]) {
                tipStr = responseObject[@"result"];
            }
            [SVProgressHUD showInfoWithStatus:tipStr];
        }
        btn.userInteractionEnabled=YES;
        btn.backgroundColor = RGBCOLOR(245, 43, 105);
    } failure:^(NSError *error) {
        btn.userInteractionEnabled=YES;
        btn.backgroundColor = RGBCOLOR(245, 43, 105);
    }];
}

/**
 * 调用支付宝支付接口
 */
- (void) doAlipay:(id)responseObject {
    orderId = [NSString stringWithFormat:@"%@", responseObject[@"orderId"]];
    [self payByAliWithPayOrder:responseObject[@"result"] fromScheme:kScheme];
    UIButton*btn=(UIButton *)[self.view viewWithTag:100];
    btn.userInteractionEnabled=YES;
    btn.backgroundColor = RGBCOLOR(245, 43, 105);
}

/**
 * 调用微信支付接口
 */
-(void)doWXpay:(id)responseObject
{
    //判断是否安装微信，如果安装微信则调用微信支付否则提示用户去安装微信
    if([WXApi isWXAppInstalled])
        
    {
        orderId = responseObject[@"result"][@"orderId"];
        PayReq *request = [[PayReq alloc] init] ;
        request.partnerId = responseObject[@"result"][@"partnerid"];
        request.prepayId= responseObject[@"result"][@"prepayid"];
        request.package = @"Sign=WXPay";
        request.nonceStr= responseObject[@"result"][@"noncestr"];
        request.timeStamp= [responseObject[@"result"][@"timestamp"] intValue];
        request.sign= responseObject[@"result"][@"sign"];
        [WXApi sendReq:request];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:@"请安装微信"];
        UIButton*btn=(UIButton *)[self.view viewWithTag:100];
        btn.userInteractionEnabled=YES;
        btn.backgroundColor = RGBCOLOR(245, 43, 105);
    }
}

/**
 *  支付按钮点击响应事件
 *
 *  @param button 被点击的按钮
 */
- (void) payButtonClicked:(UIButton *)button{
    
    //验证收货人姓名是否为空
    if ( nameTitle.text == nil ) {
        [SVProgressHUD showInfoWithStatus:@"请选择收货地址"];
        return;
    }
    
    //遍历商品列表并验证是否含保税仓商品，如果有保税仓商品则验证身份证号码是否有效
    for (int i=0;  i <self.buyProductList.count;i++)
    {
        ZMShoppingCartPro*pro=self.buyProductList[i];
        if ([pro.isBW isEqualToString:@"1"])
        {
            if (![_IDtextField.text isidentityCard])
            {
                [SVProgressHUD showErrorWithStatus:@"请输入正确的身份证"];
                return;
            }
        }
    }
    
    [self doPayOrderAction];
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
#
- (void) requestOrderDetailsByOrderId:(NSString *)oId userId:(NSString *)userId payStatus:(NSString *)payStatus{
    NSString *url = @"app/order/order/findOrderItemList.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:oId forKey:@"orderId"];
    [params setValue:userId forKey:@"regUserId"];
    
    [baseRequest request:url parameters:params success:^(id responseObject) {
        //NSLog(@"Order detail real response object: %@", responseObject[@"result"]);
        if ([responseObject[@"statu"] isEqualToString:@"true"] && responseObject[@"result"]) {
            NSDictionary *dict = responseObject[@"result"];
            orderDetails = [ZMOrderDetails orderDetailsWithDictionary:dict];
            if ([payStatus integerValue] == 0) {            // 失败
                ZMPayFailFromConfirmOrderViewController *failedVC = [[ZMPayFailFromConfirmOrderViewController alloc] init];
                failedVC.orderId = orderId;
                failedVC.payTapeName=orderDetails.payTypeName;
                failedVC.orderDetails = orderDetails;
                [self.navigationController pushViewController:failedVC animated:YES];
            } else if   ([payStatus integerValue] == 1){    // 成功
                ZMPaySuccessFromConfirmViewController *successVC = [[ZMPaySuccessFromConfirmViewController alloc] init];
                successVC.orderDetails = orderDetails;
                [self.navigationController pushViewController:successVC animated:YES];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:@"加载失败"];
        }
    } failure:^(NSError *error) {
        //NSLog(@"error:%@", [error localizedDescription]);
    }];
    
}

@end
