//
//  WYAOrderInfoListCell.m
//  WY4iPhone
//
//  Created by zhuwei on 15/9/11.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "WYAOrderInfoListCell.h"

@interface WYAOrderInfoListCell()

@end

@implementation WYAOrderInfoListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 置顶Cell的分割线
        if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
            [self setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
            [self setLayoutMargins:UIEdgeInsetsZero];
        }
        
        UIImageView *goodsImageView = [UIImageView new];
        goodsImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:goodsImageView];
        
        UILabel *goodsTitle = [UILabel new];
        goodsTitle.translatesAutoresizingMaskIntoConstraints = NO;
        goodsTitle.numberOfLines = 0;
        goodsTitle.font = [UIFont systemFontOfSize:15];
        goodsTitle.textColor = RGBCOLOR(53, 53, 53);
        [self.contentView addSubview:goodsTitle];
        
        UILabel *priceTitle = [UILabel new];
        priceTitle.translatesAutoresizingMaskIntoConstraints = NO;
        priceTitle.text = @"￥ 12";
        priceTitle.font = [UIFont systemFontOfSize:14];
        priceTitle.textColor = RGBCOLOR(53, 53, 53);;
        [self.contentView addSubview:priceTitle];
        
        UILabel *numberTitle = [UILabel new];
        numberTitle.translatesAutoresizingMaskIntoConstraints = NO;
        numberTitle.text = @"x1";
        numberTitle.textColor = RGBCOLOR(143, 143, 143);
        numberTitle.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:numberTitle];
        
        self.goodsImageView = goodsImageView;
        self.goodsTitle = goodsTitle;
        self.priceTitle = priceTitle;
        self.numberTitle = numberTitle;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[goodsImageView]-[goodsTitle]-60-|" options:0 metrics:nil views:self.viewDicts]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[priceTitle]-|" options:0 metrics:nil views:self.viewDicts]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[numberTitle]-|" options:0 metrics:nil views:self.viewDicts]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[goodsImageView(80@999)]-|" options:0 metrics:nil views:self.viewDicts]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[goodsTitle]" options:0 metrics:nil views:self.viewDicts]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[priceTitle]-5-[numberTitle]" options:0 metrics:nil views:self.viewDicts]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.goodsImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.goodsImageView attribute:NSLayoutAttributeHeight multiplier:1.f constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.priceTitle attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0.f]];
}

- (NSDictionary *)viewDicts
{
    if (!_viewDicts) {
        _viewDicts = @{
                       @"goodsImageView" : self.goodsImageView,
                       @"goodsTitle" : self.goodsTitle,
                       @"numberTitle" : self.numberTitle,
                       @"priceTitle" : self.priceTitle,
                       };
    }
    return _viewDicts;
}


@end
