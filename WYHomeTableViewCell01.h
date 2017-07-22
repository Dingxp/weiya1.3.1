//
//  WYHomeTableViewCell01.h
//  WY4iPhone
//
//  Created by liang.pc on 15/9/11.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#define cellImageHeigh              (APP_SCREEN_WIDTH - 20) * 320 / 708

@interface WYHomeTableViewCell01 : UITableViewCell

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *imgDesc;
@property (nonatomic,strong)UIView *line;
@end
