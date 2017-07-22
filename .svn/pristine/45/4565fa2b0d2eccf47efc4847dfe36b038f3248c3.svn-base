//
//  ZMApplyRetGTableViewCell.m
//  WY4iPhone
//
//  Created by ZM on 15/9/21.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMApplyRetGTableViewCell.h"

@implementation ZMApplyRetGTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void) initView{
    self.width = APP_SCREEN_WIDTH;
    self.height = 145;
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

    _imgViewIndicate = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15 + (imgViewHeadH - 20) / 2, 20, 20)];
    _imgViewIndicate.image = [UIImage imageNamed:@"emptyRing"];
    [self addSubview:_imgViewIndicate];
    
    _imgViewHead = [[UIImageView alloc] initWithFrame:CGRectMake(_imgViewIndicate.right + 15, 15, imgViewHeadW, imgViewHeadH)];
    _imgViewHead.contentMode = UIViewContentModeScaleAspectFill;
    _imgViewHead.layer.masksToBounds = YES;
    [self addSubview:_imgViewHead];
    
    _labelProductName = [[UILabel alloc] initWithFrame:CGRectMake(_imgViewHead.right + 5, _imgViewHead.top, self.width / 2 - 20, 70)];
    _labelProductName.font  = [UIFont systemFontOfSize:15];
    _labelProductName.textColor = RGBCOLOR(101, 101, 101);
    _labelProductName.numberOfLines = 0;
    [self addSubview:_labelProductName];
    
    CGFloat fontSize = 14;
    CGFloat labelW = 100;
    _labelPrice = [[UILabel alloc] initWithFrame:CGRectMake(self.width - 10 - labelW, (100 - fontSize) / 2, 100, 14)];
    _labelPrice.textColor = [UIColor blackColor];
    _labelPrice.font = [UIFont systemFontOfSize:fontSize];
    _labelPrice.textAlignment = NSTextAlignmentRight;
    [self addSubview:_labelPrice];
    
    _labelCount = [[UILabel alloc] initWithFrame:CGRectMake(self.width - 10 - labelW, _labelPrice.bottom + 10, _labelPrice.width, fontSize)];
    _labelCount.textColor = RGBCOLOR(162, 162, 162);
    _labelCount.font = [UIFont systemFontOfSize:12];
    _labelCount.textAlignment = NSTextAlignmentRight;
    [self addSubview:_labelCount];
    
    // 退货数量
    
    UILabel *lbReturnCount = [[UILabel alloc] initWithFrame:CGRectMake(_imgViewHead.left, _imgViewHead.bottom + 15 + 7, 60, 16)];
    lbReturnCount.text = @"退货数量";
    lbReturnCount.textColor = RGBCOLOR(152, 152, 152);
    lbReturnCount.font = [UIFont systemFontOfSize:15];
    [self addSubview:lbReturnCount];
    
    CGFloat btnW = 30;
    CGFloat btnH = 30;
    UIButton *btnSub = [[UIButton alloc] initWithFrame:CGRectMake(APP_SCREEN_WIDTH - btnW * 3 - 10, lbReturnCount.top, btnW, btnH)];
    btnSub.backgroundColor = [UIColor whiteColor];
    btnSub.layer.borderWidth  = 1;
    btnSub.layer.borderColor = RGBCOLOR(222, 222, 222).CGColor;
    [btnSub setBackgroundImage:[UIImage imageNamed:@"cutNumber_btn"] forState:UIControlStateNormal];
    [btnSub addTarget:self action:@selector(btnSubClicked:) forControlEvents:UIControlEventTouchUpInside];
    _btnSub = btnSub;
    [self addSubview:_btnSub];
    
    _textFieldCount = [[UITextField alloc] initWithFrame:CGRectMake(btnSub.right, btnSub.top, btnSub.width, btnSub.height)];
    _textFieldCount.text = @"1";
    _textFieldCount.layer.borderWidth = 1;
    _textFieldCount.layer.borderColor = RGBCOLOR(222, 222, 222).CGColor;
    _textFieldCount.textColor = RGBCOLOR(53, 53, 53);
    _textFieldCount.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_textFieldCount];
    
    UIButton *btnAdd = [[UIButton alloc] initWithFrame:CGRectMake(_textFieldCount.right, btnSub.top, btnSub.width, btnSub.height)];
    btnAdd.backgroundColor = [UIColor whiteColor];
    btnAdd.layer.borderWidth  = 1;
    btnAdd.layer.borderColor = RGBCOLOR(222, 222, 222).CGColor;
    [btnAdd setBackgroundImage:[UIImage imageNamed:@"addNumber_btn"] forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(btnAddClicked:) forControlEvents:UIControlEventTouchUpInside];
    _btnAdd = btnAdd;
    [self addSubview:_btnAdd];
}

//- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
//    [super setHighlighted:highlighted animated:animated];
//    if (highlighted) {
//        self.backgroundColor = [UIColor colorWithRed:240.f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
//    }else{
//        self.backgroundColor = [UIColor whiteColor];
//    }
//}

- (void) btnSubClicked:(UIButton *)button{
    if ([_textFieldCount.text intValue] > 1) {
        _textFieldCount.text = [NSString stringWithFormat:@"%d", [_textFieldCount.text intValue] - 1];
        if (_delegate && [_delegate respondsToSelector:@selector(subButton:curCountStr:)]) {
            [_delegate subButton:_btnSub curCountStr:_textFieldCount.text];
        }
    }
}

- (void) btnAddClicked:(UIButton *)button{
//        _textFieldCount.text = [NSString stringWithFormat:@"%d", [_textFieldCount.text intValue] + 1];
        if (_delegate && [_delegate respondsToSelector:@selector(addButton:curCountStr:)]) {
            [_delegate addButton:_btnAdd curCountStr:_textFieldCount.text];
        }
    
}

@end
