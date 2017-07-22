//
//  WYAShoppingCartViewController.m
//  WY4iPhone
//
//  Created by mx on 15/8/31.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "WYAShoppingCartViewController.h"
#import "WYAOrderConfirmViewController.h"
#import "ZMShoppingCart.h"
#import "ZMShoppingCartPro.h"
#import "ZMUser.h"
#import "UIImageView+WebCache.h"
#import "BaseRequest.h"
#import "MJRefresh.h"
#import "LoginViewController.h"
#import "ZMShortConfirmViewController.h"
#define kLoginUrl       @"app/crm/reguser/login.do"

@interface WYAShoppingCartViewController ()<UITableViewDelegate, UITableViewDataSource>{
    ZMUser *user;
    // 记录购物车中勾选的商品
    NSMutableArray *selectedPro;
    BOOL selectedAll;;
    BaseRequest *baseRequest;
    
    // 提示购物车为空
    UILabel *tipsEmpty;
    // 登录按钮
    UIButton *btnLogin;
    UILabel *label;
    
    // 记录选择状态
    //    NSMutableArray *isSelectedArray;
    // 总金额
    float amount;
    // 运费
    float expCharge;
    // 商品总价
    float proAmount;
    NSInteger toutal;
    UIButton *checkoutButton;
    NSString*amountStr;
    NSInteger btnClicktag;
    NSString*titleString;
    CGFloat labHight;
    UIButton*backBtn;
    ZMUser*zmUser;
}

@property (nonatomic, strong) UILabel *topTitle;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *allSelectButton;
@property (nonatomic, strong) UILabel *totalPriceTitle;
@property (nonatomic, strong) UILabel *totalNumberTitle;

@property (nonatomic, strong) NSDictionary *viewDicts;

@end

@implementation WYAShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(245, 50, 109);
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationItem.title = @"购物车";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    baseRequest = [BaseRequest sharedInstance];
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    user=[ZMUser userWithDict:userDic];
    [self initView];
    [self tableHeadView];
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"PageOne"];
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    user=[ZMUser userWithDict:userDic];
    if (!user.userId)
    {
        tipsEmpty.hidden = NO;
        backBtn.hidden=NO;
        _tableView.hidden = YES;
        _bottomView.hidden = YES;
         tipsEmpty.text = @"你还没有登陆!";
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"PageOne"];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self findCartProList:user.userId];
}

/**
 *  初始化UI界面
 */
- (void) initView{
    
    CGFloat bottomViewH = 48;
    
    //画表格
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - bottomViewH - self.tabBarController.tabBar.height - self.navigationController.navigationBar.bottom) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 50.f;
    [tableView registerClass:[WYAShoppingCartListCell class] forCellReuseIdentifier:@"cell"];
    tableView.backgroundColor = [UIColor clearColor];
    _tableView = tableView;
    [self.view addSubview:_tableView];
    
    
    CGFloat bottomViewY = self.view.height - bottomViewH - self.tabBarController.tabBar.height - self.navigationController.navigationBar.bottom;
    if (self.tabBarController.tabBar.hidden) {
        bottomViewY = self.view.height - bottomViewH - self.navigationController.navigationBar.bottom;
        _tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height - bottomViewH - 64);
    }
    
    //购物车底部
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, bottomViewY, self.view.width, bottomViewH)];
    {
        [self.view addSubview:bottomView];
        // 点击按钮
        UIButton *allSelectButton = [[UIButton alloc] initWithFrame:CGRectMake(0, (bottomViewH - 20) / 2, 60, 20)];
        [allSelectButton setImage:[UIImage imageNamed:@"emptyRing"] forState:UIControlStateNormal];
        [allSelectButton setImage:[UIImage imageNamed:@"hookRing"] forState:UIControlStateSelected];
        [allSelectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [allSelectButton setTitle:@"全选" forState:UIControlStateNormal];
        allSelectButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [allSelectButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [allSelectButton addTarget:self action:@selector(allSelectButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:allSelectButton];
        
        UILabel *totalPriceTitle = [[UILabel alloc] initWithFrame:CGRectMake(allSelectButton.right + 10, 5, self.view.width - self.view.width / 3 - 60, 15)];
        totalPriceTitle.font = [UIFont systemFontOfSize:15];
        totalPriceTitle.textColor = RGBCOLOR(53, 53, 53);
        [bottomView addSubview:totalPriceTitle];
        
        UILabel *totalNumberTitle = [[UILabel alloc] initWithFrame:CGRectMake(totalPriceTitle.left, totalPriceTitle.bottom + 5, totalPriceTitle.width, totalPriceTitle.height)];
        totalNumberTitle.font = [UIFont systemFontOfSize:15];
        totalNumberTitle.textColor = RGBCOLOR(53, 53, 53);
        [bottomView addSubview:totalNumberTitle];
        
        CGFloat checkoutBtnW = self.view.width / 3;
        checkoutButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width - checkoutBtnW, 0, checkoutBtnW, bottomViewH)];
        
        checkoutButton.backgroundColor = RGBCOLOR(245, 43, 105);
        [checkoutButton setTitle:@"去结算" forState:UIControlStateNormal];
        [checkoutButton addTarget:self action:@selector(goToPay) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:checkoutButton];
        
        self.allSelectButton = allSelectButton;
        self.totalPriceTitle = totalPriceTitle;
        self.totalNumberTitle = totalNumberTitle;
    }
    self.tableView = tableView;
    self.bottomView = bottomView;
    
    tipsEmpty = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - self.navigationController.navigationBar.bottom - self.tabBarController.tabBar.height)];
    tipsEmpty.textAlignment = NSTextAlignmentCenter;
    tipsEmpty.text = @"您的购物车空空如也，快去装满它吧!";
    tipsEmpty.textColor = RGBCOLOR(102, 102, 102);
    [self.view addSubview:tipsEmpty];
    backBtn=[UIButton new];
    backBtn.frame=CGRectMake(APP_SCREEN_WIDTH/2-60, APP_SCREEN_HEIGHT/2-15, 120, 44);
    [backBtn setTitle:@"去逛逛" forState:UIControlStateNormal];
    [backBtn setTitleColor:RGBCOLOR(102, 102, 102) forState:UIControlStateNormal];
    //backBtn.backgroundColor=[UIColor redColor];
    backBtn.layer.borderColor = [UIColor redColor].CGColor;
    backBtn.layer.borderWidth = 1;
    backBtn.layer.cornerRadius=5;
    [backBtn addTarget:self action:@selector(backtofirstVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    tipsEmpty.hidden = YES;
    backBtn.hidden=YES;
    self.tableView.hidden = YES;
    self.bottomView.hidden = YES;
    
    //下拉刷新
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
}
-(void)backtofirstVC
{
    [self.tabBarController setSelectedIndex:0];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
/**
 * 查询购物车商品
 */
- (void) findCartProList:(NSString *)userId{
    [[ZMShoppingCart shoppingCartInstance] refreshShoppingCartWithUserId:user.userId success:^{
        [_tableView.header endRefreshing];
        [self refreshCartView];
        [_tableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ZMShoppingCart shoppingCartInstance].shoppingCartProList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZMShoppingCartPro * shoppingPro = [ZMShoppingCart shoppingCartInstance].shoppingCartProList[indexPath.row];
    static NSString *identified = @"shoppingCartCell";
    
    WYAShoppingCartListCell *cell = [tableView dequeueReusableCellWithIdentifier:identified];
    if (!cell) {
        cell = [[WYAShoppingCartListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identified];
    }
    cell.delegate = self;
    [cell.goodsImageView sd_setImageWithURL:[NSURL URLWithString:shoppingPro.httpImgUrl]];
    cell.goodsTitle.text = shoppingPro.proName;
    cell.countTextField.text = shoppingPro.quantity;
    cell.priceTitle.text = [NSString stringWithFormat:@"￥%@", shoppingPro.price];
    cell.addButton.tag = indexPath.row;
    cell.cutButton.tag = indexPath.row;
    
    cell.deleteButton.tag = indexPath.row;
    [cell layoutIfNeeded];
    if (shoppingPro.isSelected) {
        cell.indicatorImageView.image = [UIImage imageNamed:@"hookRing"];
    } else {
        cell.indicatorImageView.image = [UIImage imageNamed:@"emptyRing"];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    [self.view endEditing:YES];
    
    //获取单元格
    WYAShoppingCartListCell *cell = (WYAShoppingCartListCell *)[_tableView cellForRowAtIndexPath:indexPath];
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //获取选中的商品
    ZMShoppingCartPro*pro=[ZMShoppingCart shoppingCartInstance].shoppingCartProList[indexPath.row];
    if (pro.isSelected==NO)
    {
        //设置为已选中
        pro.isSelected = YES;
        
        //将图片设置选中状态
        cell.indicatorImageView.image = [UIImage imageNamed:@"hookRing"];
        
        //调用后台接口计算金额
        [self calShopCartAmountAndQuan:user.userId couponItemId:@"0"];
        
    } else {
        
        cell.indicatorImageView.image = [UIImage imageNamed:@"emptyRing"];
        pro.isSelected = NO;
        
        //调用后台接口计算金额
        [self calShopCartAmountAndQuan:user.userId couponItemId:@"0"];
    }
  
}

#pragma mark - Custom Method  计算总价

- (void)allSelectButtonClicked
{
    //获取索引
    NSMutableArray *all = [NSMutableArray array];
    for (int section = 0; section < [self.tableView numberOfSections]; section ++) {
        for (int row = 0; row < [self.tableView numberOfRowsInSection:section]; row ++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            [all addObject:indexPath];
        }
    }
    
    
    if (selectedAll) {
        for (NSIndexPath *indexPath in all) {
            WYAShoppingCartListCell *cell = (WYAShoppingCartListCell *)[_tableView cellForRowAtIndexPath:indexPath];
            cell.indicatorImageView.image = [UIImage imageNamed:@"emptyRing"];
            ((ZMShoppingCartPro *)([ZMShoppingCart shoppingCartInstance].shoppingCartProList[indexPath.row])).isSelected = NO;
        }
        
        [self calShopCartAmountAndQuan:user.userId couponItemId:@"0"];
    }else{
        for (NSIndexPath *indexPath in all) {
            WYAShoppingCartListCell *cell = (WYAShoppingCartListCell *)[_tableView cellForRowAtIndexPath:indexPath];
            cell.indicatorImageView.image = [UIImage imageNamed:@"hookRing"];
            
            ((ZMShoppingCartPro *)([ZMShoppingCart shoppingCartInstance].shoppingCartProList[indexPath.row])).isSelected = YES;
        }
        [self calShopCartAmountAndQuan:user.userId couponItemId:@"0"];
    }
}

/**
 * 刷新购物车界面
 */
-(void)loadData
{
    [self refreshCartView];
    [_tableView.header endRefreshing];
    
}
- (void) refreshCartView{
    //设置购物车组件展示
    [self showOrHideCartView];
    
    //计算购物车中商品数量及总价格
    [self calShopCartAmountAndQuan:user.userId couponItemId:@"0"];
}

/**
 * 设置购物车组件展示
 */
- (void) showOrHideCartView{
    if ([ZMShoppingCart shoppingCartInstance].shoppingCartProList.count < 1||[ZMShoppingCart shoppingCartInstance].shoppingCartProList==nil) {
        tipsEmpty.hidden = NO;
        backBtn.hidden=NO;
        _tableView.hidden = YES;
        _bottomView.hidden = YES;
    } else {
        _tableView.hidden = NO;
        _bottomView.hidden = NO;
        tipsEmpty.hidden = YES;
        backBtn.hidden=YES;
        [self tableHeadView];
        [self chatShopTitle];
    }
}

/**
 * 计算购物车中的商品数量及总价格
 */
- (void) calShopCartAmountAndQuan:(NSString *)userId couponItemId:(NSString *)couponItemId {
    NSString *url = @"app/cart/cartPro/1.3.0/calCartProAmount.do";
    
    //获取已选中的商品
    int totalNum = 0;
    NSMutableArray *shoppingCartPros = [NSMutableArray array];
    NSArray*arr=[ZMShoppingCart shoppingCartInstance].shoppingCartProList;
    for (ZMShoppingCartPro *pro in arr) {
        if(pro.isSelected)
        {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setValue:pro.proId forKey:@"proId"];
            [dict setValue:pro.shoppingCartProId forKey:@"id"];
            [dict setValue:pro.quantity forKey:@"quantity"];
            [shoppingCartPros addObject:dict];
            
            totalNum += [pro.quantity intValue];
        }
    }
    _totalNumberTitle.attributedText = [self parserString:@"共" withContentStr:[NSString stringWithFormat:@"%d", totalNum] endString:@"件"];
    //设置全选按钮
    if (shoppingCartPros.count == [ZMShoppingCart shoppingCartInstance].shoppingCartProList.count) {
        selectedAll = YES;
        _allSelectButton.selected = YES;
    } else {
        selectedAll = NO;
        _allSelectButton.selected = NO;
    }
    
    //如果购物车中商品没有选中的则直接显示总价格为0.00
    if (shoppingCartPros.count<1) {
        _totalPriceTitle.attributedText = [self parserString:@"总价：" withContentStr:[NSString stringWithFormat:@"￥%.2f", 0.00] endString:@""];
    }else{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        [params setObject:shoppingCartPros forKey:@"cartProList"];
        
        [baseRequest orderRequest:url parameters:params success:^(id responseObject) {
            //NSLog(@"order result:%@", responseObject[@"result"]);
            if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
                NSDictionary *result = responseObject[@"result"];
                proAmount = [result[@"proAmont"] floatValue];
                _totalPriceTitle.attributedText = [self parserString:@"总价：" withContentStr:[NSString stringWithFormat:@"￥%.2f", proAmount] endString:@""];
            }
        } failure:^(NSError *error) {
            
        }];
    }
}

/**
 * 去结算
 */
- (void)goToPay
{   //查询会员信息
  
    checkoutButton.backgroundColor = RGBCOLOR(245, 43, 105);
    checkoutButton.userInteractionEnabled=YES;
    
    NSString *cachePath = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithContentsOfFile:cachePath];
    
    zmUser =  [[ZMUser userInstance] initWithDict:dict];
    NSArray*arr=[ZMShoppingCart shoppingCartInstance].shoppingCartProList;
    
    //获取选中的商品
    NSMutableArray *buyProList = [NSMutableArray array];
    for (ZMShoppingCartPro *pro in arr) {
        if(pro.isSelected)
        {
            [buyProList addObject:pro];
        }
    }
    
    //判断是否选中商品
    if (buyProList.count<=0)
    {
        [SVProgressHUD showInfoWithStatus:@"请选择要购买的商品！"];
        return;
    }
    
    WYAOrderConfirmViewController *orderConfirmVC = [WYAOrderConfirmViewController new];
    orderConfirmVC.hidesBottomBarWhenPushed = YES;
    orderConfirmVC.buyProductList = buyProList;
    orderConfirmVC.zmUser=zmUser;
    [self.navigationController pushViewController:orderConfirmVC animated:YES];
    
    
}

#pragma mark - WYAShoppingCartCellDelegate
- (void)updateProdouctCountButton:(UIButton *)button textField:(UITextField *)textField newCount:(NSString *)newCount{
    NSString *url = @"app/cart/cartPro/updateCartProQuantity.do";
    
    //获取商品
    
    ZMShoppingCartPro *pro = [ZMShoppingCart shoppingCartInstance].shoppingCartProList[button.tag];
    
    //定义请求参数
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:user.userId forKey:@"regUserId"];
    [params setValue:newCount forKey:@"quantity"];
    [params setValue:pro.shoppingCartProId forKey:@"cartProId"];
    
    //发送请求
    [baseRequest request:url parameters:params success:^(id responseObject) {
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            //设置客户端商品的数量
            pro.quantity = newCount;
            
            //修改被选中的商品数量
            textField.text=newCount;
            //更新总价格和总数量
            [self calShopCartAmountAndQuan:user.userId couponItemId:@"0"];
        }
        else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"result"]];
        }
    } failure:^(NSError *error) {
        
    }];
}

// 删除购物车商品
- (void)removeProWithDeleteButton:(UIButton *)button
{
    UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否删除" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
    [alertView show];
    btnClicktag=button.tag;
    alertView.delegate=self;
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        //获取删除的商品
        ZMShoppingCartPro *pro = [ZMShoppingCart shoppingCartInstance].shoppingCartProList[btnClicktag];
        
        //请求删除商品
        [[ZMShoppingCart shoppingCartInstance] deleteProductWithProId:pro.proId userId:user.userId success:^{
            
            [_tableView.header endRefreshing];
            
            //删除成功后从ZMShoppingCart中移去被删除的商品
            [[ZMShoppingCart shoppingCartInstance].shoppingCartProList removeObject:pro];
            
            //刷新购物车界面
            [self refreshCartView];
            
            [_tableView reloadData];
        }];
    }
}
//活动的一些内容
- (void) chatShopTitle
{
    NSString *url = @"app/sys/appProp/findAppPropListByType.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@"7" forKey:@"type"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        
        // NSLog(@"channel item:==%@", responseObject);
        
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"])
        {
            titleString=responseObject[@"result"][@"cartPro"];
            
            _tableView.tableHeaderView=[self tableHeadView];
            [_tableView reloadData];
        }
        else
        {
            //[SVProgressHUD showErrorWithStatus:@"失败"];
        }
    } failure:^(NSError *error) {
        // NSLog(@"error:%@", [error localizedDescription]);
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
                       value:RGBCOLOR(255, 0, 90)
                       range:NSMakeRange(preStr.length, str.length)];
    return attrString;
}
- (UIView *) tableHeadView
{
    UIView*view;
    view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 40)];
    label=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, APP_SCREEN_WIDTH-10, 40)];
    label.numberOfLines=0;
    //label.backgroundColor = RGBCOLOR(240, 240, 240);
    label.textColor = [UIColor grayColor];
    
    NSLog(@"%@",label.text);
    labHight =[titleString commonStringHeighforLabelWidth:APP_SCREEN_WIDTH-20 withFontSize:14];
    label.frame=CGRectMake(10, 0, APP_SCREEN_WIDTH-20, labHight);
    //label.lineBreakMode = UILineBreakModeWordWrap;
    label.text=titleString;
    label.font=[UIFont systemFontOfSize:14];
    [view addSubview:label];
    view.frame=CGRectMake(0, 0, APP_SCREEN_WIDTH, label.size.height);
    return view;
}
//获取用户的信息
- (void)confirmButtonClick
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSString *cachePath = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath];
    checkoutButton.backgroundColor=[UIColor grayColor];
    checkoutButton.userInteractionEnabled=NO;
    [dict setValue:[userDic objectForKey:@"telNo"] forKey:@"telNo"];
    [dict setValue:[userDic objectForKey:@"password"]forKey:@"password"];
    [[BaseRequest sharedInstance] request:kLoginUrl parameters:dict success:^(id responseObject) {
        // NSLog(@"--会员信息%@",responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            
            checkoutButton.backgroundColor = RGBCOLOR(245, 43, 105);
            checkoutButton.userInteractionEnabled=YES;
            NSMutableDictionary *result = responseObject[@"result"];
            zmUser=[ZMUser userWithDict:result];
            NSArray*arr=[ZMShoppingCart shoppingCartInstance].shoppingCartProList;
            
            //获取选中的商品
            NSMutableArray *buyProList = [NSMutableArray array];
            for (ZMShoppingCartPro *pro in arr) {
                if(pro.isSelected)
                {
                    [buyProList addObject:pro];
                }
            }
            
            //判断是否选中商品
            if (buyProList.count<=0)
            {
                [SVProgressHUD showInfoWithStatus:@"请选择要购买的商品！"];
                return;
            }
            
            WYAOrderConfirmViewController *orderConfirmVC = [WYAOrderConfirmViewController new];
            orderConfirmVC.hidesBottomBarWhenPushed = YES;
            orderConfirmVC.buyProductList = buyProList;
            orderConfirmVC.zmUser=zmUser;
            [self.navigationController pushViewController:orderConfirmVC animated:YES];
            
            
        } else {
            checkoutButton.backgroundColor = RGBCOLOR(245, 43, 105);
            checkoutButton.userInteractionEnabled=YES;
        }
    } failure:^(NSError *error) {
        //[SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", [error localizedDescription]]];
    }];
    
    
}

@end
