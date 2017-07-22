//
//  ZMRecommendTableViewCell.m
//  WY4iPhone
//
//  Created by ZM21 on 15/9/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMRecommendTableViewCell.h"

@implementation ZMRecommendTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void) initView{
    self.width = APP_SCREEN_WIDTH;
    self.height = 300;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGFloat leftSpace = 10;
    CGFloat topSpaces = 10;
    _labelProductName = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, topSpaces, self.width - leftSpace * 2, 17)];
    _labelProductName.font = [UIFont systemFontOfSize:17];
    _labelProductName.textColor = [UIColor blackColor];
    [self addSubview:_labelProductName];
    
    _labelRecommendReason = [[UILabel alloc] initWithFrame:CGRectMake(_labelProductName.left, _labelProductName.bottom + topSpaces, _labelProductName.width, 15)];
    _labelRecommendReason.font = [UIFont systemFontOfSize:15];
    _labelRecommendReason.textColor = RGBCOLOR(29, 29, 38);
    [self addSubview:_labelRecommendReason];
    
    _imgPorduct = [[UIImageView alloc] initWithFrame:CGRectMake(leftSpace, _labelRecommendReason.bottom + topSpaces, self.width - leftSpace * 2, 180)];
    _imgPorduct.contentMode = UIViewContentModeScaleAspectFill;
    _imgPorduct.layer.masksToBounds = YES;
    [self addSubview:_imgPorduct];
    
    CGFloat labelCurPriceW = 80;
    _lableCurrentPrice = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, _imgPorduct.bottom + topSpaces * 2, labelCurPriceW, 17)];
    _lableCurrentPrice.textColor = RGBCOLOR(255, 57, 106);
    _lableCurrentPrice.font = [UIFont systemFontOfSize:17];
    [self addSubview:_lableCurrentPrice];
    
    _labelOrigalPrice = [[UILabel alloc] initWithFrame:CGRectMake(_lableCurrentPrice.right + 9, _lableCurrentPrice.bottom - 14 , _lableCurrentPrice.width, 12)];
    _labelOrigalPrice.textColor = RGBCOLOR(168, 168, 170);
    _labelOrigalPrice.font = [UIFont systemFontOfSize:12];
    [self addSubview:_labelOrigalPrice];
    
    CGFloat btnW = 76;
    CGFloat btnH = 28;
    _btnDetails = [[UIButton alloc] initWithFrame:CGRectMake(self.width - leftSpace - btnW, _imgPorduct.bottom + topSpaces, btnW, btnH)];
    _btnDetails.layer.cornerRadius = 5;
    _btnDetails.layer.borderWidth = 1;
    _btnDetails.layer.borderColor = [UIColor redColor].CGColor;
    [_btnDetails setTitle:@"查看详情" forState:UIControlStateNormal];
    [_btnDetails setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _btnDetails.titleLabel.font = [UIFont systemFontOfSize:14];
    _btnDetails.backgroundColor = [UIColor whiteColor];
    [self addSubview:_btnDetails];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 8, self.width, 8)];
    line.backgroundColor = RGBCOLOR(240, 240, 240);
    [self addSubview:line];
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
