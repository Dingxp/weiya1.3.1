//
//  MineCenterTableView.h
//  WY4iPhone
//
//  Created by 旭朋  丁 on 15/9/11.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MineCenterTableView;

@protocol MineCenterCellDelegate <NSObject>

@optional
- (void) mineCenterTableView:(MineCenterTableView *)mineCenterTableView didSelectedAtIndex:(NSIndexPath *)indexPath;

@end

@interface MineCenterTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

// 代金券张数
@property (nonatomic, assign) NSInteger couponNum;

@property (nonatomic, strong) id<MineCenterCellDelegate> mineCenterCellDelegate;

@property (nonatomic, strong) NSString *phoneNum;

@end
