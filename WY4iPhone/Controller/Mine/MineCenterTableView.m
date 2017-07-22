//
//  MineCenterTableView.m
//  WY4iPhone
//
//  Created by 旭朋  丁 on 15/9/11.
//  Copyright (c) 2015年 mx. All rights reserved.
//

#import "MineCenterTableView.h"
#import "BaseRequest.h"
#import "MineCenterTableViewCell.h"
#import "ZMUser.h"
#import "UMSocial.h"

@implementation MineCenterTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
            [self setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
            [self setLayoutMargins:UIEdgeInsetsZero];
        }
        
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else{
        return 5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 3;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *systemidentify = @"systemCell";
    MineCenterTableViewCell *cell = [self dequeueReusableCellWithIdentifier:systemidentify];
    if (cell == nil) {
        cell = [[MineCenterTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:systemidentify];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        // 置顶Cell的分割线
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
        
    }
    if (indexPath.section == 0) {
        if (indexPath.row==0)
        {
            cell.textLab.text=@"我的收藏";
            cell.backImage.image=[UIImage imageNamed:@"x6"];
        }
        if (indexPath.row == 1) {
            cell.textLab.text = @"我的现金券";
            cell.detailTextLabel.attributedText = [self parserString:@"" withContentStr:[NSString stringWithFormat:@"%ld", (long)_couponNum] endString:@"张可用"];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
            cell.backImage.image=[UIImage imageNamed:@"x8"];
            
        }
        if (indexPath.row == 2) {
            cell.textLab.text = @"收货地址";
            cell.backImage.image=[UIImage imageNamed:@"x7"];
            
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLab.text = @"用户反馈";
            cell.backImage.image=[UIImage imageNamed:@"x2"];
            
        }
        if (indexPath.row == 1) {
            cell.textLab.text = @"客服电话";
            cell.detailTextLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.text = _phoneNum;
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
            cell.backImage.image=[UIImage imageNamed:@"x4"];
            
        }
        if (indexPath.row==2)
        {
            cell.textLab.text=@"邀请好友";
            cell.backImage.image=[UIImage imageNamed:@"x3"];
            
            
            
        }
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_mineCenterCellDelegate && [_mineCenterCellDelegate respondsToSelector:@selector(mineCenterTableView:didSelectedAtIndex:)]) {
        [_mineCenterCellDelegate mineCenterTableView:self didSelectedAtIndex:indexPath];
    }
}

/**
 *  富文本，拼接字符串
 *
 *  @param preStr 待拼接的字符串1
 *  @param str    待拼接的字符串2
 *
 *  @return 拼接好的字符串
 */
- (NSMutableAttributedString *) parserString:(NSString *)preStr withContentStr:(NSString *)str endString:(NSString *)endStr{
    NSString *postStr = [NSString stringWithFormat:@"%@%@%@", preStr, str, endStr];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:postStr];
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:RGBCOLOR(253, 0, 76)
                       range:NSMakeRange(preStr.length, str.length)];
    return attrString;
}
@end
