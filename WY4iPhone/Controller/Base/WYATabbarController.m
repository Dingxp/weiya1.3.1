//
//  APOTabbarController.m
//  WY4iPhone
//
//  Created by mx on 15/8/31.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "WYATabbarController.h"
#import "WYAHomeViewController.h"
#import "WYAMineViewController.h"
#import "WYAShoppingCartViewController.h"
#import "ZMEntrepreneurshipViewController2.h"

@interface WYATabbarController ()

@end

@implementation WYATabbarController

- (void)viewDidLoad {

    WYAHomeViewController* homeViewController = [WYAHomeViewController new];
    WYAShoppingCartViewController* orderViewController = [WYAShoppingCartViewController new];
    WYAMineViewController* mineViewController = [WYAMineViewController new];
    ZMEntrepreneurshipViewController2 *entrepreneurshipVC = [ZMEntrepreneurshipViewController2 new];
    
    UINavigationController *homeNavVC = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    UINavigationController *shoppingCartNavVC = [[UINavigationController alloc] initWithRootViewController:orderViewController];
    UINavigationController *mineNavVC = [[UINavigationController alloc] initWithRootViewController:mineViewController];
    UINavigationController *entrepreneureshipNav = [[UINavigationController alloc] initWithRootViewController:entrepreneurshipVC];
    
    self.viewControllers = @[homeNavVC, entrepreneureshipNav, shoppingCartNavVC, mineNavVC];

    self.tabBar.tintColor = RGBCOLOR(245, 50, 109);
    [self.tabBarController setSelectedIndex:0];
    
    UITabBarItem* item = [UITabBarItem appearance];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} forState:UIControlStateSelected];

    //home
    {
        UITabBarItem* item = self.tabBar.items[0];
        
        item.image = [UIImage imageNamed:@"tab_bar_home_normal"];
        item.selectedImage = [UIImage imageNamed:@"tab_bar_home_select"];
        
        item.title = @"首页";
    }
    
    // 全民创业
    {
        UITabBarItem *item = self.tabBar.items[1];
        item.image = [UIImage imageNamed:@"startup_normal"];
        item.selectedImage = [UIImage imageNamed:@"startup_pressed"];
        item.title = @"全民创业";
        
        
    }
    
    //order
    {
        UITabBarItem* item = self.tabBar.items[2];
        item.image = [UIImage imageNamed:@"tab_bar_order_normal"];
        item.selectedImage = [UIImage imageNamed:@"tab_bar_order_select"];
        item.title = @"购物车";
    }
    
    //mine
    {
        UITabBarItem* item = self.tabBar.items[3];
        item.image = [UIImage imageNamed:@"tab_bar_mine_normal"];
        item.selectedImage = [UIImage imageNamed:@"tab_bar_mine_select"];
        item.title = @"个人中心";
    }
}

@end
