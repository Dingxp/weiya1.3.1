//
//  ZMSpecRecommendTableViewCell.m
//  WY4iPhone
//
//  Created by ZM on 15/10/9.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMSpecRecommendTableViewCell.h"

@implementation ZMSpecRecommendTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void) initView{
    self.backgroundColor = [UIColor whiteColor];
    CGRect frame = self.frame;
    frame.size.width = APP_SCREEN_WIDTH;
    self.frame = frame;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 10)];
    topLine.backgroundColor = BaseBackViewRGB;
    [self addSubview:topLine];
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, topLine.bottom, self.width - 20, cellImageHeigh)];
    _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imgView];
    
    _imgDesc = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.left, _imgView.bottom - 37, _imgView.width, 37)];
    _imgDesc.font = [UIFont systemFontOfSize:14];
    _imgDesc.textColor = [UIColor whiteColor];
    _imgDesc.backgroundColor = [UIColor blackColor];
    _imgDesc.alpha = 0.5;
    [self addSubview:_imgDesc];
}

@end
