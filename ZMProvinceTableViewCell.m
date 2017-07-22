//
//  ZMProvinceTableViewCell.m
//  WY4iPhone
//
//  Created by ZM21 on 15/9/27.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMProvinceTableViewCell.h"

@implementation ZMProvinceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void) initView{
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _imgIndicate = [[UIImageView alloc] initWithFrame:CGRectMake(10, (45 - 20) / 2, 20, 20)];
    [self addSubview:_imgIndicate];
    
    _labelProvince = [[UILabel alloc] initWithFrame:CGRectMake(_imgIndicate.right + 14, (45 - 15) / 2, 200, 15)];
    _labelProvince.font = [UIFont systemFontOfSize:15];
    _labelProvince.textColor = RGBCOLOR(188, 188, 188);
    [self addSubview:_labelProvince];
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (!selected) {
        _imgIndicate.image = [UIImage imageNamed:@"emptyRing"];
    } else {
        _imgIndicate.image = [UIImage imageNamed:@"hookRing"];
    }
}

@end
