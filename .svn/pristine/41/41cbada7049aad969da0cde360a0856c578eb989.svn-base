//
//  ADScrollView.h
//  ScorllViewEndless
//
//  Created by 旭朋  丁 on 15/7/31.
//  Copyright (c) 2015年 旭朋  丁. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ADFoucsDelegate <NSObject>

@optional

- (void)bannerClickDelegate:(NSInteger)itemIndex;

@end

@interface ADFocusImageView : UIView<UIScrollViewDelegate>{
    int scrollPage;
    UIScrollView *_scrollView;
    NSTimer *_timer;
    NSInteger _num;
}

@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) NSArray *imageArry;
@property (nonatomic,strong) NSString*fromeString;
@property (nonatomic,assign) id <ADFoucsDelegate> delegate;

@end
