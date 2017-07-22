//
//  WYAOrderInfoListCell.h
//  WY4iPhone
//
//  Created by zhuwei on 15/9/11.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYAOrderInfoListCell : UITableViewCell

@property (nonatomic, strong) UIImageView *goodsImageView;
@property (nonatomic, strong) UILabel *goodsTitle;
@property (nonatomic, strong) UILabel *numberTitle;
@property (nonatomic, strong) UILabel *priceTitle;

@property (nonatomic, strong) NSDictionary *viewDicts;

@end
