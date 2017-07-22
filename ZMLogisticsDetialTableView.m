//
//  ZMLogisticsDetialTableView.m
//  WY4iPhone
//
//  Created by liang.pc on 15/9/16.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMLogisticsDetialTableView.h"
#import "ZMLogisticsDetialTableViewCell.h"

@interface ZMLogisticsDetialTableView (){
    
}

@end

@implementation ZMLogisticsDetialTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initView];
    }
    return self;
}

- (void) initView{
    // UITableVIew的tableHeadView
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 150)];
    headView.backgroundColor = [UIColor whiteColor];
    self.tableHeaderView = headView;
    
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 8)];
    topLine.backgroundColor = RGBCOLOR(240, 240, 240);
    [headView addSubview:topLine];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, topLine.bottom, self.width, 1)];
    line1.backgroundColor = RGBCOLOR(238, 238, 238);
    [headView addSubview:line1];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, line1.bottom + 15, 2, 15)];
    UIEdgeInsets inset = UIEdgeInsetsMake(1, 1, 1, 1);
    imgView.image = [[UIImage imageNamed:@"homepage_03"] resizableImageWithCapInsets:inset resizingMode:UIImageResizingModeTile];
    [headView addSubview:imgView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right + 5, imgView.top, 200, 15)];
    title.text = @"订单消息";
    title.textColor = RGBCOLOR(255, 74, 130);
    title.font = [UIFont systemFontOfSize:15];
    [headView addSubview:title];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, title.bottom + 15, self.width, 1)];
    line2.backgroundColor = RGBCOLOR(238, 238, 238);
    [headView addSubview:line2];
    
    UILabel *lbOrderNum = [[UILabel alloc] initWithFrame:CGRectMake(10, line2.bottom + 10, 70, 14)];
    lbOrderNum.text = @"订单编号：";
    lbOrderNum.textColor = RGBCOLOR(186, 186, 186);
    lbOrderNum.font = [UIFont systemFontOfSize:14];
    [headView addSubview:lbOrderNum];
    
    _labelOrderNumber = [[UILabel alloc] initWithFrame:CGRectMake(lbOrderNum.right + 15, lbOrderNum.top, self.width - lbOrderNum.width - 20, lbOrderNum.height)];
    _labelOrderNumber.textColor = RGBCOLOR(91, 91, 91);
    _labelOrderNumber.font = [UIFont systemFontOfSize:14];
    [headView addSubview:_labelOrderNumber];
    
    UILabel *lbOrderTime = [[UILabel alloc] initWithFrame:CGRectMake(lbOrderNum.left, lbOrderNum.bottom + 10, lbOrderNum.width, lbOrderNum.height)];
    lbOrderTime.text = @"下单时间：";
    lbOrderTime.textColor = RGBCOLOR(186, 186, 186);
    lbOrderTime.font = [UIFont systemFontOfSize:14];
    [headView addSubview:lbOrderTime];
    
    _labelOrderTime = [[UILabel alloc] initWithFrame:CGRectMake(lbOrderNum.right + 15, lbOrderTime.top, _labelOrderNumber.width, _labelOrderNumber.height)];
    _labelOrderTime.textColor = RGBCOLOR(91, 91, 91);
    _labelOrderTime.font = [UIFont systemFontOfSize:14];
    [headView addSubview:_labelOrderTime];
    
    UILabel *lbOrderCompany = [[UILabel alloc] initWithFrame:CGRectMake(lbOrderNum.left, lbOrderTime.bottom + 10, lbOrderNum.width, lbOrderNum.height)];
    lbOrderCompany.text = @"快递公司：";
    lbOrderCompany.textColor = RGBCOLOR(186, 186, 186);
    lbOrderCompany.font = [UIFont systemFontOfSize:14];
    [headView addSubview:lbOrderCompany];
    
    _labelOrderCompany = [[UILabel alloc] initWithFrame:CGRectMake(lbOrderCompany.right + 15, lbOrderCompany.top, _labelOrderNumber.width, _labelOrderNumber.height)];
    _labelOrderCompany.textColor = RGBCOLOR(91, 91, 91);
    _labelOrderCompany.font = [UIFont systemFontOfSize:14];
    [headView addSubview:_labelOrderCompany];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, lbOrderCompany.bottom + 15, self.width, 1)];
    line3.backgroundColor = RGBCOLOR(238, 238, 238);
    [headView addSubview:line3];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, line3.bottom, self.width, 8)];
    bottomLine.backgroundColor = RGBCOLOR(240, 240, 240);
    [headView addSubview:bottomLine];
    
    self.delegate = self;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = _datas[indexPath.row];
    static NSString *identified = @"logisticsCell";
    ZMLogisticsDetialTableViewCell *cell = [self dequeueReusableCellWithIdentifier:identified];
    if (!cell) {
        cell = [[ZMLogisticsDetialTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identified];
    }
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.imgView.image = [UIImage imageNamed:@"order_25"];
    } else {
        cell.imgView.image = [UIImage imageNamed:@"order_22"];
    }
    cell.labelLogisticsStatus.text = dic[@"status"];
    cell.labelLogisticsTime.text = dic[@"time"];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 58;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 45)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIView *line  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.width, 1)];
    line.backgroundColor = RGBCOLOR(238, 238, 238);
    [view addSubview:line];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, line.bottom + 15, view.width - 10 * 2, 14)];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = RGBCOLOR(190, 190, 190);
    label.text = @"物流信息";
    [view addSubview:label];
    
    return view;
}

@end
