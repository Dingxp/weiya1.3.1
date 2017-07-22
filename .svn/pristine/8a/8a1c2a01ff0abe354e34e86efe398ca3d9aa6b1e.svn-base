//
//  ZMRelationshipOrderViewController2.m
//  WY4iPhone
//
//  Created by ZM21 on 15/10/11.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMRelationshipOrderViewController2.h"

@interface ZMRelationshipOrderViewController2 (){
    NSArray *relationshipOrderList;
    UILabel *labelStatus;
    UILabel *labelAmount;
    UILabel* tipsEmpty;
}

@end

@implementation ZMRelationshipOrderViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title  = @"人脉圈订单";
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
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
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - self.navigationController.navigationBar.bottom) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    [self.view addSubview:_tableView];
    tipsEmpty = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height /2)];
    tipsEmpty.textAlignment = NSTextAlignmentCenter;
    tipsEmpty.text = @"没有订单!";
    tipsEmpty.textColor = RGBCOLOR(102, 102, 102);
    [self.view addSubview:tipsEmpty];
}

- (void)loadData{
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
   ZMUser* user=[ZMUser userWithDict:userDic];
    [self requestRelationshipOrderByRegUserId:user.userId startPage:@"0"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return relationshipOrderList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ZMOrder *order = relationshipOrderList[section];
    return order.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZMOrder *order = relationshipOrderList[indexPath.section];
    ZMOrderDetail *orderDetail = order.items[indexPath.row];
    static NSString *identified = @"orderCell";
    
    ZMOrderDetailTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identified];
    if (!cell) {
        cell = [[ZMOrderDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identified];
    }
    [cell.imgViewHead sd_setImageWithURL:[NSURL URLWithString:orderDetail.httpImgUrl]];
    
    CGFloat h = [orderDetail.proName commonStringHeighforLabelWidth:cell.labelProductName.frame.size.width withFontSize:15];
    cell.labelProductName.text = orderDetail.proName;
    CGRect frame = cell.labelProductName.frame;
    frame.size.height = h;
    cell.labelProductName.frame = frame;
    
    cell.labelCount.text = [NSString stringWithFormat:@"x%@", orderDetail.quantity];
    cell.labelPrice.text = [NSString stringWithFormat:@"￥%@", orderDetail.price];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ZMOrder *order = relationshipOrderList[section];
    
    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 45)];
    viewHeader.backgroundColor = [UIColor whiteColor];
    
    labelStatus = [[UILabel alloc] initWithFrame:CGRectMake(10, (45 - 15) / 2, viewHeader.width - 10 * 2, 15)];
    labelStatus.font = [UIFont systemFontOfSize:14];
    labelStatus.textColor = [UIColor blackColor];
    [viewHeader addSubview:labelStatus];
    
    CALayer *topLayer = [CALayer layer];
    topLayer.frame = CGRectMake(0, 0, viewHeader.width, 1);
    topLayer.backgroundColor = RGBCOLOR(219, 219, 219).CGColor;
    [viewHeader.layer addSublayer:topLayer];
    
    switch ([order.orderState integerValue]) {
        case 0://  已取消
            labelStatus.text = @"已取消";
            break;
        case 1:// 待审核
            labelStatus.text = @"待付款";
            break;
        case 2:// 待发货
            labelStatus.text = @"待发货";
            break;
        case 3:// 已发货
            labelStatus.text = @"已发货";
            break;
        case 5:// 退货中
            labelStatus.text = @"退货中";
            break;
        case 6:// 待退款
           labelStatus.text = @"待退款";
            break;
        case 4:// 已完成
            labelStatus.text = @"已完成";
            break;
        case 7:// 已退款
            labelStatus.text = @"已退款";
            break;
            
        default:
            break;
    }
    
    return viewHeader;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    ZMOrder *order = relationshipOrderList[section];
    
    UIView *viewFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 55)];
    viewFooter.backgroundColor = [UIColor whiteColor];
    
    UILabel *lbAmout = [[UILabel alloc] initWithFrame:CGRectMake(10, (45 - 15) / 2, 70, 15)];
    lbAmout.text = @"订单金额：";
    lbAmout.textColor = [UIColor lightGrayColor];
    lbAmout.font = [UIFont systemFontOfSize:14];
    [viewFooter  addSubview:lbAmout];
    
    labelAmount = [[UILabel alloc] initWithFrame:CGRectMake(lbAmout.right, lbAmout.top, viewFooter.width - 10 * 2 - lbAmout.width, lbAmout.height)];
    labelAmount.font = [UIFont systemFontOfSize:14];
    labelAmount.textColor = [UIColor blackColor];
    labelAmount.text = [NSString stringWithFormat:@"￥%@", order.amount];
    [viewFooter addSubview:labelAmount];
    
    CALayer *bottomLayer = [CALayer layer];
    bottomLayer.frame = CGRectMake(0, viewFooter.height - 10, viewFooter.width, 10);
    bottomLayer.backgroundColor = RGBCOLOR(219, 219, 219).CGColor;
    [viewFooter.layer addSublayer:bottomLayer];
    
    return viewFooter;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 54;
}

/**
 *  查询关系订单
 *
 *  @param regUserId 会员ID
 *  @param startPage 开始页
 */
- (void) requestRelationshipOrderByRegUserId:(NSString *)regUserId startPage:(NSString *)startPage{
    NSString *url = @"wbusi/wbusiinfo/wbusiinfo/findRelationalOrder.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:regUserId forKey:@"regUserId"];
    [params setValue:startPage forKey:@"startPage"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        //NSLog(@"%@", responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"false"]) {
            return ;
        }
        [self.tableView.header endRefreshing];
        if ( [responseObject[@"result"] isKindOfClass:[NSDictionary class]])

        {
            NSDictionary*resDic=responseObject[@"result"];
            NSArray*arr=[resDic allKeys];
            if ([arr containsObject:@"result"])
            {
                if (responseObject[@"result"][@"result"]==nil)
                {
                    return;
                }
                NSArray *orderArray = responseObject[@"result"][@"result"];
                NSMutableArray *orders = [[NSMutableArray alloc] init];
                for (NSDictionary *dict in orderArray) {
                    ZMOrder *order = [ZMOrder orderWithDictionary:dict];
                    [orders addObject:order];
                }
                relationshipOrderList = orders;
                if (orders.count>0)
                {
                    
                    tipsEmpty.hidden=YES;
                }

                [self.tableView reloadData];
                
            }
   
        }
        
        
    } failure:^(NSError *error) {
       // NSLog(@"error: %@", [error localizedDescription]);
    }];
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
