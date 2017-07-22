//
//  ZMProDetailTableViewCell.h
//  WY4iPhone
//
//  Created by ZM on 15/9/23.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMProDetailTableViewCell : UITableViewCell

//#define kCellHeight    (APP_SCREEN_WIDTH / 1.3)

@property (nonatomic, strong) UIImageView *imgDetail;
@property (nonatomic, strong) UIImageView *careImage;
- (void)setImageHeigh:(CGFloat)height;

@end
