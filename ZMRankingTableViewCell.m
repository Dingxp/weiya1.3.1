//
//  ZMRankingTableViewCell.m
//  WY4iPhone
//
//  Created by ZM21 on 15/9/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMRankingTableViewCell.h"

@implementation ZMRankingTableViewCell

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
    self.height = 78;
    
    CGFloat imgRankW = 45;
    CGFloat imgRankH = imgRankW;
    CGFloat imgRankX = 10;
    CGFloat imgRankY = 16;
    _imgRank = [[UIImageView alloc] initWithFrame:CGRectMake(imgRankX, imgRankY, imgRankW, imgRankH)];
    [self addSubview:_imgRank];
    
    _labelRank = [[UILabel alloc] initWithFrame:CGRectMake(imgRankX, imgRankY, imgRankW, imgRankH)];
    _labelRank.font = [UIFont systemFontOfSize:18];
    _labelRank.textAlignment = NSTextAlignmentCenter;
    _labelRank.textColor = RGBCOLOR(29, 29, 38);
    [self addSubview:_labelRank];
    
    _labelUserName = [[UILabel alloc] initWithFrame:CGRectMake(_imgRank.right + 17, (self.height - 17 - 2) / 2, 100, 17)];
    _labelUserName.font = [UIFont systemFontOfSize:15];
    [self addSubview:_labelUserName];
    
    CGFloat labelW = 100;
    CGFloat labelX = self.width - 10 - labelW;
    CGFloat labelH = 15;
    CGFloat labelY = 15;
    UILabel *lbIncome = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
    lbIncome.font = [UIFont systemFontOfSize:15];
    lbIncome.textColor = RGBCOLOR(193, 193, 193);
    lbIncome.text = @"共赚";
    lbIncome.textAlignment = NSTextAlignmentRight;
    [self addSubview:lbIncome];
    
    _labelIncome = [[UILabel alloc] initWithFrame:CGRectMake(lbIncome.left, lbIncome.bottom + 10, lbIncome.width, lbIncome.height)];
    _labelIncome.font = [UIFont systemFontOfSize:15];
    _labelIncome.text = @"共赚";
    _labelIncome.textAlignment = NSTextAlignmentRight;
    _labelIncome.textColor = RGBCOLOR(193, 193, 193);
    [self addSubview:_labelIncome];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, _imgRank.bottom + 15, self.width, 1)];
    line.backgroundColor = RGBCOLOR(241, 241, 241);
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
