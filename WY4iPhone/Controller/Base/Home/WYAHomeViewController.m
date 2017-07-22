//
//  WYAHomeViewController.m
//  WY4iPhone
//
//  Created by mx on 15/8/31.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "WYAHomeViewController.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "ZMchannelOneShopViewController.h"
#import "BandListViewController.h"
#import "SpeRecListViewController.h"
#import "ProDetailViewController.h"
#import "ProCommTopListViewController.h"
#import "ZMBrandDetailsViewController.h"
#import "MJTestViewController.h"
#import "MJExample.h"
#define imageWidth      self.frame.size.width
#define imageHeight     self.frame.size.height
#define findChannelInfoUrl        @"app/crm/channel/findChannelItemList.do"

@interface WYAHomeViewController () < UIAlertViewDelegate,WYTableViewCell05Delegate>{
    ZMUser *user;
    NSArray *datas;
    // banner
    NSMutableArray *arrayBanner;
    // 主题场景馆
    NSMutableArray *arrayTheme;
    NSMutableArray *imgUrlThemeArray;
    // 快捷入口
    NSDictionary *resultQuickDict;
    // 专题推荐
    NSMutableArray *arraySpecialRec;
    // 今日推荐
    NSMutableArray *arrayTodayRec;
    
    // 特价商品
    NSArray *arraySpecialProList;
    NSDictionary *arraySpceialProDict;
    
    BaseRequest *baseRequest;
    NSMutableDictionary *params;
    
    NSInteger curSelectedAddProIndex;
    //三入口
    NSArray*threeShopArray;
    NSArray*threePicture;
    //营销入口
    NSArray*buyShopArray;
    NSArray*buyPicture;
    //快捷入口
    NSArray*quickArray;
    NSArray*quickImageArray;
    UIView *logoView;
    NSString*quickStr;
    UIView *headView;
    UIView*quickview;
}

@end

@implementation WYAHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //  设置导航
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(245, 50, 109);
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationItem.title = @"微芽";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    curSelectedAddProIndex = -1;
    
    arrayTheme = [NSMutableArray array];
    arraySpecialRec = [NSMutableArray array];
    arrayTodayRec = [NSMutableArray array];
    arraySpecialProList = [NSMutableArray array];
    //获取当前用户信息(存储在本地缓存中)
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    user=[ZMUser userWithDict:userDic];    //  加载视图
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
/**
 *  初始化UI界面
 */
- (void) initView{
    //  设置让自动布局为no  防止出问题
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //设置不透明
    self.navigationController.navigationBar.translucent = NO;
    
    //设置要展示的表
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - self.tabBarController.tabBar.height - self.navigationController.navigationBar.bottom) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.sectionHeaderHeight = 0;
    _tableView.sectionFooterHeight = 0;
    _tableView.footer.hidden = NO;
    
    
    //刷新的方法
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.view addSubview:_tableView];
    
    //banner 栏布局
    headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 260)];
    headView.backgroundColor = RGBCOLOR(240, 240, 240);
    _loopingView = [[ADFocusImageView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 160)];
    
    _loopingView.fromeString=@"1";
    _loopingView.delegate = self;
    [headView addSubview:_loopingView];
    
    // logo view
    logoView = [[UIView alloc] initWithFrame:CGRectMake(0, _loopingView.bottom, headView.width, 90)];
    logoView.backgroundColor = [UIColor whiteColor];
    logoView.hidden = NO;
    [headView addSubview:logoView];
    
    _tableView.tableHeaderView = headView;
    
    //置顶按钮
    UIButton*btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(APP_SCREEN_WIDTH-60, APP_SCREEN_HEIGHT-200, 40, 40);
      [btn setBackgroundImage:[UIImage imageNamed:@"goup"] forState:UIControlStateNormal];
    [_tableView bringSubviewToFront:btn];
    
    //滚动到顶部
    [btn addTarget:self action:@selector(btnReseful) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

/**
 * 快捷入口布局
 */
-(void)quickShopView
{
    if (quickArray.count>0)
    {
        if ([quickStr isEqualToString:@"1"])
        {
            [logoView removeFromSuperview];
            logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 160, APP_SCREEN_WIDTH, 90)];
            logoView.backgroundColor = [UIColor whiteColor];
            logoView.hidden = NO;
            [headView addSubview:logoView];
        }
        //计算每个快捷入口按钮的宽度
        int tempWidth =APP_SCREEN_WIDTH/quickArray.count;
        
        //遍历快捷入口数据
        for (int i=0; i<quickArray.count; i++)
        {
            
            //获取快捷入口数据
            ChannelItem *cItem = quickArray[i];
            
            //定义view
            quickview=[[UIView alloc]initWithFrame:CGRectMake(i*tempWidth, 0, tempWidth, 90)];
            [logoView addSubview:quickview];
            quickStr=@"1";
            //定义图片
            CGFloat width =(tempWidth-44)/2;
            UIImageView*quickImage=[[UIImageView alloc]initWithFrame:CGRectMake(width, 10, 44, 44)];
            [quickImage sd_setImageWithURL:[NSURL URLWithString:cItem.imgUrl]];
            [quickview addSubview:quickImage];
            
            //定义文字
            UILabel*quickLab=[[UILabel alloc]initWithFrame:CGRectMake(0, quickImage.bottom+10, quickview.width, 15)];
            quickLab.text=cItem.channelItemName;
            quickLab.textColor=RGBCOLOR(102, 102, 102);
            quickLab.font = [UIFont systemFontOfSize:15];
            quickLab.textAlignment = NSTextAlignmentCenter;
            [quickview addSubview:quickLab];
            quickview.userInteractionEnabled = YES;
            quickview.tag=i;
            
            //定义快捷入口手势操作
            UITapGestureRecognizer *singnalTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quickimgBtnClicked:)];
            [quickview addGestureRecognizer:singnalTap1];
        }
    }
}

//当点的时候页面回到顶部
-(void)btnReseful
{
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}

//init－初始化程序viewDidLoad－加载视图viewWillAppear－UIViewController对象的视图即将加入窗口时调用；viewDidApper－UIViewController对象的视图已经加入到窗口时调用；viewWillDisappear－UIViewController对象的视图即将消失、被覆盖或是隐藏时调用；viewDidDisappear－UIViewController对象的视图已经消失、被覆盖或是隐藏时调用；didReceiveMemoryWarning - 内存不足时候调用这个
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (!user.userId) {
        curSelectedAddProIndex = -1;
        return;
    }
}

/**
 *  加载数据
 */
- (void) loadData{
     //定义频道名称
    datas = @[@{@"title":@"三入口", @"desc":@""},
              @{@"title":@"营销", @"desc":@""},
              @{@"title":@"主题场景馆", @"desc":@""},
              @{@"title":@"专题推荐", @"desc":@""}];
    
    baseRequest = [BaseRequest sharedInstance];
    params = [[NSMutableDictionary alloc] init];
    
    [self findChannelInfo:@"1"];            //banner 栏
    [self findChannelInfo:@"2"];            //主题场景馆
    [self findChannelInfo:@"4"];            //快捷入口
    [self findChannelInfo:@"5"];            //专题推荐
    [self findChannelInfo:@"7"];            //三入口
    [self findChannelInfo:@"8"];            //营销入口
   // [self requestTodayRecList];             //进入推荐
    
    //查询特价商品
    [self requestMoreProListByRegUserId:user.userId bandId:nil catId:nil startPage:nil];
    
}

/**
 *  请求更多数据
 *  hasNext = 1 有下一页 =0 表示没有下一页
 */
- (void) moreSpceialProduct{
    if ([arraySpceialProDict[@"hasNext"] integerValue] == 1) {// 有下一页
        [self requestMoreProListByRegUserId:user.userId bandId:nil catId:nil startPage:arraySpceialProDict[@"nextPage"]];
    } else {
        [_tableView.footer endRefreshing];
        _tableView.footer.hidden = YES;
    }
}

/**
 *  根据频道类型查询该频道下面的频道项
 *
 *  @param requestType 请求的模块Channel
 */
- (void) findChannelInfo:(NSString *)requestType{
    
    if (![requestType isEmpty]) {
        [params removeAllObjects];                              //清空params
        [params setValue:requestType forKey:@"channel"];        //频道类型
        [params setValue:@"ios" forKey:@"mobtype"];             //客户端类型
        
        //发送请求
        [baseRequest request:findChannelInfoUrl parameters:params success:^(id responseObject) {
            //NSLog(@"requestType%@==%@",requestType,responseObject);
            [_tableView.header endRefreshing];
            
            //解析数据
            if([responseObject[@"statu"] isEqualToString:@"true"] && responseObject[@"result"] )
            {
                if ( [responseObject[@"result"] isKindOfClass:[NSDictionary class]])

                {
                    NSDictionary*resDic=responseObject[@"result"];
                    NSArray*arr=[resDic allKeys];
                    if ([arr containsObject:@"result"])
                    {
                        if (responseObject[@"result"][@"result"]==nil)
                        {
                            return ;
                        }
                        //解析数据并转化成数组
                        NSArray *channelArrary = responseObject[@"result"][@"result"];
                        NSInteger type =[requestType intValue];
                        
                        //处理服务端返回的数据并展示
                        [self  processChannelResrequestType:type channelArrary:channelArrary];
                        
                    }
                    
 
                }
                
            }else
            {
                arrayTheme = nil;
                arraySpecialRec = nil;
                threeShopArray=nil;
                buyShopArray=nil;
            }
            
        } failure:^(NSError *error) {
            //            NSLog(@"error: %@", [error localizedDescription]);
            [_tableView.header endRefreshing];
        }];
    }
}

/**
 * 处理频道请求返回结果
 */
-(void) processChannelResrequestType:(NSInteger)requestType channelArrary:(NSArray*)channelArrary
{
    if (channelArrary)
    {
        NSMutableArray *tmpArray = [[NSMutableArray alloc] init];       //临时变量,频道数据数组
        NSMutableArray *imgArray = [[NSMutableArray alloc] init];       //临时变量,图片数组
        
        //获取channelArrary中的数据并存放在tmpArray & imgArray 中
        for (NSDictionary *dict in channelArrary) {
            ChannelItem *channelitem = [ChannelItem bannerWithDictionary:dict];
            [tmpArray addObject:channelitem];
            [imgArray addObject:channelitem.imgUrl];
        }
        
        
        if (requestType == 1)           //Banner
        {
            arrayBanner = tmpArray;
            _loopingView.imageArry = imgArray;
            
        }else if (requestType == 2)     //主题场景馆
        {
            arrayTheme = tmpArray;
            imgUrlThemeArray = imgArray;
            //一个section刷新
            [_tableView reloadData];
        }else if (requestType == 4)     //快捷入口
        {
            quickArray=tmpArray;
            quickImageArray=imgArray;
            [self quickShopView];
            [_tableView reloadData];
            
        }else if (requestType == 5)     //专题推荐
        {
            arraySpecialRec = tmpArray;
            //一个section刷新
            [_tableView reloadData];
        }
        else if (requestType == 7)     // 三入口
        {
            threeShopArray = tmpArray;
            //一个section刷新
            threePicture=imgArray;
            [_tableView reloadData];
        }
        else if (requestType == 8)     // 营销入口
        {
            buyShopArray = tmpArray;
            //一个section刷新
            buyPicture=imgArray;
            [_tableView reloadData];
        }
    }
    
}

/**
 *  查询今日推荐列表
 */
- (void) requestTodayRecList{
    [params removeAllObjects];
    //NSString *urlTodayRec = @"app/crm/channel/v1.2.0/findTodayRecList.do";
    NSString*urlTodayRec=[NSString stringWithFormat:@"app/crm/channel/%@/findTodayRecList.do",ppVersion];

    [baseRequest request:urlTodayRec parameters:params success:^(id responseObject) {
        if ([responseObject[@"statu"] isEqualToString:@"true"] && responseObject[@"result"])
        {
           // NSLog(@"today reccommed：%@", responseObject);
            NSArray *array = responseObject[@"result"];
            
            if (array.count>0) {
                NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
                for (NSDictionary *dict in array) {
                    ZMTodayRecommend *tdRec = [ZMTodayRecommend todayRecommendWithDictionary:dict];
                    [tmpArray addObject:tdRec];
                }
                arrayTodayRec = tmpArray;
            }else
            {
                arrayTodayRec = nil;
            }
            
        }else{
            arrayTodayRec = nil;
        }
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        [_tableView.header endRefreshing];
    }];
}


/**
 *  特价商品信息获取更多,根据条件查询商品列表信息并对商品列表进行排序
 *
 *  @param regUserId 会员id（有id传，无id不传）
 *  @param bandId    品牌ID （可选）
 *  @param catId     分类ID（可选）
 *  @param startPage 页码
 */
- (void) requestMoreProListByRegUserId:(NSString *) regUserId bandId:(NSString *) bandId catId:(NSString *) catId startPage:(NSString *) startPage
{
    //NSString *urlProList = @"app/crm/channel/v1.2.0/findBargainList.do";
    NSString*urlProList=[NSString stringWithFormat:@"app/crm/channel/%@/findBargainList.do",ppVersion];

    //    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (![regUserId isEmpty]) {
        [params setValue:regUserId forKey:@"regUserId"];        //用户id
    }
    if (![bandId isEmpty]) {
        [params setValue:bandId forKey:@"bandId"];              //品牌id
    }
    if (![catId isEmpty]) {
        [params setValue:catId forKey:@"catId"];                //分类id
    }
    if ([startPage integerValue] >= 0) {
        [params setValue:startPage forKey:@"startPage"];        //分页查询起始页
    }
    [params setValue:@"ios" forKey:@"mobtype"];                 // 设备识别号
    
    [baseRequest request:urlProList parameters:params success:^(id responseObject) {
        [_tableView.footer endRefreshing];
       // NSLog(@"特价商品信息:%@", responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"] && responseObject[@"result"] ) {
            
            if ( [responseObject[@"result"] isKindOfClass:[NSDictionary class]])

            {
                NSDictionary*resDic=responseObject[@"result"];
                NSArray*arr=[resDic allKeys];
                if ([arr containsObject:@"result"])
                {
                    if (responseObject[@"result"][@"result"]==nil)
                    {
                        return ;
                    }
                    arraySpceialProDict = responseObject[@"result"];
                    NSArray *array = responseObject[@"result"][@"result"];
                    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
                    for (NSDictionary *dict in array) {
                        ZMProduct *product = [ZMProduct productWithDictionary:dict];
                        [tmpArray addObject:product];
                    }
                    arraySpecialProList=tmpArray;
                    [_tableView reloadData];
                    
                }
                
  
            }
            
        }
    } failure:^(NSError *error) {
        //        NSLog(@"error:%@", [error localizedDescription]);
        [_tableView.header endRefreshing];
    }];
    
}

/**
 *  banner栏点击事件( 代理方法 )
 *
 *  @param itemIndex 被点击的图片下标
 */
- (void)bannerClickDelegate:(NSInteger)itemIndex{
    ChannelItem *cItem = arrayBanner[itemIndex];
    //NSLog(@"--%@",banner.saleType);
    [self doChannelClickAction:cItem];
}

/**
 * 根据频道类型做相应的处理
 */
-(void)doChannelClickAction:(ChannelItem*)cItem
{    //web展示
    if ([cItem.showType integerValue]==2)
    {
        ZMChannelDetailViewController *channelDetailVC = [[ZMChannelDetailViewController alloc] init];
        channelDetailVC.hidesBottomBarWhenPushed = YES;
        channelDetailVC.cItem = cItem;
        //NSLog(@"+++%@==%@",banner.saleType,banner.showType);
        [self.navigationController pushViewController:channelDetailVC animated:YES];
        
    }else if ([cItem.showType integerValue]==1)
    {
        if ([cItem.saleType integerValue]==1)           //商品详情页
        {
            ProDetailViewController* proDetailView=[ProDetailViewController new];
            proDetailView.cItemIdStr=cItem.channelItemId;
            proDetailView.idString=@"1";
            proDetailView.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:proDetailView animated:YES];
        } else if ([cItem.saleType integerValue]==2)   //商品列表
        {
            MJExample *exam = [[MJExample alloc] init];
            exam.methods = @[@"refurbishData"];
            ProListViewController *vc = [[ProListViewController alloc] init];
            vc.cItem=cItem;
            vc.hidesBottomBarWhenPushed=YES;
            [vc setValue:exam.methods[0] forKeyPath:@"method"];
            [self.navigationController pushViewController:vc animated:YES];
        } else if ([cItem.saleType integerValue]==3)   //品牌列表
        {
            BandListViewController*bandList=[BandListViewController new];
            bandList.cItem=cItem;
            bandList.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:bandList animated:YES];
        } else if ([cItem.saleType integerValue]==4)    //专题推荐
        {
            SpeRecListViewController*speRecList=[SpeRecListViewController new];
            speRecList.cItem=cItem;
            speRecList.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:speRecList animated:YES];
        } else if ([cItem.saleType integerValue]==5)     //商品佣金排行榜
        {
            ProCommTopListViewController*proCommList=[ProCommTopListViewController new];
            proCommList.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:proCommList animated:YES];
        }
        
    }
    
}
#pragma mark    UITableView_delegate and datasouce
//  返回一共多少区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return datas.count;
}
//  返回区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return 0;
    }else if (section == 1 && arrayTheme!=nil)
    {
        return 0;
        
    }else if (section == 2 && arrayTheme!=nil)
    {
        return 45;
        
    }else if (section == 3 && arraySpecialRec!=nil)
    {
        return 45;
    }
    else
    {
        return 0;
    }
}
//  返回区脚的高度
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    float result = 10;
    switch (section) {
        case 0://三入口
            if (threeShopArray == nil) {
                result = 0;
            }
            break;
        case 1:// 营销入口
            if (arrayTheme == nil) {
                result = 0;
            }
            break;
            
            break;
        case 2:// 主题场景馆
            if (arrayTheme == nil) {
                result = 0;
            }
            break;
        case 3:// 专题推荐
            if (arraySpecialRec == nil) {
                result = 0;
            }
            else {// 底部加高度为1的线
                result = 1;
            }
    }
    return result;
}
//  通过自定义单元格，通过不同类型的单元格，放不同类型的商品
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *identified = @[@"cell01",@"cell02",@"cell03",@"cell04",@"cell05",@"cell06"];
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:identified[indexPath.section]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        switch (indexPath.section) {
            case 0://三入口
                cell = [[WYTableViewCell06 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identified[indexPath.section]];
                ((WYTableViewCell06*)cell).firstBtn.userInteractionEnabled=YES;
                ((WYTableViewCell06*)cell).secondBtn.userInteractionEnabled=YES;
                ((WYTableViewCell06*)cell).thirdBtn.userInteractionEnabled=YES;
                break;
            case 1:// 营销入口
                cell = [[WYTableViewCell05 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identified[indexPath.section]];
                ((WYTableViewCell05*)cell).delegate=self;
                break;
                
            case 2://主题场景馆
                cell = [[WYHomeTableViewCell02 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identified[indexPath.section]];
                ((WYHomeTableViewCell02 *)cell).delegate = self;
                break;
            case 3:// 专题推荐
                cell = [[WYHomeTableViewCell01 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identified[indexPath.section]];
               
                
                break;
            default:
                break;
        }
        cell.backgroundColor = [UIColor whiteColor];
    }
    NSArray*subviews = [[NSArray alloc]initWithArray:cell.contentView.subviews];
    
    for (UIView *subview in subviews) {
        
        [subview removeFromSuperview];
        
    }
    ChannelItem *channelitem;
    //ZMTodayRecommend *todayRec;
    
    switch (indexPath.section) {
        case 0://三入口
            ((WYTableViewCell06 *)cell).detailArray =threePicture;
            [((WYTableViewCell06*)cell).firstBtn addTarget:self action:@selector(firstbrindBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [((WYTableViewCell06*)cell).secondBtn addTarget:self action:@selector(firstbrindBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [((WYTableViewCell06*)cell).thirdBtn addTarget:self action:@selector(firstbrindBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            break;
            
        case 1:// 营销入口
            ((WYTableViewCell05 *)cell).detailArray = buyPicture;
            break;
        case 2:// 主题场景馆  通过重写set方法，进行数据的布局
            ((WYHomeTableViewCell02 *)cell).imgUrlArray = imgUrlThemeArray;
            break;
        case 3:// 专题推荐
            
            channelitem = arraySpecialRec[indexPath.row];
            [((WYHomeTableViewCell01 *)cell).imgView sd_setImageWithURL:[NSURL URLWithString:channelitem.imgUrl]];
            ((WYHomeTableViewCell01 *)cell).imgDesc.hidden = YES;
            ((WYHomeTableViewCell01 *)cell).line.hidden=YES;
            //((WYHomeTableViewCell01 *)cell).imgDesc.text=channelitem.desc;
            
            break;
        default:
            break;
    }
    
    return cell;
}

/**
 *  主题场景馆item点击事件
 *
 *  @param index item的下标
 */
- (void)WYHomeTableViewCell02ItemClickedAtIndex:(long)index{
    ChannelItem*item=arrayTheme[index];
    [self doChannelClickAction:item];
}
//三入口1
-(void)firstbrindBtnClick:(UIButton*)btn
{
    if (btn.tag==10)
    {
        ChannelItem*banner = threeShopArray[0];
        [self doChannelClickAction:banner];
    }
    if (btn.tag==11)
    {
        
        ChannelItem*banner = threeShopArray[1];
        [self doChannelClickAction:banner];
    }
    
    if (btn.tag==12)
    {
        ChannelItem*banner = threeShopArray[2];
        [self doChannelClickAction:banner];
        
    }
    
    
}
//主题场景管的点击事件
- (void)themeDelegateClickedAtIndex:(long) index
{
    ChannelItem *banner = buyShopArray[index];
    //NSLog(@"--%@",banner.saleType);
    [self doChannelClickAction:banner];
}
//  返回每行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    double result = 0;
    switch (indexPath.section) {
        case 0://三入口
            if (threeShopArray==nil||threeShopArray.count==0)
            {
                return 0;
            }
            else
            {
                result = cellImageHeigh + 20;
            }
            break;
        case 1:// 营销入口
            if (buyShopArray==nil||buyShopArray.count==0)
            {
                return 0;
            }
            else   if (buyShopArray.count>2&&buyShopArray.count%2 ==1)//当为奇数（1除外）
            {
                result = (cellImageHeigh + 6) * ((buyPicture.count + 1) / 2)+10;
            }
            else
            {
                result = (cellImageHeigh + 10) * ((buyPicture.count + 1) / 2);
            }
            break;
        case 2:// 主题场景馆
            result = (75 + 10) * ((imgUrlThemeArray.count + 1) / 2);
            break;
        case 3:// 专题推荐
            result = cellImageHeigh+10;
            break;
        default:
            break;
    }
    return result;
}
//   返还每个区有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0://三入口
            return 1;
        case 1:// 营销入口
            return 1;
        case 2:// 主题场景馆
            return 1;
        case 3:// 专题推荐
            return arraySpecialRec.count;
        default:
            break;
    }
    return 0;
}
//    区头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    if (section==0)
    {
        return [self createTitleView:section];
    }else if (section == 1 && arrayTheme!=nil)
    {
        return [self createTitleView:section];
        
    }else if (section == 2 && arrayTheme!=nil)
    {
        return [self createTitleView:section];
        
    }
    else if (section == 3 && arraySpecialRec!=nil)
    {
        return [self createTitleView:section];
        
    }else
    {
        return nil;
    }
    
}
//创建表头视图
-(UIView*)createTitleView :(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.width, 15)];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 2, 15)];
    UIEdgeInsets inset = UIEdgeInsetsMake(1, 1, 1, 1);
    imgView.image = [[UIImage imageNamed:@"homepage_03"] resizableImageWithCapInsets:inset resizingMode:UIImageResizingModeTile];
    [view addSubview:imgView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right + 5, imgView.top, 100, 15)];
    title.text = datas[section][@"title"];
    title.textColor = RGBCOLOR(25, 25, 25);
    title.font = [UIFont systemFontOfSize:15];
    [view addSubview:title];
    
    UILabel *labelLimitCount = [[UILabel alloc] initWithFrame:CGRectMake(10 + 5 + imgView.width + title.width, title.top, view.width - 10 - title.width - imgView.width - 5 - 10, 15)];
    labelLimitCount.text = datas[section][@"desc"];
    labelLimitCount.textColor = RGBCOLOR(25, 25, 25);
    labelLimitCount.font = [UIFont systemFontOfSize:15];
    labelLimitCount.textAlignment = NSTextAlignmentRight;
    [view addSubview:labelLimitCount];
    return view;
    
}

/**
 *  富文本，拼接字符串
 *
 *  @param preStr 待拼接的字符串1
 *  @param str    待拼接的字符串2
 *
 *  @return 拼接好的字符串
 */
- (NSMutableAttributedString *) parserString:(NSString *)preStr withContentStr:(NSString *)str{
    NSString *postStr = [NSString stringWithFormat:@"%@%@", preStr, str];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:postStr];
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:RGBCOLOR(115, 115, 115)
                       range:NSMakeRange(0, preStr.length)];
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:RGBCOLOR(238, 68, 100)
                       range:NSMakeRange(preStr.length, str.length)];
    UIFont *preFont = [UIFont systemFontOfSize:12];
    [attrString addAttribute:NSFontAttributeName value:preFont range:NSMakeRange(0, preStr.length)];
    
    UIFont *font = [UIFont systemFontOfSize:14];
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(preStr.length, str.length)];
    
    //    cell.textLabel.attributedText = attrString;
    return attrString;
}
//  快捷入口的点击事件
- (void) quickimgBtnClicked:(UITapGestureRecognizer *) tap{
    
    ChannelItem*banner=quickArray[tap.view.tag];
    [self doChannelClickAction:banner];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.section==3)
    {
        ChannelItem*item=arraySpecialRec[indexPath.row];
        [self doChannelClickAction:item];
    }
}

@end
