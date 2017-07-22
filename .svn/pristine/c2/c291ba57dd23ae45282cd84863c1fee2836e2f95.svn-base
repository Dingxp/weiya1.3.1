//
//  ZMBrandTableViewCell.m
//  WY4iPhone
//
//  Created by ZM21 on 15/9/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMBrandTableViewCell.h"

@implementation ZMBrandTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void) initView{
    CGRect frame = self.frame;
    frame.size.width = APP_SCREEN_WIDTH;
    frame.size.height = 230;
    self.frame = frame;
    self.backgroundColor = RGBCOLOR(240, 240, 240);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, self.width - 20, 168)];
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    _imgView.layer.masksToBounds = YES;
    [self addSubview:_imgView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(_imgView.left, _imgView.bottom, _imgView.width, 42)];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    CGFloat imgDescW = 120;
    _imgDesc = [[UILabel alloc] initWithFrame:CGRectMake(10, (view.height - 15 ) /2, imgDescW, 15)];
    _imgDesc.font = [UIFont systemFontOfSize:15];
    [view addSubview:_imgDesc];
    
    _labelDiscount = [[UILabel alloc] initWithFrame:CGRectMake(_imgDesc.right, _imgDesc.top, 100, 15)];
    _labelDiscount.textColor = RGBCOLOR(255, 111, 152);
    [view addSubview:_labelDiscount];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, view.bottom, self.width, 10)];
    line.backgroundColor = RGBCOLOR(240, 240, 240);
    [self addSubview:line];
}

@end
