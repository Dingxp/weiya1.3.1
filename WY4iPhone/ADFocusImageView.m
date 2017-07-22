//
//  ADScrollView.m
//  ScorllViewEndless
//
//  Created by 旭朋  丁 on 15/7/31.
//  Copyright (c) 2015年 旭朋  丁. All rights reserved.
//

#import "ADFocusImageView.h"
#import "UIImageView+WebCache.h"

#define imageWidth      self.frame.size.width
#define imageHeight     self.frame.size.height

@implementation ADFocusImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initView];
    }
    return self;
}

- (void)initView
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, imageHeight)];
    _scrollView.delegate = self;
    _scrollView.backgroundColor = [UIColor lightGrayColor];
    //_scrollView.pagingEnabled = NO;
    //_scrollView.bounces=NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    //_scrollView.bounces = NO;
    //NSLog(@"%f==%f",self.frame.size.width,self.frame.size.height);
   
    [self addSubview:_scrollView];
    scrollPage = 0;
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, imageHeight - 5, imageWidth, 0)];
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:_pageControl];
    
    
   
    
}
-(void)setFromeString:(NSString *)fromeString
{
    _fromeString=fromeString;
    if ([_fromeString isEqualToString:@"1"])
    {
        [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(keepMove) userInfo:nil repeats:YES];
        _num=1;
    }
}
-(void)keepMove
{
    _pageControl.currentPage += _num;
    [UIView beginAnimations:nil context:nil];
   
    [UIView setAnimationDuration:0.3];
    _scrollView.contentOffset = CGPointMake(_pageControl.currentPage*APP_SCREEN_WIDTH, 0);
   
    [UIView commitAnimations];      //执行动画

    
    
    
    if (_pageControl.currentPage == self.imageArry.count-1 || _pageControl.currentPage == 0)
        
    
    {
        _num = - _num;
    }
     [UIView commitAnimations];
   
    
}

- (void)setImageArry:(NSArray *)imageArry
{
    
    for (int i = 0; i < imageArry.count; i++) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(APP_SCREEN_WIDTH * i , 0, APP_SCREEN_WIDTH, imageHeight)];
        image.tag = 11 + i;
       

        [image sd_setImageWithURL:[NSURL URLWithString:imageArry[ i ]]];

        //image.contentMode = UIViewContentModeScaleAspectFill;
        image.userInteractionEnabled = YES;
        [_scrollView addSubview:image];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchImage)];
        [image addGestureRecognizer:tap];
        
        //page ++;
    }
    
    _pageControl.numberOfPages = [imageArry count];
//    _pageControl.hidesForSinglePage = YES;
    _imageArry = imageArry;
     _scrollView.contentSize=CGSizeMake(APP_SCREEN_WIDTH*_imageArry.count, imageHeight);
    
}

#pragma mark -- UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    //NSLog(@"------- %@",NSStringFromCGPoint(scrollView.contentOffset));
    
    //    获取结束减速后的偏移量
    CGPoint point = scrollView.contentOffset;
    
    //    当获得x坐标以后对320 进行取整来控制pagecontrol的点
    int currentNum = point.x/APP_SCREEN_WIDTH;
    
    
    
    
    
    _pageControl.currentPage = currentNum;
    
    //NSLog(@"当前的值是 ==== %d",currentNum);
    
    
}

- (void)touchImage
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(bannerClickDelegate:)]) {
        [self.delegate bannerClickDelegate:_pageControl.currentPage];
    }
}

@end
