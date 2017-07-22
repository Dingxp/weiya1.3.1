//
//  ZMRecommendTableViewCell.h
//  WY4iPhone
//
//  Created by ZM21 on 15/9/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMRecommendTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgPorduct;
@property (nonatomic, strong) UILabel *labelProductName;
@property (nonatomic, strong) UILabel *labelRecommendReason;
@property (nonatomic, strong) UILabel *lableCurrentPrice;
@property (nonatomic, strong) UILabel *labelOrigalPrice;
@property (nonatomic, strong) UIButton *btnDetails;

@end
