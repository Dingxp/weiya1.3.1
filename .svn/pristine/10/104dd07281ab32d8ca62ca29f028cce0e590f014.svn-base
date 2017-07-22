//
//  DownTownPickerView.h
//  yunqiphone
//
//  Created by 旭朋  丁 on 14/11/15.
//  Copyright (c) 2014年 ci123.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DownTownPickerView;

@protocol DownTownPickerDelegate <NSObject>

@optional
- (void)areaPickerDidChange:(DownTownPickerView *)picker;

@end

@interface DownTownPickerView : UIPickerView<
UIPickerViewDataSource,
UIPickerViewDelegate
>
@property (strong, nonatomic) NSArray *provinceArr;
@property (nonatomic,assign)id <DownTownPickerDelegate> areaDelegate;
@property (nonatomic,retain)NSArray *provinceData;
@property (nonatomic,retain)NSArray *cityData;
@property (nonatomic,retain)NSArray *townData;

@property (nonatomic,retain)NSString *province;
@property (nonatomic,retain)NSString *city;
@property (nonatomic,retain)NSString *town;
@property (nonatomic,retain)NSString *provinceID;
@property (nonatomic,retain)NSString *cityID;
@property (nonatomic,retain)NSString *townID;
@property (nonatomic,assign)NSInteger rowForProvince;
@property (nonatomic,assign)NSInteger rowForCity;
@property (nonatomic,assign)NSInteger rowForTown;

- (id)initWithFrame:(CGRect)frame withArea:(NSString *)area delegate:(id <DownTownPickerDelegate>)delegate;

@end