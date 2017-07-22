//
//  EducationTableViewCell.m
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/12/18.
//  Copyright © 2015年 mx. All rights reserved.
//

#import "EducationTableViewCell.h"

@implementation EducationTableViewCell

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
    UIView*backView=[[UIView alloc]initWithFrame:CGRectMake(10, 15, APP_SCREEN_WIDTH-20, 250)];
    backView.layer.borderColor = RGBCOLOR(216, 216, 216).CGColor;
    backView.layer.cornerRadius=5;
    backView.layer.borderWidth = 1;
    [self addSubview:backView];
    
    _titleLab=[[UILabel alloc]initWithFrame:CGRectMake(20, 15, APP_SCREEN_WIDTH, 30)];
    _titleLab.textColor=[UIColor blackColor];
   
    [self addSubview:_titleLab];
    _titleImage=[[UIImageView alloc]initWithFrame:CGRectMake(20, _titleLab.bottom+5, APP_SCREEN_WIDTH-40, 140)];
    [self addSubview:_titleImage];
    _describeLab=[[UILabel alloc]initWithFrame:CGRectMake(_titleImage.left+10, _titleImage.bottom+5 , 200, 30)];
    _describeLab.font=[UIFont systemFontOfSize:15];
    _describeLab.textColor=RGBCOLOR(177, 177, 177);
    [self addSubview:_describeLab];
    _dateLab=[[UILabel alloc]initWithFrame:CGRectMake(_titleImage.left+10, _describeLab.bottom+5 , 150, 20)];
    _dateLab.textColor=RGBCOLOR(177, 177, 177);
    _dateLab.font=[UIFont systemFontOfSize:13];
    [self addSubview:_dateLab];
    UIImageView*readImage=[[UIImageView alloc]initWithFrame:CGRectMake(APP_SCREEN_WIDTH-90, _describeLab.bottom+5, 20, 20)];
    readImage.image=[UIImage imageNamed:@"readed"];
    [self addSubview:readImage];
    _readLab=[[UILabel alloc]initWithFrame:CGRectMake(APP_SCREEN_WIDTH-65, _describeLab.bottom+5 , 50, 20)];
    _readLab.textColor=RGBCOLOR(177, 177, 177);
     _readLab.font=[UIFont systemFontOfSize:13];
    [self addSubview:_readLab];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
