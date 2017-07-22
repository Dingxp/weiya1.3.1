//
//  ZMAddAddressViewController.h
//  WY4iPhone
//
//  Created by ZM21 on 15/9/27.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownTownPickerView.h"
#import "ZMAddProvinceViewController.h"
#import "ZMAddress.h"
#import "BaseRequest.h"
#import "ZMUser.h"

@interface ZMAddAddressViewController : UIViewController <DownTownPickerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) UITextField *tfName;
@property (nonatomic, strong) UITextField *tfTelNo;
@property (nonatomic, strong) UITextField *tfProvinceCity;
@property (nonatomic, strong) UITextField *tfDetailAddress;
@property (nonatomic, strong) UITextField * tfIDcard;
@property (nonatomic,strong) UIButton *indicatorImageView;
@property (nonatomic,strong) UIPickerView *dataPicker;
@property (strong, nonatomic) NSArray *provinceArr;
@property (strong, nonatomic) NSString*AddressProvince;
@property (strong, nonatomic)NSString*AddressCity;
@property (strong, nonatomic) NSString*AddressArea;
- (void) btnSaveClicked:(UIButton *)button;

@end
