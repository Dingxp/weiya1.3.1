//
//  WYTableViewCell05.m
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/11/20.
//  Copyright © 2015年 mx. All rights reserved.
//

#import "WYTableViewCell05.h"
#import "UIImageView+WebCache.h"
@implementation WYTableViewCell05
#define cellImageHeigh              (APP_SCREEN_WIDTH - 20) * 320 / 708
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)initWith
{
    self.backgroundColor = [UIColor whiteColor];
    
    
        
    //判断数组的个数进行不同的类型排版
    if (_detailArray.count==1)//  当个数为1
    {
        [self firstCount];
        
    }
    if (_detailArray.count%2 ==0)// 当个数为偶数
    {
        [self secondCount];
    }
    if (_detailArray.count>2&&_detailArray.count%2 ==1)//当为奇数（1除外）
    {
        
        [self thirdCount];
    
     }
    
}
-(void)firstCount
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onImageViewClicked:)];
    _imgView01=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, APP_SCREEN_WIDTH-20, cellImageHeigh)];
    _imgView01.contentMode=UIViewContentModeScaleAspectFit;
    _imgView01.tag=0;
    _imgView01.userInteractionEnabled = YES;
    [_imgView01 sd_setImageWithURL:[NSURL URLWithString:_detailArray[0]]];
    [self.contentView addSubview:_imgView01];
    [_imgView01 addGestureRecognizer:tap];
 
}
-(void)secondCount
{
   
    CGFloat imgW = APP_SCREEN_WIDTH / 2-13;
    
   
    CGFloat top = 10;
    
    int cloumn = 2;
    for (int i = 0; i < _detailArray.count; i++) {
        CGFloat x =  (6 + imgW)* (i % cloumn);
        _imgView01 = [[UIImageView alloc] initWithFrame:CGRectMake( 10+x, (top + cellImageHeigh) * (i / cloumn), imgW, cellImageHeigh)];
        //_imgView01.contentMode = UIViewContentModeScaleAspectFit;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onImageViewClicked:)];
        _imgView01.tag = i;
        _imgView01.userInteractionEnabled = YES;
        
        [_imgView01 sd_setImageWithURL:[NSURL URLWithString:_detailArray[i]]];
       
        [self.contentView addSubview:_imgView01];
        [_imgView01 addGestureRecognizer:tap];
    }
  
}
-(void)thirdCount
{
    
    CGFloat imgW = APP_SCREEN_WIDTH / 2-13;
    
       CGFloat top = 6;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onImageViewClicked:)];
    _firstImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, APP_SCREEN_WIDTH-20, cellImageHeigh)];
    //_firstImage.contentMode=UIViewContentModeScaleAspectFit;
    _firstImage.tag=0;
    _firstImage.userInteractionEnabled=YES;
    [_firstImage sd_setImageWithURL:[NSURL URLWithString:_detailArray[0]]];
    [self.contentView addSubview:_firstImage];
    
    
    [_firstImage addGestureRecognizer:tap];
    
    
    
    int cloumn = 2;
    for (int i = 1; i < _detailArray.count; i++)
    {
        CGFloat x =  (6 + imgW)* (i % cloumn);
        NSInteger a ;
        a=i-1;
        _imgView01 = [[UIImageView alloc] initWithFrame:CGRectMake(10+ x,_firstImage.bottom+6+ (top + cellImageHeigh) * (a / cloumn), imgW, cellImageHeigh)];
        //_imgView01.contentMode = UIViewContentModeScaleAspectFit;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onImageViewClicked:)];
        _imgView01.tag = i;
        _imgView01.userInteractionEnabled = YES;
        
        [_imgView01 sd_setImageWithURL:[NSURL URLWithString:_detailArray[i]]];
        //NSLog(@"%ld",_imgView01.tag);
        [self.contentView addSubview:_imgView01];
        [_imgView01 addGestureRecognizer:tap];    }
 
}
-(void)setDetailArray:(NSArray *)detailArray
{
    _detailArray=detailArray;
    [self initWith];
}
-(void)onImageViewClicked:(UITapGestureRecognizer*)tap
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(themeDelegateClickedAtIndex:)])
    {
        [_delegate themeDelegateClickedAtIndex:tap.view.tag];
    }
}
@end
