//
//  ZMOrderDetailTableViewCell.m
//  WY4iPhone
//
//  Created by liang.pc on 15/9/15.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMOrderDetailTableViewCell.h"

@implementation ZMOrderDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void) initView{
    self.width = APP_SCREEN_WIDTH;
    self.height = 100;
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 置顶Cell的分割线
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
    
    CGFloat imgViewHeadW = 70;
    CGFloat imgViewHeadH = 70;
    _imgViewHead = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, imgViewHeadW, imgViewHeadH)];
    _imgViewHead.contentMode = UIViewContentModeScaleAspectFill;
    _imgViewHead.layer.masksToBounds = YES;
    [self addSubview:_imgViewHead];
    
    _labelProductName = [[UILabel alloc] initWithFrame:CGRectMake(_imgViewHead.right + 14, _imgViewHead.top, self.width / 2, _imgViewHead.height)];
    _labelProductName.font  = [UIFont systemFontOfSize:15];
    _labelProductName.textColor = RGBCOLOR(53, 53, 53);
    _labelProductName.numberOfLines = 0;
    [self addSubview:_labelProductName];
    
    CGFloat fontSize = 14;
    CGFloat labelW = 100;
    _labelPrice = [[UILabel alloc] initWithFrame:CGRectMake(self.width - 10 - labelW, (self.height - fontSize) / 2, 100, fontSize)];
    _labelPrice.textColor = [UIColor blackColor];
    _labelPrice.font = [UIFont systemFontOfSize:fontSize];
    _labelPrice.textAlignment = NSTextAlignmentRight;
    [self addSubview:_labelPrice];
    
    _labelCount = [[UILabel alloc] initWithFrame:CGRectMake(self.width - 10 - labelW, _labelPrice.bottom + 10, _labelPrice.width, fontSize)];
    _labelCount.textColor = RGBCOLOR(162, 162, 162);
    _labelCount.font = [UIFont systemFontOfSize:fontSize];
    _labelCount.textAlignment = NSTextAlignmentRight;
    [self addSubview:_labelCount];

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
