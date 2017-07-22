//
//  WYAShoppingCartViewController.h
//  WY4iPhone
//
//  Created by mx on 15/8/31.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYAShoppingCartListCell.h"

@interface WYAShoppingCartViewController : UIViewController <WYASHoppingCartCellDelegate,UIAlertViewDelegate>
@property (nonatomic,strong)  NSArray*ProList;
@end
