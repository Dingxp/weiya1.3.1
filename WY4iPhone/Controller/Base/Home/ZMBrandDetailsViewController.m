//
//  ZMBrandDetailsViewController.m
//  WY4iPhone
//
//  Created by ZM21 on 15/9/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMBrandDetailsViewController.h"
#import "ZMBrandDetailCollectionViewCell.h"
#import "ZMBand.h"
#import "UMSocial.h"
#import "ZMUser.h"
@interface ZMBrandDetailsViewController (){
    NSArray *arrayResult;
    NSArray *channelItemlist;
}

@end

@implementation ZMBrandDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationItem.title = _banner.channelItemName;
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    [self initView];
    [self loadData];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void) loadData{
    [self requestChannelDetailByChannelItemId:_banner.channelItemId];
}

- (void) initView{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - self.navigationController.navigationBar.bottom) collectionViewLayout:flowLayout];
    _collectionView.showsVerticalScrollIndicator = YES;
    
    //设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    //注册cell和ReusableView（相当于头部）
    [self.collectionView registerClass:[ZMBrandDetailCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _collectionView.backgroundColor = [UIColor whiteColor];
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrayResult.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{    static NSString *identify = @"cell";
    ZMBrandDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
//        NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来了。");
    }
    NSDictionary*arr=arrayResult[indexPath.row];
    [cell.imgProduct sd_setImageWithURL:[NSURL URLWithString:arr[@"httpImgUrl"]]];
    cell.labelProductName.text = [NSString stringWithFormat:@"%@", arr[@"proName"]];
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //边距占5*4=20 ，2个
    //图片为正方形，边长：(fDeviceWidth-20)/2-5-5 所以总高(fDeviceWidth-20)/2-5-5 +20+30+5+5 label高20 btn高30 边
    return CGSizeMake(kCellWidth, kCellHeight);
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZMBrandItemViewController *brandItemVC = [[ZMBrandItemViewController alloc] init];
    brandItemVC.channelItem = channelItemlist[indexPath.row];
    [self.navigationController pushViewController:brandItemVC animated:YES];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  根据频道项ID查询该频道项下面的商品列表,查询某个活动下包含的明细列表
 *
 *  @param cItemId 频道项ID
 */
- (void) requestChannelDetailByChannelItemId:(NSString *) cItemId{
    
    [SVProgressHUD showWithStatus:@"加载中"];
    
    NSString *url = @"app/crm/channel/findCtxByCiId.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:cItemId forKey:@"cItemId"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            arrayResult = responseObject[@"result"][@"result"];

            [_collectionView reloadData];
        }
    } failure:^(NSError *error) {
//        NSLog(@"error:%@", [error localizedDescription]);
    }];
}


@end
