//
//  WYAShoppingCartListCell.h
//  WY4iPhone
//
//  Created by zhuwei on 15/9/3.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WYASHoppingCartCellDelegate <NSObject>

@required
/**
 *  修改购物车内商品数量
 *
 *  @param addButton 被点击的按钮，其TAG值存放了cell的index
 *  @param count     新的数量
 */
- (void) updateProdouctCountButton:(UIButton  *)button textField:(UITextField *)textField newCount:(NSString*)newCount;

- (void) removeProWithDeleteButton:(UIButton  *)button;

@end

@interface WYAShoppingCartListCell : UITableViewCell

@property (nonatomic, strong) UIImageView *indicatorImageView;
@property (nonatomic, strong) UIImageView *goodsImageView;
@property (nonatomic, strong) UILabel *goodsTitle;
@property (nonatomic, strong) UIButton *cutButton;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UITextField *countTextField;
@property (nonatomic, strong) UILabel *priceTitle;
@property (nonatomic, strong) UIButton *deleteButton;

@property (nonatomic, assign) id<WYASHoppingCartCellDelegate> delegate;

@property (nonatomic, strong) NSDictionary *viewDicts;

@end
