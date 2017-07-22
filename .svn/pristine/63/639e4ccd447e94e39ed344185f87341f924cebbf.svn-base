//
//  ZMProvinceTableView.m
//  WY4iPhone
//
//  Created by ZM21 on 15/9/27.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "ZMProvinceTableView.h"
#import "ZMProvinceTableViewCell.h"

@interface ZMProvinceTableView (){
    
}

@end

@implementation ZMProvinceTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initView];
    }
    return self;
}

- (void) initView{
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
    self.delegate = self;
    self.dataSource = self;
    
    [self selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    _curSelectedIndex = [NSIndexPath indexPathForRow:0 inSection:0];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _provinceList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *province = _provinceList[indexPath.row];
    static NSString *identified = @"provinceCell";
    ZMProvinceTableViewCell *cell = [self dequeueReusableCellWithIdentifier:identified];
    if (!cell) {
        cell = [[ZMProvinceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identified];
    }
    cell.labelProvince.text = province[@"state"];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath == _curSelectedIndex) {
        return;
    }
    
    ZMProvinceTableViewCell *cell = (ZMProvinceTableViewCell *)[self cellForRowAtIndexPath:indexPath];
    ZMProvinceTableViewCell *preCell = (ZMProvinceTableViewCell *)[self cellForRowAtIndexPath:_curSelectedIndex];
    [preCell setSelected:NO];
    [cell setSelected:YES];
    _curSelectedIndex = indexPath;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
