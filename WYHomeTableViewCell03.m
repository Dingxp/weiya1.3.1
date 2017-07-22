//
//  WYHomeTableViewCell03.m
//  WY4iPhone
//
//  Created by liang.pc on 15/9/11.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "WYHomeTableViewCell03.h"

@implementation WYHomeTableViewCell03

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
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, self.width - 20, cellImageHeigh)];
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    _imgView.layer.masksToBounds = YES;
    [self addSubview:_imgView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(_imgView.left, _imgView.bottom, self.width, 10)];
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
