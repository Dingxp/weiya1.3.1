//
//  MineCenterTableViewCell.m
//  WY4iPhone
//
//  Created by 旭朋  丁 on 15/9/11.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "MineCenterTableViewCell.h"

@implementation MineCenterTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        self.backgroundColor = RGBCOLOR(240, 240, 240);
    }else{
        self.backgroundColor = [UIColor whiteColor];
    }
}
-(void)initView
{
    _textLab=[[UILabel alloc]initWithFrame:CGRectMake(45, 0, 100, 54)];
    _backImage=[[UIImageView alloc]initWithFrame:CGRectMake(15, 17, 20, 20)];
    [self addSubview:_textLab];
    [self addSubview:_backImage];
}
@end
