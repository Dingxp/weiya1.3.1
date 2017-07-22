//
//  ZMCommissionDetailTableViewCell.m
//  WY4iPhone
//
//  Created by ZM21 on 15/9/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMCommissionDetailTableViewCell.h"

@implementation ZMCommissionDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void) initView{
    self.width = APP_SCREEN_WIDTH;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _imgHead = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    _imgHead.layer.cornerRadius = _imgHead.height / 2;
    _imgHead.contentMode = UIViewContentModeScaleAspectFill;
    _imgHead.image = [UIImage imageNamed:@"default_icon"];
    [self addSubview:_imgHead];
    
    UILabel *lbUserName = [[UILabel alloc] initWithFrame:CGRectMake(_imgHead.right + 10, 15, 60, 15)];
    lbUserName.font = [UIFont systemFontOfSize:14];
    lbUserName.text = @"用户名：";
    lbUserName.textColor = RGBCOLOR(141, 141, 141);
    [self addSubview:lbUserName];
    
    _labelUserName = [[UILabel alloc] initWithFrame:CGRectMake(lbUserName.right, lbUserName.top, 200, 17)];
    _labelUserName.font = [UIFont systemFontOfSize:14];
    [self addSubview:_labelUserName];
    
    UILabel *lbMoney = [[UILabel alloc] initWithFrame:CGRectMake(lbUserName.left, lbUserName.bottom + 10, lbUserName.width, lbUserName.height)];
    lbMoney.textColor = RGBCOLOR(141, 141, 141);
    lbMoney.font = [UIFont systemFontOfSize:14];
    lbMoney.text = @"贡献了：";
    [self addSubview:lbMoney];
    
    _labelMoney = [[UILabel alloc] initWithFrame:CGRectMake(_labelUserName.left, lbMoney.top, _labelUserName.width, _labelUserName.height)];
    _labelMoney.font = [UIFont systemFontOfSize:14];
    [self addSubview:_labelMoney];
    
    CGFloat labelTimeW = 100;
    _labelTime = [[UILabel alloc] initWithFrame:CGRectMake(self.width - labelTimeW - 10, lbUserName.top, labelTimeW, lbUserName.height)];
    _labelTime.textColor = RGBCOLOR(141, 141, 141);
    _labelTime.font = [UIFont systemFontOfSize:14];
    _labelTime.textAlignment  = NSTextAlignmentRight;
    [self addSubview:_labelTime];
    
    UIView *line  = [[UIView alloc] initWithFrame:CGRectMake(0, lbMoney.bottom + 15, self.width, 1)];
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
