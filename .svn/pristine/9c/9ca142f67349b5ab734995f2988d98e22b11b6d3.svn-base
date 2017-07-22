//
//  ZMchannelOneShopViewController.m
//  WY4iPhone
//
//  Created by 丁旭朋 on 15/11/23.
//  Copyright © 2015年 mx. All rights reserved.
//

#import "ZMchannelOneShopViewController.h"
#import "BaseRequest.h"
#import "ZMChannelItem.h"
@interface ZMchannelOneShopViewController ()
{
    NSString*proid;
    NSString*bandName;
}
@end

@implementation ZMchannelOneShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(245, 50, 109);;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  根据频道项ID查询该频道项下面的商品列表,查询某个活动下包含的明细列表
 *
 *  @param cItemId 频道项ID
 */
- (void) requestChannelDetailByChannelItemId:(NSString *) cItemId{
    NSString*url=[NSString stringWithFormat:@"app/crm/channel/%@/findCtxByCiId.do",ppVersion];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:cItemId forKey:@"cItemId"];
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
       // NSLog(@"channel item:%@", responseObject);
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"])
        {
            NSArray*arr=responseObject[@"result"];
            proid=arr[0][@"proId"];
            NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
            NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
          ZMUser*  user=[ZMUser userWithDict:userDic];            [self requestProDetailById:proid userId:user.userId];
            self.navigationItem.title=arr[0][@"bandName"];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:responseObject[@"result"]];
        }
        
    } failure:^(NSError *error) {
               NSLog(@"error:%@", [error localizedDescription]);
    }];
}
@end
