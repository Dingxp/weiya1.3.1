//
//  ZMLogisticsDetialTableViewCell.m
//  WY4iPhone
//
//  Created by ZM21 on 15/9/16.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMLogisticsDetialTableViewCell.h"

@implementation ZMLogisticsDetialTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void) initView{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGFloat imgW = 14;
    CGFloat imgH = 14;
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, imgW, imgH)];
    _imgView.image = [UIImage imageNamed:@"order_25"];
    [self addSubview:_imgView];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(_imgView.left + (_imgView.width - 1) / 2, _imgView.bottom, 1, 45)];
    _line.backgroundColor = RGBCOLOR(235, 235, 235);
    [self addSubview:_line];
    
    _labelLogisticsStatus = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.right + 14, _imgView.top, self.width - _imgView.width - 14 - 10, 14)];
    _labelLogisticsStatus.font = [UIFont systemFontOfSize:14];
    _labelLogisticsStatus.textColor = RGBCOLOR(193, 193, 194);
    [self addSubview:_labelLogisticsStatus];
    
    _labelLogisticsTime = [[UILabel alloc] initWithFrame:CGRectMake(_labelLogisticsStatus.left, _labelLogisticsStatus.bottom + 10, _labelLogisticsStatus.width, _labelLogisticsStatus.height)];
    _labelLogisticsTime.font = [UIFont systemFontOfSize:14];
    _labelLogisticsTime.textColor = RGBCOLOR(193, 193, 194);
    [self addSubview:_labelLogisticsTime];
}

@end
