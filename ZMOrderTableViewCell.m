//
//  ZMOrderTableViewCell.m
//  WY4iPhone
//
//  Created by ZM21 on 15/9/14.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMOrderTableViewCell.h"

@implementation ZMOrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void) initView{
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
    self.width = APP_SCREEN_WIDTH;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    CGFloat headLineH = 8;
    CGFloat leftSpace = 10;
    CGFloat topSpaces = 10;
    
    UIView *headLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, headLineH)];
    headLine.backgroundColor  = RGBCOLOR(240, 240, 240);
    [self addSubview:headLine];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, headLine.bottom, self.width, 1)];
    line1.backgroundColor  = RGBCOLOR(219, 219, 219);
    [self addSubview:line1];
    
    CGFloat lbOrderStatusH = 14;
    UILabel *lbOrderStatus = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, line1.bottom + topSpaces, lbOrderStatusH * 5, lbOrderStatusH)];
    lbOrderStatus.font = [UIFont systemFontOfSize:lbOrderStatusH];
    lbOrderStatus.textColor = RGBCOLOR(185, 185, 185);
    lbOrderStatus.text = @"订单状态：";
    [self addSubview:lbOrderStatus];
    
    _labelOrderStatus = [[UILabel alloc] initWithFrame:CGRectMake(lbOrderStatus.right + 5, lbOrderStatus.top, self.width - lbOrderStatus.width - leftSpace * 2 - 5, lbOrderStatus.height)];
    _labelOrderStatus.textColor = RGBCOLOR(53, 53, 53);
    _labelOrderStatus.font = [UIFont systemFontOfSize:lbOrderStatusH];
    [self addSubview:_labelOrderStatus];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, lbOrderStatus.bottom + topSpaces, self.width, line1.height)];
    line2.backgroundColor  = RGBCOLOR(219, 219, 219);
    [self addSubview:line2];
    
    CGFloat imgViewHeadW = 70;
    CGFloat imgViewHeadH = 70;
    _imgViewHead = [[UIImageView alloc] initWithFrame:CGRectMake(leftSpace, line2.bottom + 13, imgViewHeadW, imgViewHeadH)];
    _imgViewHead.contentMode = UIViewContentModeScaleAspectFill;
    _imgViewHead.layer.masksToBounds = YES;
    [self addSubview:_imgViewHead];
    
    _labelProductName = [[UILabel alloc] initWithFrame:CGRectMake(_imgViewHead.right + 14, _imgViewHead.top, self.width / 2, _imgViewHead.height)];
    _labelProductName.font  = [UIFont systemFontOfSize:15];
    _labelProductName.textColor = RGBCOLOR(53, 53, 53);
    _labelProductName.numberOfLines = 0;
    _labelProductName.lineBreakMode = NSLineBreakByWordWrapping;
    [self addSubview:_labelProductName];
    
    // 设置右向的剪头
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, _imgViewHead.bottom + 13, self.width, line1.height)];
    line3.backgroundColor  = RGBCOLOR(219, 219, 219);
    [self addSubview:line3];
    
    CGFloat lbRealPriceH = 14;
    UILabel *lbRealPrice = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, line3.bottom + 15, lbRealPriceH * 5, lbRealPriceH)];
    lbRealPrice.font = [UIFont systemFontOfSize:lbRealPriceH];
    lbRealPrice.textColor = RGBCOLOR(185, 185, 185);
    lbRealPrice.text = @"实际金额：";
    [self addSubview:lbRealPrice];
    
    _labelRealPrice = [[UILabel alloc] initWithFrame:CGRectMake(lbRealPrice.right + 5, lbRealPrice.top, 120, lbRealPrice.height)];
    _labelRealPrice.textColor = RGBCOLOR(53, 53, 53);
    _labelRealPrice.font = [UIFont systemFontOfSize:lbRealPriceH];
    [self addSubview:_labelRealPrice];
    
    CGFloat btnPayW = 88;
    CGFloat btnPayH = 30;
    _btnPay = [[UIButton alloc] initWithFrame:CGRectMake(self.width - leftSpace - btnPayW, line3.bottom + 8, btnPayW, btnPayH)];
    _btnPay.layer.borderWidth = 1;
    _btnPay.layer.borderColor = RGBCOLOR(248, 153, 179).CGColor;
    [_btnPay setTitle:@"测试" forState:UIControlStateNormal];
    _btnPay.titleLabel.font = [UIFont systemFontOfSize:15];
    [_btnPay setTitleColor:RGBCOLOR(248, 153, 179) forState:UIControlStateNormal];
    _btnPay.layer.cornerRadius = 5;
    [self addSubview:_btnPay];
    
    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(0, lbRealPrice.bottom + 15, self.width, line1.height)];
    line4.backgroundColor  = RGBCOLOR(219, 219, 219);
    [self addSubview:line4];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        self.backgroundColor = [UIColor colorWithRed:240.f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
    }else{
        self.backgroundColor = [UIColor whiteColor];
    }
}

@end
