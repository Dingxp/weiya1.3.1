//
//  ZMRecommendViewController.m
//  WY4iPhone
//
//  Created by ZM21 on 15/9/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMRecommendViewController.h"
#import "ZMRecommendTableViewCell.h"

@interface ZMRecommendViewController ()

@end

@implementation ZMRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    self.title = @"推荐";
    
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
- (void) initView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    UIView *headView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.width, 270)];
    headView.backgroundColor = [UIColor whiteColor];
    _tableView.tableHeaderView = headView;
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, headView.width, 170)];
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    _imgView.layer.masksToBounds = YES;
    _imgView.image = [UIImage imageNamed:@"food2.jpg"];
    [headView addSubview:_imgView];
    _labelDesc = [[UILabel alloc] initWithFrame:CGRectMake(10, _imgView.bottom + 10, _tableView.width - 20, 80)];
    _labelDesc.numberOfLines = 0;
    _labelDesc.font = [UIFont systemFontOfSize:15];
    _labelDesc.textColor = RGBCOLOR(25, 25, 25);
    _labelDesc.text = @"今天是5月20日，即网络情人节，是信息时代的爱情节日。该节日源于歌手范晓萱的《数字恋爱》中“520”被喻成“我爱你”。逐渐被情侣们赋予“结婚吉日”、“表白日”、“撒娇日”、“求爱节”等寓意。";
    [headView addSubview:_labelDesc];
    
    CGFloat headLineH = 8;
    UIView *headLine = [[UIView alloc] initWithFrame:CGRectMake(0, headView.height - headLineH, headView.width, headLineH)];
    headLine.backgroundColor = RGBCOLOR(240, 240, 240);
    [headView addSubview:headLine];
    
}

#pragma mark UITableView_delegate and datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identified = @"cell";
    ZMRecommendTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:identified];
    if (!cell) {
        cell = [[ZMRecommendTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identified];
    }
    cell.labelProductName.text = @"1烘烤原味蜜汁XO酱特产猪肉脯猪肉";
    cell.labelRecommendReason.text = [NSString stringWithFormat:@"%@%@", @"推荐理由", @"巧克力象征爱情"];
    cell.imgPorduct.image = [UIImage imageNamed:@"food1.jpg"];
    cell.lableCurrentPrice.text = [NSString stringWithFormat:@"%@%@", @"￥", @"100.00"];
    NSString *oriStr = @"123";
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:oriStr];
    [attrString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, oriStr.length)];
    [attrString addAttribute:NSStrikethroughColorAttributeName value:RGBCOLOR(168, 168, 170) range:NSMakeRange(0, oriStr.length)];
    cell.labelOrigalPrice.attributedText = attrString;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
