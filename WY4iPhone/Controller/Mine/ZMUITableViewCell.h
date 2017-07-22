//
//  ZMUITableViewCell.h
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/11/19.
//  Copyright © 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMProduct.h"
#import "ZMChannelItem.h"
@interface ZMUITableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView*decImage;
@property (nonatomic,strong) UILabel*countPriceLab;
@property (nonatomic,strong) UILabel*nameLab;
@property(nonatomic,strong)  ZMChannelItem*channelItem;
@end
