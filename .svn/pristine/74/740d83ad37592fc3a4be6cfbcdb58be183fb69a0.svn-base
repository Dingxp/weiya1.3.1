//
//  ZMApplyRetGTableViewCell.h
//  WY4iPhone
//
//  Created by ZM on 15/9/21.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZMApplyRetGTableViewCellDelegate <NSObject>

@required
/**
 *  减少商品数量
 *
 *  @param addButton 被点击的按钮，其TAG值存放了cell的index
 *  @param count     新的数量
 */
- (void) subButton:(UIButton  *)button curCountStr:(NSString *)count;

/**
 *  添加商品数量
 *
 *  @param addButton 被点击的按钮，其TAG值存放cell的index
 *  @param count     新的数量
 */
- (void) addButton:(UIButton  *)button curCountStr:(NSString *)count;

@end

@interface ZMApplyRetGTableViewCell : UITableViewCell

// 多选时的指示器（显示勾或圆圈）
@property (nonatomic, strong) UIImageView *imgViewIndicate;
@property (nonatomic, strong) UIImageView *imgViewHead;
@property (nonatomic, strong) UILabel *labelProductName;
@property (nonatomic, strong) UILabel *labelPrice;
@property (nonatomic, strong) UILabel *labelCount;
@property (nonatomic, strong) UITextField *textFieldCount;
@property (nonatomic, strong) UIButton *btnSub;
@property (nonatomic, strong) UIButton *btnAdd;

@property (nonatomic, assign) NSInteger maxCount;

@property (nonatomic, assign) id<ZMApplyRetGTableViewCellDelegate> delegate;

@end
