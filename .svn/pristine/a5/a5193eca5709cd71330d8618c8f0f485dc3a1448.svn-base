//
//  WYAAddressManageViewController.m
//  WY4iPhone
//
//  Created by zhuwei on 15/9/13.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "WYAAddressManageViewController.h"
#import "WYAOrderConfirmViewController.h"
@interface WYAAddressManageViewController (){
    BaseRequest *baseReqest;
    ZMUser *user;
}

@end

@implementation WYAAddressManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"地址管理";
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    baseReqest = [BaseRequest sharedInstance];
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    user=[ZMUser userWithDict:userDic];
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
/**
 *  初始化UI界面
 */
- (void) initView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 100 - self.navigationController.navigationBar.bottom) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorColor = RGBCOLOR(240, 240, 240);
    tableView.estimatedRowHeight = 50;
    [tableView registerClass:[WYAAddressListCell class] forCellReuseIdentifier:@"cell"];
    self.tableView = tableView;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.view addSubview:self.tableView];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    UIButton *addAddressButton = [[UIButton alloc] initWithFrame:CGRectMake(20, self.view.height - 90 - self.navigationController.navigationBar.bottom, self.view.width - 20 * 2, 50)];
    addAddressButton.backgroundColor = RGBCOLOR(255, 0, 90);
    addAddressButton.layer.cornerRadius = 5.f;
    [addAddressButton setTitle:@"新建地址" forState:UIControlStateNormal];
    [addAddressButton addTarget:self action:@selector(addAddressButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addAddressButton];
    
    self.tableView = tableView;
    self.addAddressButton = addAddressButton;
}

/**
 *  加载数据
 */
- (void) loadData{
    [self requestAddressListByUserID:user.userId];
}

/**
 *  查询会员的收货地址列表
 *
 *  @param userId 会员ID
 */
- (void) requestAddressListByUserID:(NSString *)userId{
    NSString *url = @"app/crm/addr/findAddrList.do";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:userId forKey:@"regUserId"];
    
    [baseReqest request:url parameters:params success:^(id responseObject) {
        if ([responseObject[@"statu"] isEqualToString:@"false"]) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"result"]];
            return ;
        }
        if (responseObject[@"result"]==nil)
        {
            return;
        }
        [_tableView.header endRefreshing];
       // NSLog(@"address:%@", responseObject[@"result"]);
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in responseObject[@"result"]) {
            ZMAddress *address = [ZMAddress addressWithDictionary:dict];
            [array addObject:address];
        }
        _addressList = array;
       // NSLog(@"==地址%@",_addressList);
        [_tableView reloadData];
        [self defaultSelected];
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)viewDidLayoutSubviews
{

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self loadData];
    
    
}

/**
 *  默认选中
 */
- (void) defaultSelected{
    NSIndexPath *indexPath;
    NSInteger section = (NSInteger)[[NSUserDefaults standardUserDefaults] integerForKey:@"section"];
    NSInteger row = (NSInteger)[[NSUserDefaults standardUserDefaults] integerForKey:@"row"];
    _curSelectedIndex = [NSIndexPath indexPathForRow:row inSection:section];;
    if (_curSelectedIndex == nil) {
        indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        _curSelectedIndex = indexPath;
    }
    WYAAddressListCell *cell = (WYAAddressListCell *)[_tableView cellForRowAtIndexPath:_curSelectedIndex];
    [cell setSelected:YES];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setInteger:_curSelectedIndex.section forKey:@"section"];
    [userDefault setInteger:_curSelectedIndex.row forKey:@"row"];
    
}

#pragma mark - UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath != _curSelectedIndex) {
        WYAAddressListCell *cell = (WYAAddressListCell *)[_tableView cellForRowAtIndexPath:indexPath];
        WYAAddressListCell *preCell = (WYAAddressListCell *)[_tableView cellForRowAtIndexPath:_curSelectedIndex];
        [preCell setSelected:NO];
        [cell setSelected:YES];
    }
     _curSelectedIndex = indexPath;
    ZMAddress *address = _addressList[indexPath.row];
    self.orderVC.address=address;
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _addressList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZMAddress *address = _addressList[indexPath.row];
    static NSString *identified = @"addressCell";
    WYAAddressListCell *cell = [tableView dequeueReusableCellWithIdentifier:identified];
    if (!cell) {
        cell = [[WYAAddressListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identified];
    }
    cell.nameTitle.text = address.consignee;
    cell.phoneTitle.text = address.telNo;
    cell.generalTitle.text = [NSString stringWithFormat:@"%@ - %@ - %@", address.addrProvince, address.addrCity, address.addrArea];
    cell.detailTitle.text = address.addr;
    return cell;
}

#pragma mark - Custom Method
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Getter Method
- (NSDictionary *)viewDicts
{
    if (!_viewDicts) {
        _viewDicts = @{
                       @"topLayoutGuide" : self.topLayoutGuide,
                       @"bottomLayoutGuide" : self.bottomLayoutGuide,
                       @"tableView" : self.tableView,
                       @"addAddressButton" : self.addAddressButton,
                       };
    }
    return _viewDicts;
}

/**
 *  添加新地址按钮点击事件
 *
 *  @param button
 */
- (void) addAddressButtonClicked:(UIButton *)button{
    ZMAddAddressViewController *addAddressVC = [[ZMAddAddressViewController  alloc] init];
    [self.navigationController pushViewController:addAddressVC animated:YES];
}

@end
