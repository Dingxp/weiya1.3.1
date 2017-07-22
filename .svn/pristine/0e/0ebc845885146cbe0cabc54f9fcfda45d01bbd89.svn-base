//
//  ZMProDetailTableViewCell.m
//  WY4iPhone
//
//  Created by ZM on 15/9/23.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMProDetailTableViewCell.h"

@implementation ZMProDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return  self;
}

- (void) initView{
    self.width = APP_SCREEN_WIDTH;
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    

    _imgDetail = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0)];
    _imgDetail.contentMode = UIViewContentModeScaleAspectFit;

    [self.contentView addSubview:_imgDetail];
}

- (void)setImageHeigh:(CGFloat)height
{
    _imgDetail.height = height;
}

@end
