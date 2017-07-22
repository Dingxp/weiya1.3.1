//
//  WYAOrderCostListCell.m
//  WY4iPhone
//
//  Created by zhuwei on 15/9/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "WYAOrderCostListCell.h"

@interface WYAOrderCostListCell()

@end

@implementation WYAOrderCostListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *titleLabel = [UILabel new];
        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:titleLabel];
        
        UILabel *priceLabel = [UILabel new];
        priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
        priceLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:priceLabel];
        
        self.titleLabel = titleLabel;
        self.priceLabel = priceLabel;
        
        NSDictionary *viewDicts = NSDictionaryOfVariableBindings(_titleLabel, _priceLabel);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[_titleLabel]" options:0 metrics:nil views:viewDicts]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_priceLabel]-|" options:0 metrics:nil views:viewDicts]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0.f]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.priceLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0.f]];
    }
    return self;
}

@end
