//
//  WYTableViewCell07.m
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/12/8.
//  Copyright © 2015年 mx. All rights reserved.
//

#import "WYTableViewCell07.h"

@implementation WYTableViewCell07

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void) initView{
    self.backgroundColor = RGBCOLOR(240, 240, 240);
    CGRect frame = self.frame;
    frame.size.width = APP_SCREEN_WIDTH;
    self.frame = frame;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    _line = [[UIView alloc] initWithFrame:CGRectMake(10, 2, self.width-20, 1)];
//    _line.backgroundColor=[UIColor grayColor];
//    _line.alpha=0.4;
//    //_line.hidden=YES;
//    [self addSubview:_line];
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, self.width - 20, cellImageHeigh)];
    _imgView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_imgView];
    
    
    _imgDesc = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.left, _imgView.bottom +5, 50, 37)];
    _imgDesc.font = [UIFont systemFontOfSize:14];
    _imgDesc.textColor = [UIColor blackColor];
    [self addSubview:_imgDesc];
    _bandName=[[UILabel alloc]initWithFrame:CGRectMake(_imgDesc.right+5, _imgView.bottom+5, 150, 37)];
    _bandName.font=[UIFont systemFontOfSize:14];
    _bandName.textColor=[UIColor blackColor];
    [self addSubview:_bandName];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(0, _bandName.bottom, self.width, 10)];
    _line.backgroundColor=RGBCOLOR(216, 216, 216);
    [self addSubview:_line];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
