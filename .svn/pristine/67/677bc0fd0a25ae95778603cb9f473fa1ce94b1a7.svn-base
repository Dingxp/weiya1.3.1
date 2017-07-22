//
//  WYAShoppingCartListCell.m
//  WY4iPhone
//
//  Created by zhuwei on 15/9/3.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "WYAShoppingCartListCell.h"
#import "BaseRequest.h"

@interface WYAShoppingCartListCell(){
    
}


@end

@implementation WYAShoppingCartListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *indicatorImageView = [UIImageView new];
        indicatorImageView.translatesAutoresizingMaskIntoConstraints = NO;
        indicatorImageView.image = [UIImage imageNamed:@"emptyRing"];
        [self.contentView addSubview:indicatorImageView];
        
        UIImageView *goodsImageView = [UIImageView new];
        goodsImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:goodsImageView];
        
        UILabel *goodsTitle = [UILabel new];
        goodsTitle.translatesAutoresizingMaskIntoConstraints = NO;
        goodsTitle.numberOfLines = 2;
        goodsTitle.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:goodsTitle];
        
        UIButton *cutButton = [UIButton new];
        cutButton.translatesAutoresizingMaskIntoConstraints = NO;
        [cutButton setImage:[UIImage imageNamed:@"cutNumber_btn"] forState:UIControlStateNormal];
        [cutButton addTarget:self action:@selector(cutCount) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:cutButton];
        
        UIButton *addButton = [UIButton new];
        addButton.translatesAutoresizingMaskIntoConstraints = NO;
        [addButton setImage:[UIImage imageNamed:@"addNumber_btn"] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addCount) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:addButton];
        
        UITextField *countTextField = [UITextField new];
        countTextField.translatesAutoresizingMaskIntoConstraints = NO;
        countTextField.background = [UIImage imageNamed:@"numberBackground"];
        countTextField.textAlignment = NSTextAlignmentCenter;
        countTextField.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:countTextField];
        
        UILabel *priceTitle = [UILabel new];
        priceTitle.translatesAutoresizingMaskIntoConstraints = NO;
        priceTitle.font = [UIFont systemFontOfSize:15];
        priceTitle.textColor = RGBCOLOR(255, 0, 90);
        [self.contentView addSubview:priceTitle];
        
        UIButton *deleteButton = [UIButton new];
        deleteButton.translatesAutoresizingMaskIntoConstraints = NO;
        [deleteButton setBackgroundImage:[UIImage imageNamed:@"trash_icon"] forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:deleteButton];
        
        _indicatorImageView = indicatorImageView;
        _goodsImageView = goodsImageView;
        _goodsTitle = goodsTitle;
        _cutButton = cutButton;
        _addButton = addButton;
        _countTextField = countTextField;
        _priceTitle = priceTitle;
        _deleteButton = deleteButton;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[indicatorImageView(20)]-[goodsImageView(80@999)]-[goodsTitle]-60-|" options:0 metrics:nil views:self.viewDicts]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[priceTitle]-|" options:0 metrics:nil views:self.viewDicts]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[goodsImageView]-[cutButton][countTextField(35)][addButton]" options:0 metrics:nil views:self.viewDicts]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[goodsImageView]-|" options:0 metrics:nil views:self.viewDicts]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[goodsTitle]" options:0 metrics:nil views:self.viewDicts]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[cutButton]-|" options:0 metrics:nil views:self.viewDicts]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[addButton]-|" options:0 metrics:nil views:self.viewDicts]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[countTextField]-|" options:0 metrics:nil views:self.viewDicts]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[priceTitle]-2-[deleteButton(30)]" options:0 metrics:nil views:self.viewDicts]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.indicatorImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.indicatorImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.indicatorImageView attribute:NSLayoutAttributeWidth multiplier:1.f constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.goodsImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.goodsImageView attribute:NSLayoutAttributeWidth multiplier:1.f constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.countTextField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.cutButton attribute:NSLayoutAttributeHeight multiplier:1.f constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.priceTitle attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.deleteButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.deleteButton attribute:NSLayoutAttributeHeight multiplier:1.f constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.deleteButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.priceTitle attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0.f]];
}


- (void)cutCount
{
    if ([self.countTextField.text intValue] > 1) {
        NSString*newCount = [NSString stringWithFormat:@"%d", [self.countTextField.text intValue] - 1];
        if (_delegate && [_delegate respondsToSelector:@selector(updateProdouctCountButton:textField:newCount:)]) {
            [_delegate updateProdouctCountButton:_cutButton textField:self.countTextField newCount:newCount];
        }
    }
}

- (void)addCount
{
    NSString*newCount = [NSString stringWithFormat:@"%d", [self.countTextField.text intValue] + 1];
    if (_delegate && [_delegate respondsToSelector:@selector(updateProdouctCountButton:textField:newCount:)]) {
        [_delegate updateProdouctCountButton:_addButton textField:self.countTextField newCount:newCount];
    }
}



/**
 *  删除商品按钮点击事件
 *
 *  @param button
 */
- (void) deleteButtonClicked:(UIButton *)button{
    if ([_delegate respondsToSelector:@selector(removeProWithDeleteButton:)]) {
        [_delegate removeProWithDeleteButton:button];
    }
}

- (NSDictionary *)viewDicts
{
    if (!_viewDicts) {
        _viewDicts = @{
                       @"indicatorImageView" : self.indicatorImageView,
                       @"goodsImageView" : self.goodsImageView,
                       @"goodsTitle" : self.goodsTitle,
                       @"cutButton" : self.cutButton,
                       @"addButton" : self.addButton,
                       @"countTextField" : self.countTextField,
                       @"priceTitle" : self.priceTitle,
                       @"deleteButton" : self.deleteButton,
                       };
    }
    return _viewDicts;
}

@end
