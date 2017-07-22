//
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/11/27.
//  Copyright © 2015年 mx. All rights reserved.
//

#import "ProCommTopListViewController.h"
#import "BaseRequest.h"
#import "WYHomeTableViewCell04.h"
#import "ZMProduct.h"
#import "ZMUser.h"
#import "MJRefresh.h"
#import "ProDetailViewController.h"
@interface ProCommTopListViewController ()
{
    ZMUser*user;
   NSDictionary*arraySpecialProList;
}
@end

@implementation ProCommTopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"商品佣金排行榜";
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    _tableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_tableView];
    self.view.backgroundColor=[UIColor whiteColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(245, 50, 109);;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    user=[ZMUser userWithDict:userDic];
    [self requestChannelDetailByChannelItemId:user.userId];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreProduct)];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [SVProgressHUD dismiss];
}
-(void)moreProduct
{
    if ([arraySpecialProList[@"hasNext"] integerValue] >= 1) {// 有下一页
        [self requestMoreProListByRegUserId:user.userId bandId:nil catId:nil startPage:arraySpecialProList[@"nextPage"]];
    } else {
        [_tableView.footer endRefreshing];
        _tableView.footer.hidden = YES;
    }

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _shopCount.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *identified = @[@"cell01",@"cell02",@"cell03",@"cell04",@"cell05",@"cell06"];
    WYHomeTableViewCell04 *cell = [_tableView dequeueReusableCellWithIdentifier:identified[indexPath.section]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (!cell)
    {
        cell=[[WYHomeTableViewCell04 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identified[indexPath.section]];
    }
    NSArray*subviews = [[NSArray alloc]initWithArray:cell.contentView.subviews];
    
    for (UIView *subview in subviews) {
        
        [subview removeFromSuperview];
        
    }

   
    cell.backgroundColor=[UIColor whiteColor];
    ZMProduct*product=_shopCount[indexPath.row];
    
    
   
    [((WYHomeTableViewCell04 *)cell).imgView sd_setImageWithURL:[NSURL URLWithString:product.httpImgUrl]];
    ((WYHomeTableViewCell04 *)cell).labelGoodsTitle.text = product.proName;
    
    ((WYHomeTableViewCell04 *)cell).imgShopingCar.tag = indexPath.row;
    ((WYHomeTableViewCell04 *)cell).imgShopingCar.hidden = YES;
     ((WYHomeTableViewCell04 *)cell).labelCommission.attributedText = [self parserString:@"总佣金：" withContentStr:[NSString stringWithFormat:@"￥%@",product.totalComm]];
    ((WYHomeTableViewCell04 *)cell).labelSellPrice.attributedText = [self parserString:@"销售：" withContentStr:[NSString stringWithFormat:@"￥%@",product.currentPrice]];
    ;
    //((WYHomeTableViewCell04 *)cell).totalCount.text=product.ranking;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZMProduct*product=_shopCount[indexPath.row];
    ProDetailViewController*detailVC=[ProDetailViewController new];
    detailVC.product=product;
    detailVC.idString=@"2";
    [self.navigationController pushViewController:detailVC animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
- (void) requestChannelDetailByChannelItemId:(NSString *) regUserId{
    NSString *url = @"app/crm/channel/findProCommList.do";
    [SVProgressHUD showWithStatus:@"加载中"];
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:regUserId forKey:@"regUserId"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        //NSLog(@"channel item:－－%@", responseObject);
        [SVProgressHUD dismiss];

        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"])
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
                    arraySpecialProList = responseObject[@"result"];
                    NSArray *array = responseObject[@"result"][@"result"];
                    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
                    for (NSDictionary *dict in array) {
                        ZMProduct *product = [ZMProduct productWithDictionary:dict];
                        [tmpArray addObject:product];
                    }
                    _shopCount=[NSMutableArray arrayWithArray:tmpArray];
                    
                    [_tableView reloadData];
                    
                    
                }
 
            }
            

        }
        
    } failure:^(NSError *error) {
        //        NSLog(@"error:%@", [error localizedDescription]);
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
- (void) requestMoreProListByRegUserId:(NSString *) regUserId bandId:(NSString *) bandId catId:(NSString *) catId startPage:(NSString *) startPage{
    NSString *urlProList = @"app/crm/channel/findProCommList.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:regUserId forKey:@"regUserId"];
    [params setValue:startPage forKey:@"startPage"];

    
    [[BaseRequest sharedInstance]  request:urlProList parameters:params success:^(id responseObject) {
        [_tableView.footer endRefreshing];
                //NSLog(@"特价商品信息:%@", responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
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
                    arraySpecialProList = responseObject[@"result"];
                    NSArray *array = responseObject[@"result"][@"result"];
                    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
                    for (NSDictionary *dict in array) {
                        ZMProduct *product = [ZMProduct productWithDictionary:dict];
                        [tmpArray addObject:product];
                    }
                    [_shopCount addObjectsFromArray:tmpArray];
                    
                    [_tableView reloadData];
                    
                    
                }
                
                
 
            }
                    }
    } failure:^(NSError *error) {
        //        NSLog(@"error:%@", [error localizedDescription]);
        [_tableView.header endRefreshing];
    }];
    
}
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
    
    return attrString;
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
