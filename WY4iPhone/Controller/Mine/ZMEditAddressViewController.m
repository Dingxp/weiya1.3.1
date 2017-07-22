//
//  ZMEditAddressViewController.m
//  WY4iPhone
//
//  Created by ZM21 on 15/10/4.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMEditAddressViewController.h"

@interface ZMEditAddressViewController ()

@end

@implementation ZMEditAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"地址管理";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(APP_SCREEN_WIDTH-60, 10, 40, 40);
    [button setTitle:@"删除" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(deleteAdress) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = leftItem;
    [self refreshView];
}

- (void) refreshView{
    self.tfName.text = _editAddress.consignee;
    self.tfTelNo.text = _editAddress.telNo;
    self.tfProvinceCity.text = [NSString stringWithFormat:@"%@ - %@ - %@", _editAddress.addrProvince, _editAddress.addrCity, _editAddress.addrArea];
    self.tfDetailAddress.text = _editAddress.addr;
    self.tfIDcard.text=_editAddress.shenfenID;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnSaveClicked:(UIButton *)button{
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
   ZMUser* user=[ZMUser userWithDict:userDic];
    
    if ([self.tfName.text isEmpty] || [self.tfProvinceCity.text isEmpty] || [self.tfTelNo.text isEmpty] || [self.tfDetailAddress.text isEmpty] ) {
        [SVProgressHUD showInfoWithStatus:@"请将信息填写完整"];
        return;
    }
    if ([self.AddressProvince isEmpty] || [self.AddressCity isEmpty] || [self.AddressArea isEmpty] || self.AddressProvince == NULL || self.AddressCity== NULL || self.AddressArea == NULL) {
        //        [SVProgressHUD showInfoWithStatus:@"请将城市信息填写完整"];
        [self requestUpdateAddressByRegUserId:user.userId consignee:self.tfName.text telNo:self.tfTelNo.text addrProvince:_editAddress.addrProvince addrCity:_editAddress.addrCity addrArea:_editAddress.addrArea addr:self.tfDetailAddress.text zipCode:@"210000" isDefault:_editAddress.isDefault addressId:_editAddress.addressId];
        return;
    }
    
    [self requestUpdateAddressByRegUserId:user.userId consignee:self.tfName.text telNo:self.tfTelNo.text addrProvince:self.AddressProvince addrCity:self.AddressCity addrArea:self.AddressArea addr:self.tfDetailAddress.text zipCode:@"210000" isDefault:_editAddress.isDefault addressId:_editAddress.addressId];
}
-(void)deleteAdress
{
    NSString *cachePath1 = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath1];
  ZMUser*  user=[ZMUser userWithDict:userDic];
    [self requestDelegateAddressListByUserID:user.userId];
}
/**
 *  编辑收货地址
 *
 *  @param regUserId    会员ID
 *  @param consignee    收货人
 *  @param telNo        收货人电话
 *  @param addrProvince 省
 *  @param addrCity     市
 *  @param addrArea     区
 *  @param addr         详细地址
 *  @param zipCode      邮编
 *  @param isDefault    是否默认
 */
- (void) requestUpdateAddressByRegUserId:(NSString *)regUserId consignee:(NSString *)consignee telNo:(NSString *)telNo addrProvince:(NSString *)addrProvince addrCity:(NSString *)addrCity addrArea:(NSString *)addrArea addr:(NSString *)addr zipCode:(NSString *)zipCode isDefault:(NSString *)isDefault addressId:(NSString *)addressId{
    NSString *url = @"app/crm/addr/updateAddr.do";
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:regUserId forKey:@"regUserId"];
    [params setValue:consignee forKey:@"consignee"];
    [params setValue:telNo forKey:@"telNo"];
    [params setValue:addrProvince forKey:@"addrProvince"];
    [params setValue:addrCity forKey:@"addrCity"];
    [params setValue:addrArea forKey:@"addrArea"];
    [params setValue:addr forKey:@"addr"];
    [params setValue:zipCode forKey:@"zipCode"];
    //    [params setValue:isDefault forKey:@"isDefault"];
    [params setValue:addressId forKey:@"id"];
    [params setValue:self.tfIDcard.text forKey:@"identityCard"];
    
    if (self.indicatorImageView.selected==YES)
    {
        [params setValue:@"1" forKey:@"isDefault"];
        
    }
    else
    {
        [params setValue:@"0" forKey:@"isDefault"];
    }
    
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        if ([responseObject[@"statu"] isEqualToString:@"true"]&&responseObject[@"result"]) {
            NSString *cachePath = [HomeDirectory stringByAppendingString:kUserInfoPath];
            NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath];
            NSDictionary*dict=userDic[@"addr"];
            NSString*str=dict[@"id"];
            NSString*addStr=[NSString stringWithFormat:@"%ld",(long)[str integerValue]];
            if (self.indicatorImageView.selected==YES)
            {
                [userDic setValue:params forKey:@"addr"];
                [self writeToCachePath:userDic];
            }
            
            if ([addStr isEqualToString:addressId])
            {
                [userDic setValue:params forKey:@"addr"];
                [self writeToCachePath:userDic];
                
            }
            [SVProgressHUD showSuccessWithStatus:responseObject[@"result"]];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"result"]];
        }
    } failure:^(NSError *error) {
        //        NSLog(@"error:%@", [error localizedDescription]);
    }];
}
/**
 *  删除收货地址列表
 *
 *  @param userId 会员ID
 */
- (void) requestDelegateAddressListByUserID:(NSString *)userId{
    //    [_addressList removeAllObjects];
    NSString *url = @"app/crm/addr/deleteAddr.do";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:userId forKey:@"regUserId"];
    [params setValue:_editAddress.addressId forKey:@"addrId"];
    [[BaseRequest sharedInstance] request:url parameters:params success:^(id responseObject) {
        if ([responseObject[@"statu"] isEqualToString:@"true"]) {
            NSString *cachePath = [HomeDirectory stringByAppendingString:kUserInfoPath];
            NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:cachePath];
            NSDictionary*dict=userDic[@"addr"];
            NSString*str=dict[@"id"];
            NSString*addStr=[NSString stringWithFormat:@"%ld",(long)[str integerValue]];
            if ([addStr isEqualToString:_editAddress.addressId])
            {
                [userDic removeObjectForKey:@"addr"];
                [self writeToCachePath:userDic];
                
            }
            
            [SVProgressHUD showErrorWithStatus:responseObject[@"result"]];
            [self.navigationController popViewControllerAnimated:YES];
            return ;
        }
        
        // NSLog(@"address:%@", responseObject[@"result"]);
        
        
        // NSLog(@"==地址%@",_addressList);
        
    } failure:^(NSError *error) {
        
    }];
    
}
//数据写入缓存
- (void)writeToCachePath:(id)cacheData {
    NSString *path = [HomeDirectory stringByAppendingString:kUserInfoPath];
    [cacheData writeToFile:path atomically:YES];
}
//删除本地存的用户信息
-(void)deleteUserInfo
{
    NSString *cachePath = [HomeDirectory stringByAppendingString:kUserInfoPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:cachePath error:nil];
    
}

@end
