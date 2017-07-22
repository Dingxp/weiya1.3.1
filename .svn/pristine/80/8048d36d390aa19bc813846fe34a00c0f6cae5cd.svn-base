//
//  WY4iPhone
//
//  Created by ZM21 on 15/9/12.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMProduct.h"
#import "LoginViewController.h"
#import "UIImageView+WebCache.h"
#import "BaseRequest.h"
#import "ZMUser.h"
#import "ZMProductDetail.h"
#import "ZMProDetailTableView.h"
#import "ZMShoppingCart.h"
#import "WYAShoppingCartViewController.h"
#import "UMSocial.h"
#import "ChannelItem.h"
#import "ZMChannelItem.h"
@interface ProDetailViewController : UIViewController <UIAlertViewDelegate,UMSocialUIDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) ZMProduct *product;
@property (nonatomic, strong) BaseRequest *baseRequest;
@property (nonatomic, strong) ZMUser *user;
@property (nonatomic, assign) NSInteger curSelectedAddProIndex;
// 购车button上的小圆圈现实的uilabel
@property (nonatomic, strong) UILabel *lableCarCount;
@property (nonatomic, strong)NSString*idString;
@property (nonatomic, strong)ZMChannelItem *channelItem;
@property (nonatomic, strong)NSString* cItemIdStr;

- (void) loadData;
- (void) requestProDetailById:(NSString *) proId userId: (NSString *)userId;
- (void) addToCart:(UIButton *)button;
- (void) addProToShoppingCarWithProId:(NSString *)productId userId:(NSString *)userId proNum:(NSString *)proNum success:(void (^)())success;
- (NSInteger) calculateShoppingCartProNum;

//分享按钮
- (void)shareAction;

- (UIImage *)getProImage;


@end
