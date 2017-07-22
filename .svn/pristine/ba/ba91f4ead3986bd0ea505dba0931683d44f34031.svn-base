//
//  WYHomeTableViewCell02.m
//  WY4iPhone
//
//  Created by liang.pc on 15/9/11.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "WYHomeTableViewCell02.h"
#import "UIImageView+WebCache.h"

@implementation WYHomeTableViewCell02

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.width = APP_SCREEN_WIDTH;
    }
    return self;
}

- (void) initView{
    
    CGFloat imgH = 75;
    CGFloat imgW = APP_SCREEN_WIDTH / 2;
//    CGFloat leftSpace = 10;
//    CGFloat space = self.width - leftSpace*2 - imgW*2;
    CGFloat space = 0;
    CGFloat top = 10;
    
    int cloumn = 2;
    for (int i = 0; i < _imgUrlArray.count; i++) {
        CGFloat x =  (space + imgW)* (i % cloumn);
        _imgView01 = [[UIImageView alloc] initWithFrame:CGRectMake( x, (top + imgH) * (i / cloumn), imgW, imgH)];
        _imgView01.contentMode = UIViewContentModeScaleAspectFit;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onImageViewClicked:)];
        _imgView01.tag = i;
        _imgView01.userInteractionEnabled = YES;
        
        [_imgView01 sd_setImageWithURL:[NSURL URLWithString:_imgUrlArray[i]]];
        //NSLog(@"%ld",_imgView01.tag);
        [self.contentView addSubview:_imgView01];
        [_imgView01 addGestureRecognizer:tap];
    }
}

- (void) onImageViewClicked:(UITapGestureRecognizer *)tap{
    if (self.delegate && [self.delegate respondsToSelector:@selector(WYHomeTableViewCell02ItemClickedAtIndex:)]) {
        [_delegate WYHomeTableViewCell02ItemClickedAtIndex:tap.view.tag];
    }
}

- (void)setImgUrlArray:(NSArray *)imgUrlArray{
    _imgUrlArray = imgUrlArray;
    [self initView];
}
@end
