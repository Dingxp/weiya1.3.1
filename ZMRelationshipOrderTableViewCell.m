//
//  ZMRelationshipOrderTableViewCell.m
//  WY4iPhone
//
//  Created by ZM21 on 15/9/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMRelationshipOrderTableViewCell.h"

@implementation ZMRelationshipOrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void) initView{
    self.width = APP_SCREEN_WIDTH;
    self.height = 46;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGFloat labelW = (self.width - 20 ) / 3;
    CGFloat labelH = 15;
    _labelUserName = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, labelW, labelH)];
    _labelUserName.font = [UIFont systemFontOfSize:15];
    _labelUserName.textColor = RGBCOLOR(129, 129, 129);
    [self addSubview:_labelUserName];
    
    _labelOrderPrice = [[UILabel alloc] initWithFrame:CGRectMake(_labelUserName.right, _labelUserName.top, labelW, labelH)];
    _labelOrderPrice.font = [UIFont systemFontOfSize:15];
    _labelOrderPrice.textAlignment = NSTextAlignmentCenter;
    _labelOrderPrice.textColor = RGBCOLOR(129, 129, 129);
    [self addSubview:_labelOrderPrice];
    
    _labelPreCommission = [[UILabel alloc] initWithFrame:CGRectMake(_labelOrderPrice.right, _labelOrderPrice.top, labelW, labelH)];
    _labelPreCommission.font = [UIFont systemFontOfSize:15];
    _labelPreCommission.textAlignment = NSTextAlignmentRight;
    _labelPreCommission.textColor = RGBCOLOR(129, 129, 129);
    [self addSubview:_labelPreCommission];
    
    UIView *line = [[UIView alloc] initWithFrame: CGRectMake(0, _labelUserName.bottom + 15, self.width, 1)];
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
