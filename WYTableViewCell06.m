//
//  WYTableViewCell06.m
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/11/20.
//  Copyright © 2015年 mx. All rights reserved.
//

#import "WYTableViewCell06.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
@implementation WYTableViewCell06
#define cellImageHeigh              (APP_SCREEN_WIDTH - 20) * 320 / 708
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)initView

{    //判断传过来的数组个数，进行放置图片
    if (_detailArray.count==1) //当个数为1时
    {
        [self firstCount];
    }
    if (_detailArray.count==2)//  为2时
    {
        [self secondCount];
    }
    if (_detailArray.count==3) // 为3时
    {
        [self thirdCount];
    }
    
}
-(void)firstCount
{
    
    _firstBtn=[UIButton new];
    _firstBtn.frame=CGRectMake(10, 10, APP_SCREEN_WIDTH-20, cellImageHeigh);
    [_firstBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:_detailArray[0]] forState:UIControlStateNormal];
    _firstBtn.tag=10;
    [self.contentView addSubview:_firstBtn];
    
    
}
-(void)secondCount
{
    _firstBtn=[UIButton new];
    _firstBtn.frame=CGRectMake(10, 10, APP_SCREEN_WIDTH/2 -15, cellImageHeigh);
    _firstBtn.tag=10;
    [_firstBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:_detailArray[0]] forState:UIControlStateNormal];
    [self.contentView addSubview:_firstBtn];
    _secondBtn=[UIButton new];
    _secondBtn.frame=CGRectMake(_firstBtn.right+10, 10, APP_SCREEN_WIDTH/2 -15, cellImageHeigh);
    [_secondBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:_detailArray[1]] forState:UIControlStateNormal];
    _secondBtn.tag=11;
    [self.contentView addSubview:_secondBtn];
    
}
-(void)thirdCount
{
    _firstBtn=[UIButton new];
    _firstBtn.frame=CGRectMake(10, 10, APP_SCREEN_WIDTH/2 -13, cellImageHeigh);
    [_firstBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:_detailArray[0]] forState:UIControlStateNormal];
    _firstBtn.tag=10;
    [self.contentView addSubview:_firstBtn];
    _secondBtn=[UIButton new];
    _secondBtn.tag=11;
    _secondBtn.frame=CGRectMake(_firstBtn.right+6, 10, APP_SCREEN_WIDTH/2 -13, cellImageHeigh/2-3);
    [_secondBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:_detailArray[1]] forState:UIControlStateNormal];
    [self.contentView addSubview:_secondBtn];
    _thirdBtn=[UIButton new];
    _thirdBtn.frame=CGRectMake(_firstBtn.right+6, _secondBtn.bottom+6, APP_SCREEN_WIDTH/2-13, cellImageHeigh/2-3);
    [_thirdBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:_detailArray[2]] forState:UIControlStateNormal];
    _thirdBtn.tag=12;
    [self.contentView addSubview:_thirdBtn];
    
    
}
-(void)setDetailArray:(NSArray *)detailArray
{
    _detailArray=detailArray;
    [self initView];
    
}
-(void)onImageViewClicked:(UITapGestureRecognizer*)tap
{
    
}
@end
