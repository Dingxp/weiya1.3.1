//
//  WYAAddressListCell.m
//  WY4iPhone
//
//  Created by zhuwei on 15/9/13.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "WYAAddressListCell.h"

@implementation WYAAddressListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
            [self setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
            [self setLayoutMargins:UIEdgeInsetsZero];
        }
        
        CGFloat font = 14;
        _nameTitle = [UILabel new];
        _nameTitle.translatesAutoresizingMaskIntoConstraints = NO;
        _nameTitle.font = [UIFont systemFontOfSize:font];
        [self.contentView addSubview:_nameTitle];
        
        _phoneTitle = [UILabel new];
        _phoneTitle.translatesAutoresizingMaskIntoConstraints = NO;
        _phoneTitle.font = [UIFont systemFontOfSize:font];
        [self.contentView addSubview:_phoneTitle];
        
        _generalTitle = [UILabel new];
        _generalTitle.translatesAutoresizingMaskIntoConstraints = NO;
        _generalTitle.textColor = [UIColor grayColor];
        _generalTitle.font = [UIFont systemFontOfSize:font];
        [self.contentView addSubview:_generalTitle];
        
        _detailTitle = [UILabel new];
        _detailTitle.translatesAutoresizingMaskIntoConstraints = NO;
        _detailTitle.textColor = [UIColor grayColor];
        _detailTitle.font = [UIFont systemFontOfSize:font];
        [self.contentView addSubview:_detailTitle];
        
        _imgIndicate = [[UIImageView alloc] initWithFrame:CGRectMake(APP_SCREEN_WIDTH - 20 - 10 - 10, (90 - 20) / 2, 20, 20)];
        [self addSubview:_imgIndicate];
        
        NSDictionary *viewDicts = NSDictionaryOfVariableBindings(_nameTitle, _phoneTitle, _generalTitle, _detailTitle);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[_nameTitle]-[_phoneTitle]" options:0 metrics:nil views:viewDicts]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[_generalTitle]" options:0 metrics:nil views:viewDicts]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[_detailTitle]" options:0 metrics:nil views:viewDicts]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_nameTitle]-[_generalTitle]-[_detailTitle]-|" options:0 metrics:nil views:viewDicts]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_phoneTitle]" options:0 metrics:nil views:viewDicts]];
    }
    return self;
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
