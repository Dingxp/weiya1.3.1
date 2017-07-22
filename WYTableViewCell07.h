//
//  WYTableViewCell07.h
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/12/8.
//  Copyright © 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#define cellImageHeigh              (APP_SCREEN_WIDTH - 20) * 320 / 708
@interface WYTableViewCell07 : UITableViewCell

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *imgDesc;
@property (nonatomic, strong) UILabel *bandName;
@property (nonatomic, strong) UIView *line;

@end
