//
//  WY4iPhone
//
//  Created by ZM21 on 15/9/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ProDetailViewController.h"

@interface ProDetailViewController (){
    UIView *viewProDetail;
    ZMProductDetail *proDetail;
    BOOL isHaveCollect;
    NSString*nameUserId;
    NSString*shopId;
    //库存；
    UILabel*currentStocklab;
    //购物车
    UIButton *btnAddCar;
    //是否收藏
    NSString*isFav;
    NSString*proname;
    NSString* shopProID;
};

@property (nonatomic, strong) ZMProDetailTableView *tableView;

@end

@implementation ProDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _product.proName;
    
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    _user=[ZMUser userWithDict:userDic];    _curSelectedAddProIndex = -1;
    
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"PageOne"];
    __weak typeof (self) safeSelf = self;
    [[ZMShoppingCart shoppingCartInstance] refreshShoppingCartWithUserId:safeSelf.user.userId success:^{
        //            __strong typeof (self) strongSelf = weakSelf;
        NSInteger count = [safeSelf calculateShoppingCartProNum];
        safeSelf.lableCarCount.hidden = count > 0 ? NO : YES;
        safeSelf.lableCarCount.text = [NSString stringWithFormat:@"%ld", (long)count];
        safeSelf.curSelectedAddProIndex = -1;
    }];   // [self chatShopNum];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"PageOne"];
    [SVProgressHUD dismiss];
}


- (void) initView{
    
    _tableView = [[ZMProDetailTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 60) style:UITableViewStyleGrouped];
    _tableView.proDetail = proDetail;
    [self.view addSubview:_tableView];
    //提示库存
    currentStocklab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 64)];
    currentStocklab.text=[NSString stringWithFormat:@"还剩下%@件，请抓紧购买",proDetail.currentStock];
    currentStocklab.textAlignment=NSTextAlignmentCenter;
    currentStocklab.textColor=[UIColor blackColor];
    currentStocklab.backgroundColor=RGBCOLOR(143, 136, 136);
    currentStocklab.alpha=0.4;
    [self.view addSubview:currentStocklab];
    if ([proDetail.currentStock integerValue]>5)
    {
        currentStocklab.hidden=YES;
    }
    if ([proDetail.currentStock integerValue]==0)
    {
        currentStocklab.text=[NSString stringWithFormat:@"已卖光，我们在全力补货"];
    }
    [_tableView bringSubviewToFront:currentStocklab];
    //分享
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareAction)];
    [_tableView.shareView addGestureRecognizer:tap1];
    //  收藏，通过网络请求的数据，进行判断
    if ([isFav isEqualToString:@"0"])
    {
        _tableView.collectImage.image=[UIImage imageNamed:@"collect"];
        isHaveCollect=NO;
    }
    else
    {
        _tableView.collectImage.image=[UIImage imageNamed:@"collected"];
        isHaveCollect=YES;
        
    }
    //  添加手势，绑定点击事件
    UITapGestureRecognizer *collecttap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(collectshop)];
    [_tableView.collectView addGestureRecognizer:collecttap ];
    
    
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 60, self.view.width, 60)];
    footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, footView.width, 1)];
    line.backgroundColor = RGBCOLOR(238, 238, 238);
    [footView addSubview:line];
    
    UIButton *btnShopingCar = [[UIButton alloc] initWithFrame:CGRectMake(20, 8, (self.view.width - 50) / 3, 45)];
    btnShopingCar.layer.cornerRadius = 5;
    btnShopingCar.layer.borderWidth = 1;
    btnShopingCar.layer.borderColor = RGBCOLOR(253, 193, 210).CGColor;
    [btnShopingCar setImage:[UIImage imageNamed:@"homepage_07"] forState:UIControlStateNormal];
    [btnShopingCar addTarget:self action:@selector(checkShoppingCar:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btnShopingCar];
    
    btnAddCar = [[UIButton alloc] initWithFrame:CGRectMake(btnShopingCar.right + 10, btnShopingCar.top, btnShopingCar.width * 2, 45)];
    btnAddCar.layer.cornerRadius = 5;
    [btnAddCar setBackgroundColor:RGBCOLOR(254, 0, 90)];
    [btnAddCar setTitle:@"加入购物车" forState: UIControlStateNormal];
    [btnAddCar addTarget:self action:@selector(addToCart:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btnAddCar];
    if ([proDetail.currentStock intValue]<=0)
    {
        btnAddCar.backgroundColor=RGBCOLOR(143, 136, 136);
        btnAddCar.userInteractionEnabled=NO;
    }
    
    _lableCarCount = [[UILabel alloc] initWithFrame:CGRectMake(btnShopingCar.width / 2 + 5, btnShopingCar.height / 2 - 12, 15, 10)];
    _lableCarCount.backgroundColor = RGBCOLOR(245, 43, 105);
    _lableCarCount.font = [UIFont systemFontOfSize:8];
    _lableCarCount.textAlignment = NSTextAlignmentCenter;
    _lableCarCount.textColor = [UIColor whiteColor];
    _lableCarCount.layer.masksToBounds = YES;
    _lableCarCount.layer.cornerRadius = 5;
    NSInteger count = [self calculateShoppingCartProNum];
    _lableCarCount.hidden = count > 0 ? NO : YES;
    _lableCarCount.text = [NSString stringWithFormat:@"%ld", (long)count];
    [btnShopingCar addSubview:_lableCarCount];
}
//  收藏商品
-(void)collectshop
{
    if (!_user.userId) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"未登录" message:@"请您先登录！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
        [alert show];
        alert.delegate = self;
        return;
    }
    
    if (isHaveCollect==YES)
    {
        _tableView.collectImage.image=[UIImage imageNamed:@"collect"];
        isHaveCollect=NO;
        [self cancelCollectShopWithUserid:_user.userId proid:_product.productId type:@"1"];
    }
    else
    {
        _tableView.collectImage.image=[UIImage imageNamed:@"collected"];
        isHaveCollect=YES;
        [self addCollectShopWithUserid:_user.userId proid:_product.productId type:@"1"];
        
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (_curSelectedAddProIndex >= 0) {
        __weak typeof(self) safeSelf = self;
        [self addProToShoppingCarWithProId:_product.productId userId:_user.userId proNum:@"1" success:^{
            [[ZMShoppingCart shoppingCartInstance] refreshShoppingCartWithUserId:safeSelf.user.userId success:^{
                NSInteger count = [safeSelf calculateShoppingCartProNum];
                safeSelf.lableCarCount.hidden = count > 0 ? NO : YES;
                safeSelf.lableCarCount.text = [NSString stringWithFormat:@"%ld", (long)count];
                safeSelf.curSelectedAddProIndex = -1;
            }];
        }];
    }
}

/**
 *  加入购物车按钮点击事件
 *
 *  @param button
 */
- (void) addToCart:(UIButton *)button{
    _curSelectedAddProIndex = [_product.productId integerValue];
    if (!_user.userId) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"未登录" message:@"请您先登录！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
        [alert show];
        alert.delegate = self;
        return;
    }
    
    __weak typeof (self) safeSelf = self;
    [self addProToShoppingCarWithProId:proDetail.proDetailId userId:_user.userId proNum:@"1" success:^{
        [[ZMShoppingCart shoppingCartInstance] refreshShoppingCartWithUserId:safeSelf.user.userId success:^{
            //            __strong typeof (self) strongSelf = weakSelf;
            NSInteger count = [safeSelf calculateShoppingCartProNum];
            safeSelf.lableCarCount.hidden = count > 0 ? NO : YES;
            safeSelf.lableCarCount.text = [NSString stringWithFormat:@"%ld", (long)count];
            safeSelf.curSelectedAddProIndex = -1;
        }];
    }];
}

/**
 *  计算购物车内商品总数
 *
 *  @return
 */
- (NSInteger) calculateShoppingCartProNum{
    NSInteger count = 0;
    for (ZMShoppingCartPro *product in [ZMShoppingCart shoppingCartInstance].shoppingCartProList) {
        count = count + [product.quantity integerValue];
    }
    return count;
}

/**
 *  查看购物车按钮点击事件
 *
 *  @param button
 */
- (void) checkShoppingCar:(UIButton *)button {
    WYAShoppingCartViewController *shoppingCartVC = [[WYAShoppingCartViewController alloc] init];
    [self.navigationController pushViewController:shoppingCartVC animated:YES];
}

/**
 *  通过产品Id查询产品明细
 *
 *  @param proId
 */
- (void) requestProDetailById:(NSString *) proId userId: (NSString *)userId{
    
    [SVProgressHUD showWithStatus:@"加载中"];
    
    NSString *url = @"app/product/pro/findProDetail.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:proId forKey:@"proId"];
    if (![userId isEmpty]) {
        [params setValue:userId forKey:@"regUserId"];
    }
    
    nameUserId=userId;
    shopId=proId;
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        [SVProgressHUD dismiss];
    NSLog(@"product detail:%@", responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            proDetail = [ZMProductDetail productDetailWithDictionary:responseObject[@"result"]];
            isFav=[NSString stringWithFormat:@"%@",responseObject[@"result"][@"isFav"]] ;
            
            [self initView];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:responseObject[@"result"]];
        }
    } failure:^(NSError *error) {
        //        NSLog(@"error : %@", [error localizedDescription]);
    }];
}

/**
 *  加载填充数据
 */
- (void) loadData{
    _baseRequest = [BaseRequest sharedInstance];
    
    // 请求商品详细信息
    
    if ([self.idString isEqualToString:@"1"])
    {
        //直接展示商品详情
        
        [self requestChannelDetailByChannelItemId:_cItemIdStr];
        
        
    }
    else if ([self.idString isEqualToString:@"2"])
    {
        //商品佣金排行榜的商品详情
        shopProID=_product.proId;
        self.navigationItem.title = _product.proName;
        [self requestProDetailById:_product.proId userId:_user.userId];
        
        
    }
    else if ([self.idString isEqualToString:@"3"])
    {
        //我的搜藏与
        shopProID=_channelItem.proId;
        [self requestProDetailById:_channelItem.proId userId:_user.userId];
        
        
        self.navigationItem.title = _channelItem.proName;
        
    }
    else if ([self.idString isEqualToString:@"4"])
    {
        shopProID=_channelItem.proId ;
        self.navigationItem.title = _channelItem.proName;
        [self requestProDetailById:_channelItem.proId userId:_user.userId];
        
        
        
        
    }
    else
    {
        shopProID=_product.productId;
        [self requestProDetailById:_product.productId userId:_user.userId];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *   收藏商品
 
 *  @param regUserId=会员ID（可选，登录状态下要传该参数)
 *  @param proId=商品ID
 *  @param type = 收藏类型（1、商品 2、品牌 3、专题推荐）
 *
 */
-(void)addCollectShopWithUserid:(NSString*)userid proid:(NSString*)productId type:(NSString*)type
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (nameUserId)
    {
        [params setValue:nameUserId forKey:@"regUserId"];
    }
    [params setValue:shopId forKey:@"busId"];
    [params setValue:@"1" forKey:@"type"];
    NSString*url=@"app/crm/favPro/insertFavPro.do";
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        //NSLog(@"---==%@",responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"])
        {
            [SVProgressHUD showSuccessWithStatus:responseObject[@"result"]];
            
        } else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"result"]];
        }
        //        NSLog(@"Add to cart result: %@", responseObject);
    } failure:^(NSError *error) {
        //        NSLog(@"error:%@", [error localizedDescription]);
    }];
    
    
}
/**
 *   取消收藏商品
 
 *  @param regUserId=会员ID（可选，登录状态下要传该参数)
 *  @param proId=商品ID
 *  @param type = 收藏类型（1、商品 2、品牌 3、专题推荐）
 *
 */
-(void)cancelCollectShopWithUserid:(NSString*)userid proid:(NSString*)productId type:(NSString*)type
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (nameUserId)
    {
        [params setValue:nameUserId forKey:@"regUserId"];
    }
    [params setValue:shopId forKey:@"busId"];
    
    NSString*url=@"app/crm/favPro/cancelFavProByBusId.do";
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
       // NSLog(@"---==%@",responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"])
        {
            [SVProgressHUD showSuccessWithStatus:responseObject[@"result"]];
            
        } else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"result"]];
        }
        //        NSLog(@"Add to cart result: %@", responseObject);
    } failure:^(NSError *error) {
        //        NSLog(@"error:%@", [error localizedDescription]);
    }];
    
}
/**
 *   记录收藏商品数
 
 *  @param regUserId=会员ID（可选，登录状态下要传该参数)
 *  @param busid=商品ID
 *  @param type = 收藏类型  2
 *
 */
-(void)recordCollectShopWithUserid:(NSString*)userid proid:(NSString*)productId type:(NSString*)type
{
    
}
/**
 *  添加商品到购物车
 *
 *  @param productId 商品ID
 *  @param userId    会员ID
 *  @param proNum    添加的商品数量
 */
- (void) addProToShoppingCarWithProId:(NSString *)productId userId:(NSString *)userId proNum:(NSString *)proNum success:(void (^)())success{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:productId forKey:@"proId"];
    [params setValue:userId forKey:@"regUserId"];
    [params setValue:proNum forKey:@"quantity"];
    
    NSString *url = @"app/cart/cartPro/insertCartPro.do";
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            //            [SVProgressHUD showSuccessWithStatus:responseObject[@"result"]];
            success();
        } else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"result"]];
        }
        //       NSLog(@"Add to cart result: %@", responseObject);
    } failure:^(NSError *error) {
        //        NSLog(@"error:%@", [error localizedDescription]);
    }];
}
//查询购物车中商品的数量
-(void)chatShopNum
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setValue:_user.userId forKey:@"regUserId"];
    
    NSString *url = @"app/cart/cartPro/findCartProNum.do";
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
       // NSLog(@"---==%@",responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"])
        {
            NSString*shopCount=responseObject[@"result"][@"cartProNum"];
            self.lableCarCount.text = shopCount;
            if ([shopCount intValue]<=0)
            {
                self.lableCarCount.hidden=YES;
            }
            
            
        } else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"result"]];
        }
        //        NSLog(@"Add to cart result: %@", responseObject);
    } failure:^(NSError *error) {
        //        NSLog(@"error:%@", [error localizedDescription]);
    }];
}
/**
 *  UIAlertView的delegate
 *
 *  @param alertView   <#alertView description#>
 *  @param buttonIndex <#buttonIndex description#>
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //    NSLog(@"index:%ld", (long)buttonIndex);
    if (buttonIndex == 0) { // 取消
        _curSelectedAddProIndex = -1;
    } else if(buttonIndex == 1) { // 登录
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.isThird = YES;
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

- (UIImage *)getProImage{
    
    return [_tableView getTableHeaderImage];
}

- (void)shareAction
{
    if (!_user.userId) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"未登录" message:@"请您先登录！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
        [alert show];
        alert.delegate = self;
        return;
    }else{
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setValue:shopProID forKey:@"proId"];
        
        
        [params setValue:_user.userId forKey:@"regUserId"];
        NSString *url = @"app/product/pro/findShareProInfo.do";
        [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
            
            if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
                
                //                NSLog(@"data= %@",responseObject);
                
                [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:proDetail.httpImgUrl];
                [UMSocialSnsService presentSnsIconSheetView:self
                                                     appKey:UMAPPKEY
                                                  shareText:responseObject[@"result"][@"desc"]
                                                 shareImage:nil
                                            shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline]
                                                   delegate:self];
                
                [UMSocialData defaultData].extConfig.wechatSessionData.url = responseObject[@"result"][@"webpageUrl"];
                [UMSocialData defaultData].extConfig.wechatTimelineData.url = responseObject[@"result"][@"webpageUrl"];
                [UMSocialData defaultData].extConfig.wechatSessionData.title = responseObject[@"result"][@"title"];
                [UMSocialData defaultData].extConfig.wechatTimelineData.title = responseObject[@"result"][@"title"];
                
                [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
                
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }];
    }
}
- (void) requestChannelDetailByChannelItemId:(NSString *) cItemId{
   // NSString *url = @"app/crm/channel/v1.2.0/findCtxByCiId.do";
    NSString*url=[NSString stringWithFormat:@"app/crm/channel/%@/findCtxByCiId.do",ppVersion];

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:cItemId forKey:@"cItemId"];
    
    if (![_user.userId isEmpty]) {
        [params setValue:_user.userId forKey:@"regUserId"];
    }
    
    nameUserId=_user.userId;
    
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        [SVProgressHUD dismiss];
       // NSLog(@"product detail:%@", responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            proDetail = [ZMProductDetail productDetailWithDictionary:responseObject[@"result"]];
            isFav=[NSString stringWithFormat:@"%@",responseObject[@"result"][@"isFav"]] ;
            shopProID=responseObject[@"result"][@"id"];
            shopId=responseObject[@"result"][@"id"];
            self.navigationItem.title=responseObject[@"result"][@"bandName"];
            [self initView];
        }
    } failure:^(NSError *error) {
        //        NSLog(@"error : %@", [error localizedDescription]);
    }];
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        [SVProgressHUD showSuccessWithStatus:@"分享成功"];
    }
}

@end
