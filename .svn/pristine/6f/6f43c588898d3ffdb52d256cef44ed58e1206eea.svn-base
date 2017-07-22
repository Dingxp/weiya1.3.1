//
//  WYHomeTableViewCell04.m
//  WY4iPhone
//
//  Created by liang.pc on 15/9/11.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "WYHomeTableViewCell04.h"

@implementation WYHomeTableViewCell04

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void) initView{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.width = APP_SCREEN_WIDTH;
    
    CGFloat imgW = 100;
    CGFloat imgH = 100;
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, imgW, imgH)];
    [self addSubview:_imgView];
    _labelGoodsTitle = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.right + 14, _imgView.top-10, self.width - 10 * 2 - 14 - _imgView.width-27, 80)];
    _labelGoodsTitle.font = [UIFont systemFontOfSize:14];
    _labelGoodsTitle.textColor = RGBCOLOR(53, 53, 53);
    _labelGoodsTitle.numberOfLines = 0;
    [self addSubview:_labelGoodsTitle];
    _totalCount=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, 30, 30)];
    _totalCount.textColor=[UIColor blackColor];
    _labelSellPrice = [[UILabel alloc] initWithFrame:CGRectMake(_labelGoodsTitle.left, _labelGoodsTitle.bottom+5, _labelGoodsTitle.width / 2, 12)];
    _labelSellPrice.font = [UIFont systemFontOfSize:14];
    _labelSellPrice.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_labelSellPrice];
    
    _labelCommission = [[UILabel alloc] initWithFrame:CGRectMake(_labelSellPrice.left, _labelSellPrice.bottom+10, _labelSellPrice.width, _labelSellPrice.height)];
    _labelCommission.font = [UIFont systemFontOfSize:14];
    _labelCommission.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_labelCommission];
    
    
    
    
    
}



@end
