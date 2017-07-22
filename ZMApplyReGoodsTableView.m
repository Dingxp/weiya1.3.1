//
//  ZMApplyReGoodsTableView.m
//  WY4iPhone
//
//  Created by ZM on 15/9/21.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMApplyReGoodsTableView.h"

@interface ZMApplyReGoodsTableView () {
    UIView *footView;
}

@end


@implementation ZMApplyReGoodsTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        _selectProList = [[NSMutableArray alloc] init];
        [self initView];
    }
    return self;
}

- (void) initView{
    self.backgroundColor = [UIColor clearColor];
    self.delegate = self;
    self.dataSource = self;

    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
    self.tableFooterView = [self customTableFooterView];
}

- (void)setCancelOrder:(ZMOrder *)cancelOrder{
    _cancelOrder = cancelOrder;
    _tmpOrderList = [cancelOrder copy];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cancelOrder.items.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZMOrderDetail *orderDetail = _cancelOrder.items[indexPath.row];
    static NSString *identified = @"cancelOrderCell";
    ZMApplyRetGTableViewCell *cell = [self dequeueReusableCellWithIdentifier:identified];
    if (!cell) {
        cell = [[ZMApplyRetGTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identified];
    }
    cell.delegate = self;
    cell.btnSub.tag = indexPath.row;
    cell.btnAdd.tag = indexPath.row;
    cell.labelProductName.text = orderDetail.proName;
    cell.labelPrice.text = [NSString stringWithFormat:@"￥%@",orderDetail.price];
    cell.labelCount.text = [NSString stringWithFormat:@"x%@",orderDetail.quantity];
    [cell.imgViewHead sd_setImageWithURL:[NSURL URLWithString:orderDetail.httpImgUrl]];
    cell.textFieldCount.text = orderDetail.quantity;
    if (orderDetail.isSelected) {
        cell.imgViewIndicate.image = [UIImage imageNamed:@"hookRing"];
    } else {
        cell.imgViewIndicate.image = [UIImage imageNamed:@"emptyRing"];
    }
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100 + 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 50)];
    view.backgroundColor = [UIColor whiteColor];
    
    _labelReason = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, APP_SCREEN_WIDTH - 10, 40)];
    _labelReason.font = [UIFont systemFontOfSize:15];
    _labelReason.text = @"退货理由";
    [view addSubview:_labelReason];
    
    UIImageView *imgRightIndicate = [[UIImageView alloc] initWithFrame:CGRectMake(APP_SCREEN_WIDTH - 10 - 10, (40 - 12) / 2, 10, 12)];
    imgRightIndicate.image = [UIImage imageNamed:@"mine_rightGray"];
    [view addSubview:imgRightIndicate];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelReasonClicked:)];
    _labelReason.userInteractionEnabled = YES;
    [_labelReason addGestureRecognizer:tap];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, _labelReason.bottom, APP_SCREEN_WIDTH, 10)];
    line.backgroundColor = BaseBackViewRGB;
    [view addSubview:line];
    
    return view;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZMApplyRetGTableViewCell *cell = (ZMApplyRetGTableViewCell *)[self cellForRowAtIndexPath:indexPath];
    if ([_selectProList containsObject:_cancelOrder.items[indexPath.row]]) {// 已被选中，取消选中
        [_selectProList removeObject:_cancelOrder.items[indexPath.row]];
        ((ZMOrderDetail *) _cancelOrder.items[indexPath.row]).isSelected = YES;
        ((ZMOrderDetail *) _tmpOrderList.items[indexPath.row]).isSelected = YES;
        cell.imgViewIndicate.image = [UIImage imageNamed:@"hookRing"];
    } else {// 未选中，添加选中
        [_selectProList addObject:_cancelOrder.items[indexPath.row]];
        cell.imgViewIndicate.image = [UIImage imageNamed:@"emptyRing"];
        ((ZMOrderDetail *) _cancelOrder.items[indexPath.row]).isSelected = NO;
        ((ZMOrderDetail *) _tmpOrderList.items[indexPath.row]).isSelected = NO;
    }
}

/**
 *  初始化UITableView的FooterView
 */
- (UIView *) customTableFooterView{
    footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 125 + 166 + 30)];
    footView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyboard:)];
    [footView addGestureRecognizer:tap];
    footView.backgroundColor = [UIColor whiteColor];
    [self addSubview:footView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, self.width, 15)];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"请将需要退货的商品寄到如下地址";
    [footView addSubview:label];
    
    UILabel *lbContacts = [[UILabel alloc] initWithFrame:CGRectMake(label.left, label.bottom + 15, 70, 14)];
    lbContacts.font = [UIFont systemFontOfSize:14];
    lbContacts.textColor = RGBCOLOR(199, 199, 199);
    lbContacts.text = @"联系人：";
    [footView addSubview:lbContacts];
    
    _labelContacts = [[UILabel alloc] initWithFrame:CGRectMake(lbContacts.right + 10, lbContacts.top, self.width - lbContacts.width - 10 * 2, lbContacts.height)];
    _labelContacts.font = [UIFont systemFontOfSize:14];
    _labelContacts.textColor = RGBCOLOR(130, 130, 133);
//    _labelContacts.text = @"时尚圈 售后组";
    [footView addSubview:_labelContacts];
    
    UILabel *lbPhoneNum = [[UILabel alloc] initWithFrame:CGRectMake(label.left, lbContacts.bottom + 10, lbContacts.width, lbContacts.height)];
    lbPhoneNum.font = [UIFont systemFontOfSize:14];
    lbPhoneNum.textColor = RGBCOLOR(199, 199, 199);
    lbPhoneNum.text = @"联系电话：";
    [footView addSubview:lbPhoneNum];
    
    _labelPhoneNum = [[UILabel alloc] initWithFrame:CGRectMake(_labelContacts.left, lbPhoneNum.top, _labelContacts.width, lbPhoneNum.height)];
    _labelPhoneNum.font = [UIFont systemFontOfSize:14];
    _labelPhoneNum.textColor = RGBCOLOR(130, 130, 133);
//    _labelPhoneNum.text = @"025-252525";
    [footView addSubview:_labelPhoneNum];
    
    UILabel *lbAddress = [[UILabel alloc] initWithFrame:CGRectMake(label.left, lbPhoneNum.bottom + 10, lbContacts.width, lbContacts.height)];
    lbAddress.font = [UIFont systemFontOfSize:14];
    lbAddress.textColor = RGBCOLOR(199, 199, 199);
    lbAddress.text = @"地      址：";
    [footView addSubview:lbAddress];
    
    _labelAddress = [[UILabel alloc] initWithFrame:CGRectMake(_labelPhoneNum.left, lbAddress.top, _labelPhoneNum.width, _labelPhoneNum.height * 2 + 10)];
    _labelAddress.font = [UIFont systemFontOfSize:14];
    _labelAddress.textColor = RGBCOLOR(130, 130, 133);
    _labelAddress.numberOfLines = 0;
//    _labelAddress.text = @"江苏省南京市江宁区将军大豆香山美墅13栋401";
    [footView addSubview:_labelAddress];
    
    UILabel *lbPostCode = [[UILabel alloc] initWithFrame:CGRectMake(label.left, _labelAddress.bottom + 10, lbContacts.width, lbContacts.height)];
    lbPostCode.font = [UIFont systemFontOfSize:14];
    lbPostCode.textColor = RGBCOLOR(199, 199, 199);
    lbPostCode.text = @"邮      编：";
    [footView addSubview:lbPostCode];
    
    _labelPostCode = [[UILabel alloc] initWithFrame:CGRectMake(_labelPhoneNum.left, lbPostCode.top, _labelPhoneNum.width, _labelPhoneNum.height)];
    _labelPostCode.font = [UIFont systemFontOfSize:14];
    _labelPostCode.textColor = RGBCOLOR(130, 130, 133);
//    _labelPostCode.text = @"210000 ";
    [footView addSubview:_labelPostCode];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, _labelPostCode.bottom + 20, footView.width - 10 * 2, 1)];
    line.backgroundColor = RGBCOLOR(250, 250, 250);
    [footView addSubview:line];
    
    UILabel *labelTips = [[UILabel alloc] initWithFrame:CGRectMake(lbPhoneNum.left, line.bottom + 15, self.width - 10 * 2, 15)];
    labelTips.font = [UIFont systemFontOfSize:15];
    labelTips.text = @"注意事项";
    [footView addSubview:labelTips];
    
    _labelTipsContent = [[UILabel alloc] initWithFrame:CGRectMake(labelTips.left, labelTips.bottom + 15, self.width - 10 * 2, 60)];
    _labelTipsContent.font = [UIFont systemFontOfSize:14];
    _labelTipsContent.textColor = RGBCOLOR(200, 200, 200);
    _labelTipsContent.text = @"1.退货时，请务必把商品订单打印纸放在寄回的快递盒里，否则将会影响到商品的售后办理。\n2.不要选择“到付”形式将商品寄回，以免影响商品售后办理。";
    _labelTipsContent.numberOfLines = 0;
    [footView addSubview:_labelTipsContent];
    
    return footView;
}

- (void) hiddenKeyboard:(UITapGestureRecognizer *)tap{
    [self endEditing:YES];
}

- (void)setResultParams:(NSDictionary *)resultParams{
    _resultParams = resultParams;
    self.labelAddress.text = resultParams[@"address"];
    
    CGRect frame = _labelAddress.frame;
    frame.size.height = [resultParams[@"address"] commonStringHeighforLabelWidth:self.width - 90 withFontSize:14];
    _labelAddress.frame = frame;
    
    self.labelContacts.text = resultParams[@"linkMan"];
    self.labelPhoneNum.text = resultParams[@"phone"];
    self.labelPostCode.text = resultParams[@"postCode"];
//    self.labelTipsContent.text = resultParams[@"attentions"];
    
    CGRect frameTips = _labelTipsContent.frame;
//    frameTips.size.height = [resultParams[@"attentions"] commonStringHeighforLabelWidth:self.width - 90 withFontSize:14];
    frameTips.size.height = [@"1.退货时，请务必把商品订单打印纸放在寄回的快递盒里，否则将会影响到商品的售后办理\n2.不要选择“到付”形式将商品寄回，以免影响商品售后办理。" commonStringHeighforLabelWidth:self.width - 90 withFontSize:14];
    _labelTipsContent.frame = frameTips;
}

- (void) labelReasonClicked:(UITapGestureRecognizer *)tap{
    if (_applyReGoodsDelegate && [_applyReGoodsDelegate respondsToSelector:@selector(labelReasonClicked:)]) {
        [_applyReGoodsDelegate labelReasonClicked:tap];
    }
}

//-(void)updateProdouctCountButton:(UIButton *)button curCountStr:(NSString *)count{
//    ((ZMOrderDetail *)(_cancelOrder.items[button.tag])).quantity = count;
//}
//减少按钮点击
- (void)subButton:(UIButton *)button curCountStr:(NSString *)count{
    ((ZMOrderDetail *)(_tmpOrderList.items[button.tag])).quantity = count;
}

//添加按钮点击
- (void)addButton:(UIButton *)button curCountStr:(NSString *)count{
    
    ZMOrderDetail *orderDetail = _cancelOrder.items[button.tag];
//    NSLog(@"count :%@, %p, items:%p, quantity: %@, %p, items: %p", count, _cancelOrder,  _cancelOrder.items, orderDetail.quantity, _tmpOrderList, _tmpOrderList.items);
    if ([count integerValue] < [orderDetail.quantity integerValue]) {
        ZMApplyRetGTableViewCell *cell = (ZMApplyRetGTableViewCell *)[self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:button.tag inSection:0]];
        int num = [count intValue] + 1;
        cell.textFieldCount.text = [NSString stringWithFormat:@"%d", num];
        ((ZMOrderDetail *)(_tmpOrderList.items[button.tag])).quantity = [NSString stringWithFormat:@"%d", num];
    } else {
//        NSLog(@"已经达到最大退货数量!");
    }
    
}

@end
