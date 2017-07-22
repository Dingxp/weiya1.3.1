//
//  WYAPayInfoListCell.m
//  WY4iPhone
//
//  Created by zhuwei on 15/9/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "WYAPayInfoListCell.h"

@interface WYAPayInfoListCell()

@end

@implementation WYAPayInfoListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *indicatorImageView = [UIImageView new];
        indicatorImageView.translatesAutoresizingMaskIntoConstraints = NO;
        indicatorImageView.image = [UIImage imageNamed:@"emptyRing"];
        [self.contentView addSubview:indicatorImageView];
        self.indicatorImageView = indicatorImageView;
        
        UIImageView *logoImageView = [UIImageView new];
        logoImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:logoImageView];
        
        UILabel *payTitle = [UILabel new];
        payTitle.translatesAutoresizingMaskIntoConstraints = NO;
        payTitle.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:payTitle];
        
        UILabel *detailTitle = [UILabel new];
        detailTitle.translatesAutoresizingMaskIntoConstraints = NO;
        detailTitle.textColor = [UIColor grayColor];
        detailTitle.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:detailTitle];
        
        NSDictionary *viewDicts = NSDictionaryOfVariableBindings(indicatorImageView, logoImageView, payTitle, detailTitle);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[indicatorImageView]-[logoImageView(40)]-[payTitle]" options:0 metrics:nil views:viewDicts]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[indicatorImageView]-[logoImageView]-[detailTitle]" options:0 metrics:nil views:viewDicts]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[logoImageView(40)]-|" options:0 metrics:nil views:viewDicts]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[payTitle]" options:0 metrics:nil views:viewDicts]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[detailTitle]-|" options:0 metrics:nil views:viewDicts]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:indicatorImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0.f]];
        
        self.logoImageView = logoImageView;
        self.payTitle = payTitle;
        self.detailTitle = detailTitle;
    }
    return self;
}

- (void)setSelected:(BOOL)selected{

}

@end
