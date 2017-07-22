//
//  UserListTableViewCell.m
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/12/28.
//  Copyright © 2015年 mx. All rights reserved.
//

#import "UserListTableViewCell.h"

@implementation UserListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void) initView{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.width = APP_SCREEN_WIDTH;
    _listImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 40, 40)];
    _listImage.layer.cornerRadius=20;
    [self addSubview:_listImage];
    _listLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 40, 40)];
    _listLab.layer.cornerRadius=20;
    _listLab.textColor=RGBCOLOR(102, 102, 102);
    _listLab.textAlignment=NSTextAlignmentCenter;

    [self addSubview:_listLab];
    _userLab=[[UILabel alloc]initWithFrame:CGRectMake(60, 15, 120, 50)];
    _userLab.textColor=RGBCOLOR(102, 102, 102);

    [self addSubview:_userLab];
    UILabel*makeLab=[[UILabel alloc]initWithFrame:CGRectMake(APP_SCREEN_WIDTH-100, 10, 80, 30)];
    makeLab.text=@"共赚";
    makeLab.textAlignment=NSTextAlignmentRight;
    makeLab.textColor=RGBCOLOR(102, 102, 102);
    [self addSubview:makeLab];
    _moneyab=[[UILabel alloc]initWithFrame:CGRectMake(APP_SCREEN_WIDTH-150, makeLab.bottom, 130, 30)];
    _moneyab.textColor=RGBCOLOR(102, 102, 102);

    _moneyab.textAlignment=NSTextAlignmentRight;

    [self addSubview:_moneyab];
    UIView*line=[[UIView alloc]initWithFrame:CGRectMake(10, 79, APP_SCREEN_WIDTH-20, 1)];
    line.backgroundColor=RGBCOLOR(206, 206, 206);
    [self addSubview:line];
    }


@end
