//
//  ZMProDetailTableViewCell.m
//  WY4iPhone
//
//  Created by ZM on 15/9/23.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMProDetailTableViewCell.h"

@implementation ZMProDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return  self;
}

- (void) initView{
    self.width = APP_SCREEN_WIDTH;
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _imgDetail = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0)];
    
//    NSLog(@"before Heigh = %f",_imgDetail.image.size.height);
    _imgDetail.contentMode = UIViewContentModeScaleAspectFit;
    //    _imgDetail.autoresizesSubviews = YES;
    //    _imgDetail.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    _imgDetail.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
//    NSLog(@"after Heigh = %f",_imgDetail.image.size.height);

    [self.contentView addSubview:_imgDetail];
}

- (void)setImageHeigh:(CGFloat)height
{
    _imgDetail.height = height;
}

@end
