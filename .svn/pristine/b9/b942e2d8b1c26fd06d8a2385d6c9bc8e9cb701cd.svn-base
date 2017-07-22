//
//  WYHomeTableViewCell01.m
//  WY4iPhone
//
//  Created by liang.pc on 15/9/11.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "WYHomeTableViewCell01.h"

@implementation WYHomeTableViewCell01

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void) initView{
    self.backgroundColor = RGBCOLOR(245, 245, 245);
    CGRect frame = self.frame;
    frame.size.width = APP_SCREEN_WIDTH;
    self.frame = frame;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, self.width - 20, cellImageHeigh)];
    _imgView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_imgView];
    
    
    _imgDesc = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.left, _imgView.bottom , _imgView.width, 37)];
    _imgDesc.backgroundColor=[UIColor whiteColor];
    _imgDesc.font = [UIFont systemFontOfSize:14];
    _imgDesc.textColor = RGBCOLOR(96, 96, 96);
    [self addSubview:_imgDesc];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(10, _imgDesc.bottom+2, self.width-20, 0.5)];
    _line.backgroundColor=RGBCOLOR(220, 220,220);
    [self addSubview:_line];
}


@end
