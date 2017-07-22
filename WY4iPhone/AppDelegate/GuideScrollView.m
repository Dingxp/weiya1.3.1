//
//  GuideScrollView.m
//  WY4iPhone
//
//  Created by 旭朋  丁 on 15/10/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "GuideScrollView.h"

@implementation GuideScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
    }
    return self;
}

- (void)scrollWithImages:(NSArray *)imageArry
{
    CGFloat btnW = (APP_SCREEN_WIDTH - 25 * 2 - 15) / 3;
    self.contentSize = CGSizeMake(APP_SCREEN_WIDTH*imageArry.count, self.height);
    for (int i=0; i<imageArry.count; i++) {
        UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(i * APP_SCREEN_WIDTH, 0, APP_SCREEN_WIDTH, self.height)];
        img.image=[UIImage imageNamed:imageArry[i]];
        img.userInteractionEnabled = YES;
        [self addSubview:img];
        if (i == imageArry.count - 1) {
            _finishButton = [[UIButton alloc]initWithFrame:CGRectMake((self.width - btnW) / 2, self.height - 10 - 40, btnW, 40)];
            _finishButton.backgroundColor = RGBCOLOR(255, 0, 90);
            _finishButton.layer.cornerRadius = 5;
            [_finishButton setTitle:@"进入首页" forState:UIControlStateNormal];
            _finishButton.titleLabel.font = [UIFont systemFontOfSize:16];
            [img addSubview:_finishButton];
            
            [_finishButton addTarget:self action:@selector(removeGuideView) forControlEvents:UIControlEventTouchUpInside];
            
            UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(removeGuideView)];
            swipe.direction = UISwipeGestureRecognizerDirectionLeft;
            [img addGestureRecognizer:swipe];
        }
    }
}

- (void)removeGuideView
{
    [self removeFromSuperview];
}


@end
