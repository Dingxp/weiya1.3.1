//
//  DownTownPickerView.m
//  yunqiphone
//
//  Created by 旭朋  丁 on 14/11/15.
//  Copyright (c) 2014年 ci123.com. All rights reserved.
//

#import "DownTownPickerView.h"

@implementation DownTownPickerView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withArea:(NSString *)area delegate:(id <DownTownPickerDelegate>)delegate
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        [self setBackgroundColor:RGBCOLOR(240, 240, 240)];
        self.dataSource = self;
        self.delegate = self;
        self.areaDelegate = delegate;
        self.rowForProvince = 0;
        self.rowForCity = 0;
        self.rowForTown=0;
        [self setAccessibilityLanguage:@"Chinese"];
        
        
       }
    [self selectRow:self.rowForProvince inComponent:0 animated:NO];
    [self selectRow:self.rowForCity inComponent:1 animated:NO];
    [self selectRow:self.rowForTown inComponent:2 animated:NO];
    return self;
}
-(void)setProvinceArr:(NSArray *)provinceArr
{
    _provinceArr=provinceArr;
}
#pragma mark - PickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return [_provinceData count];
    }else if(component == 1){
        return [_cityData count];
    }else{
        return [_townData count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return _provinceData[row][@"name"];
    }else if(component == 1){
        return _cityData[row][@"name"];
    }else{
        return _townData[row][@"name"];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        _rowForProvince = row;
        _cityData = _provinceData[row][@"city"];
        _townData = _cityData[0][@"city"];
        [self selectRow:0 inComponent:1 animated:NO];
        [self selectRow:0 inComponent:2 animated:NO];
        [self reloadComponent:1];
        [self reloadComponent:2];
        if ([_townData count]==0) {
            _province = _provinceData[row][@"name"];
            _city = _cityData[0][@"name"];
            _town = @"";
            _provinceID = _provinceData[row][@"id"];
            _cityID = _cityData[0][@"id"];
            _townID = @"";
        }
        else{
        _province = _provinceData[row][@"name"];
        _city = _cityData[0][@"name"];
        _town = _townData[0][@"name"];
        _provinceID = _provinceData[row][@"id"];
        _cityID = _cityData[0][@"id"];
        _townID = _townData[0][@"id"];
        }
    }else if(component==1){
        _rowForCity = row;
        _townData = _cityData[row][@"city"];
        [self selectRow:0 inComponent:2 animated:NO];
        [self reloadComponent:1];
        [self reloadComponent:2];
        if ([_townData count]==0) {
            _city = _cityData[row][@"name"];
            _town = @"";
            _cityID = _cityData[row][@"id"];
            _townID = @"";
        }
        else{
            _city = _cityData[row][@"name"];
            _town = _townData[0][@"name"];
            _cityID = _cityData[row][@"id"];
            _townID = _townData[0][@"id"];
        }
    }else {
        _rowForTown = row;
        _town = _townData[row][@"name"];
        _townID = _townData[row][@"id"];
    }
    if([_areaDelegate respondsToSelector:@selector(areaPickerDidChange:)]) {
        [_areaDelegate areaPickerDidChange:self];
    }
}

@end
