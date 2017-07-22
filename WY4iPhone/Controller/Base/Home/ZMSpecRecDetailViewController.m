//
//  ZMSpecRecDetailViewController.m
//  WY4iPhone
//
//  Created by ZM on 15/10/9.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMSpecRecDetailViewController.h"

@interface ZMSpecRecDetailViewController ()

@end

@implementation ZMSpecRecDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _specRecDict[@"proName"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  加载填充数据
 */
- (void) loadData{
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
    self.user=[ZMUser userWithDict:userDic];
    self.baseRequest = [BaseRequest sharedInstance];
    
    // 请求商品详细信息
    [self requestProDetailById:_specRecDict[@"proId"] userId:self.user.userId];
}

- (void)addToCart:(UIButton *)button{
    self.curSelectedAddProIndex = [_specRecDict[@"proId"] integerValue];
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
  ZMUser*  user=[ZMUser userWithDict:userDic];
    if (!user.userId) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"未登录" message:@"请您先登录！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
        [alert show];
        alert.delegate = self;
        return;
    }
    
    __weak typeof(self) safeSelf = self;
    [self addProToShoppingCarWithProId:_specRecDict[@"proId"] userId:self.user.userId proNum:@"1" success:^{
        [[ZMShoppingCart shoppingCartInstance] refreshShoppingCartWithUserId:safeSelf.user.userId success:^{
            NSInteger count = [safeSelf calculateShoppingCartProNum];
            safeSelf.lableCarCount.hidden = count > 0 ? NO : YES;
            safeSelf.lableCarCount.text = [NSString stringWithFormat:@"%ld", (long)count];
            safeSelf.curSelectedAddProIndex = -1;
        }];
    }];
}


@end
