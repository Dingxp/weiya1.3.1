//
//  ZMContactTableViewCell.m
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/12/15.
//  Copyright © 2015年 mx. All rights reserved.
//

#import "ZMContactTableViewCell.h"

@implementation ZMContactTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.width = APP_SCREEN_WIDTH;
        [self initView];
    }
    return self;
}
-(void)initView
{
    _btn=[UIButton new];
    _btn.frame=CGRectMake(APP_SCREEN_WIDTH-70, 20, 60, 30);
    [_btn setTitle:@"邀请" forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _btn.layer.borderColor = [UIColor grayColor].CGColor;
    _btn.layer.borderWidth = 1;
    _btn.layer.cornerRadius=5;
    [self addSubview:_btn];
}


@end
