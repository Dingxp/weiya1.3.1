//
//  GuideScrollView.h
//  WY4iPhone
//
//  Created by 旭朋  丁 on 15/10/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideScrollView : UIScrollView

@property (nonatomic,strong)UIButton *finishButton;

- (void)scrollWithImages:(NSArray *)imageArry;

@end
