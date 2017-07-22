//
//  WY4iPhone
//
//  Created by ZM21 on 15/9/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "ChannelItem.h"
#import "UIImageView+WebCache.h"
#import "ZMChannelItem.h"
#import "ZMBrandItemViewController.h"
#import "ZMProduct.h"
#import "ZMBand.h"
#import <UIKit/UIKit.h>
@interface ProListViewController : UICollectionViewController
@property (nonatomic, strong) UICollectionView *collectionView;


@property (nonatomic, strong) ChannelItem *cItem;
@property (nonatomic, strong)NSString*backStr;
@property (nonatomic, strong)ZMProduct*product;

//品牌
@property (nonatomic, strong)ZMBand*band;
@end