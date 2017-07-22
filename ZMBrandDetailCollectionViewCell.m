//
//  ZMBrandDetailCollectionViewCell.m
//  WY4iPhone
//
//  Created by ZM21 on 15/9/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMBrandDetailCollectionViewCell.h"

@implementation ZMBrandDetailCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void) initView{
    CGFloat imgW = kCellWidth - 20;
    CGFloat imgH = kCellHeight - 35 - 14 - 12- 30;
    CGFloat imgX = 10;
    CGFloat imgY = 10;
    _imgProduct = [[UIImageView alloc] initWithFrame:CGRectMake(imgX, imgY, imgW, imgH)];
    _imgProduct.contentMode = UIViewContentModeScaleAspectFill;
    _imgProduct.layer.masksToBounds = YES;
    [self addSubview:_imgProduct];
    
    _labelProductName = [[UILabel alloc] initWithFrame:CGRectMake(imgX, _imgProduct.bottom + 10, imgW, 35)];
    _labelProductName.font = [UIFont systemFontOfSize:14];
    _labelProductName.numberOfLines = 0;
    [self addSubview:_labelProductName];
    
    _labelPrice = [[UILabel alloc] initWithFrame:CGRectMake(imgX, _labelProductName.bottom + 10, imgW / 2, 15)];
    _labelPrice.font = [UIFont systemFontOfSize:15];
    _labelPrice.textColor = RGBCOLOR(255, 0, 96);
    [self addSubview:_labelPrice];
    
    _labelOldPrice = [[UILabel alloc] initWithFrame:CGRectMake(_labelPrice.right, _labelPrice.bottom - 12, imgW / 2, 12)];
    _labelOldPrice.font = [UIFont systemFontOfSize:12];
    _labelOldPrice.textColor = [UIColor lightGrayColor];
    [self addSubview:_labelOldPrice];
    _currentStock=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    _currentStock.center=_imgProduct.center;
    _currentStock.layer.cornerRadius=35;
    _currentStock.layer.masksToBounds = YES;
    [self addSubview:_currentStock];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(imgX, _labelPrice.bottom + 10, (APP_SCREEN_WIDTH - 40) / 2, 1)];
    line.backgroundColor = RGBCOLOR(247, 247, 248);
    [self addSubview:line];
}

@end
