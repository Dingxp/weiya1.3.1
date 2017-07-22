//
//  ZMProDetailTableView.h
//  WY4iPhone
//
//  Created by ZM on 15/9/23.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADFocusImageView.h"
#import "ZMUIImageUtil.h"
#import "ZMShopScrollView.h"
@class ZMProductDetail;


@interface ZMProDetailTableView : UITableView <UITableViewDelegate, UITableViewDataSource,ADFoucsDelegate>

@property (nonatomic, strong) ZMProductDetail *proDetail;
@property (nonatomic, assign) CGFloat headViewHeight;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIView *blackLine;
@property (nonatomic, strong) UIButton*collectBtn; // 收藏按钮
@property (nonatomic, strong) UIButton*shareBtn;  //  分享按钮
@property (nonatomic, strong) UIView *collectView;
@property (nonatomic, strong) UIView *shareView;
@property (nonatomic, strong) UIImageView*collectImage;;
@property (nonatomic, strong) ZMShopScrollView *loopingView;
- (void)loadData;

- (UIImage *)getTableHeaderImage;

@end
